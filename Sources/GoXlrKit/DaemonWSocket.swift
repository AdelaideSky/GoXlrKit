//
//  DaemonWSocket.swift
//
//
//  Created by Adélaïde Sky on 16/04/2023.
//

import Foundation
import Starscream
import SwiftyJSON
import os

/**
 Daemon WebSocket manager. Allows control over a goxlr-utility's daemon websocket instance.
 */
public class DaemonWSocket: WebSocketDelegate {
    
    var socketConnexionStatus: SocketConnexionStatus = .disconnected
    var socket: WebSocket? = nil
    @Published public var holdUpdates: Bool = false
    
    public enum SocketConnexionStatus: String, CaseIterable, Codable {
        case disconnected
        case connecting
        case connected
        case error
    }
    
    /**
     Connects to the goxlr-utility's websocket.
     - Parameters:
        - host: Name, as string, of the host. Default is `localhost`
        - port: Port to connect to. Default is `14564`
     */
    public func connect(host: String = "localhost", port: Int = 14564) {
        var request = URLRequest(url: URL(string: "http://\(host):\(port)/api/websocket")!)
        request.timeoutInterval = 5
        
        self.socket = WebSocket(request: request)
        socket?.delegate = self
        self.socketConnexionStatus = .connecting
        socket?.connect()
    }
    
    /**
     Disconnects from the previously connected websocket.
     */
    public func disconnect() {
        guard socket != nil else {
            Logger().error("No socket connected.")
            return
        }
        socket?.disconnect()
        self.socketConnexionStatus = .disconnected

    }
    
    /**
     Sends a string command to the connected websocket.
     */
    public func sendCommand(string: String) {
        guard socket != nil else {
            Logger().error("No socket connected to write to.")
            return
        }
        DispatchQueue(label: "WebSocketManager").async {
            self.socket?.write(string: string, completion: {
                if GoXlr.shared.logLevel == .debug {
                    Logger().debug("Sent command: \(string)")
                }
            })
        }
    }
    /**
     Function responsible for handliing incoming websocket calls.
     */
    public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            self.socketConnexionStatus = .connected
            
            if GoXlr.shared.logLevel == .info {
                Logger().info("Daemon websocket is connected.")
            } else if GoXlr.shared.logLevel == .debug {
                Logger().debug("Daemon websocket is connected: \(headers)")
                Logger().debug("Sending status request...")
            }
            
            socket?.write(string: "{\"id\": 0, \"data\": \"GetStatus\"}") {}
            
        case .disconnected(let reason, let code):
            self.socketConnexionStatus = .disconnected
            Logger().error("Daemon websocket is disconnected: \(reason) with code: \(code)")
            
        case .text(let string):
            DispatchQueue(label: "WebSocketManager").sync {
                
                if string.contains("Status") {
                    if GoXlr.shared.logLevel == .debug {
                        Logger().debug("Recived status: \(string)")
                    } else if GoXlr.shared.logLevel == .info {
                        Logger().info("Recived status from daemon")
                    }
                    
                    do {
                        GoXlr.shared.status = try JSONDecoder().decode(Status.self, from: string.data(using: .utf8)!)
                    } catch {
                        Logger().error("\(error)")
                    }
                    GoXlr.shared.device = GoXlr.shared.status?.data.status.mixers.first?.key ?? ""
                    
                } else {
                    if GoXlr.shared.logLevel == .debug {
                        Logger().debug("Recived non-status string.")
                    }
                    
                    if !self.holdUpdates && GoXlr.shared.status != nil {
                        let json = JSON(parseJSON: string)
                        
                        for patch in json["data"]["Patch"].arrayValue {
                            let path = Array(patch["path"].stringValue.components(separatedBy: "/").dropFirst())
                            
                            if patch["op"].stringValue == "replace" {
                                if patch["path"].stringValue.starts(with: "/mixers/") && path.count > 2 {
                                    if GoXlr.shared.logLevel == .debug {
                                        Logger().debug("Updates are not hold, status isn't nil, decoding as mixer replace patch...")
                                    }
                                    
                                    let device = patch["path"].stringValue.components(separatedBy: "/")[2]
                                    handleMixerPatch(mixer: &GoXlr.shared.status!.data.status.mixers[device]!, path: Array(path.dropFirst(2)), value: patch["value"])
                                    
                                } else {
                                    if GoXlr.shared.logLevel == .debug {
                                        Logger().debug("Updates are not hold, status isn't nil, decoding as status replace patch...")
                                    }
                                    
                                    handleStatusPatch(status: &GoXlr.shared.status!.data.status, path: path, value: patch["value"])
                                }
                                
                            } else if patch["op"].stringValue == "add" {
                                if GoXlr.shared.logLevel == .debug {
                                    Logger().debug("Updates are not hold, status isn't nil, decoding as status add patch...")
                                }
                                handleAddPatch(status: &GoXlr.shared.status!.data.status, path: path, value: patch["value"])
                                
                            } else if patch["op"].stringValue == "remove" {
                                if GoXlr.shared.logLevel == .debug {
                                    Logger().debug("Updates are not hold, status isn't nil, decoding as status remove patch...")
                                }
                                handleRemovePatch(status: &GoXlr.shared.status!.data.status, path: path, value: patch["value"])
                            }
                        }
                    }
                }
            }
        case .binary(let data):
            Logger().info("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            self.socketConnexionStatus = .disconnected
            Logger().error("Websocket cancelled")
        case .error(let error):
            self.socketConnexionStatus = .error
            Logger().critical("\(error)")
        }
    }
}
