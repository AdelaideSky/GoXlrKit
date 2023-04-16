//
//  Daemon.swift
//  
//
//  Created by Adélaïde Sky on 27/12/2022.
//

import Foundation
import Starscream
import SwiftUI
import SwiftyJSON
import os

public struct Daemon {
    
    var daemonProcess = Process()
    public var daemonStatus: DaemonStatus = .stopped
    
    
    public enum daemonArguments: String, CaseIterable, Codable {
        case noHttp = "--http-disable"
        case enableCors = "--http-enable-cors"
        case httpPort = "--http-port"
        case logLevel = "--log-level"
        case noMenubarIcon = "--disable-tray"
        case startUI = "--start-ui"
        case bindAddress = "--http-bind-address"
    }
    public enum logLevels: String, CaseIterable, Codable {
        case off
        case error
        case warn
        case info
        case debug
        case trace
    }
    public enum DaemonStatus: String, CaseIterable, Codable {
        case stopped
        case launching
        case running
        case error
    }
    
    public mutating func start(args: [daemonArguments.RawValue]?) {
        
        let daemonPath = Bundle.module.url(forResource: "goxlr-daemon", withExtension: "")
        daemonProcess.executableURL = daemonPath!
        if args != nil {
            daemonProcess.arguments = args
        }
        self.daemonStatus = .launching
        do {
            try daemonProcess.run()
        } catch {
            print(error)
            self.daemonStatus = .error
            return
        }
        self.daemonStatus = .running
    }
    
    public mutating func stop() {
        daemonProcess.interrupt()
        self.daemonStatus = .stopped
        daemonProcess = Process()
    }
    
    public mutating func restart(args: [daemonArguments.RawValue]?) {
        daemonProcess.interrupt()
        self.daemonStatus = .stopped
        daemonProcess = Process()
        self.start(args: args)
    }
}

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
    
    public func connect(host: String = "localhost", port: Int = 14564) {
        var request = URLRequest(url: URL(string: "http://\(host):\(port)/api/websocket")!)
        request.timeoutInterval = 5
        self.socket = WebSocket(request: request)
        socket?.delegate = self
        self.socketConnexionStatus = .connecting
        socket?.connect()
    }
    
    public func disconnect() {
        socket?.disconnect()
    }
    public func sendCommand(string: String) {
        socket?.write(string: string, completion: {
            if GoXlr.shared.logLevel == .debug {
                Logger().debug("Sent command: \(string)")
            }
        })
    }
    public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            self.socketConnexionStatus = .connected
            Logger().info("Daemon websocket is connected: \(headers)")
            socket?.write(string: "{\"id\": 0, \"data\": \"GetStatus\"}") {}
        case .disconnected(let reason, let code):
            self.socketConnexionStatus = .disconnected
            Logger().info("Daemon websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            if string.contains("Status") {
                if GoXlr.shared.logLevel == .debug {
                    Logger().debug("Recived status: \(string)")
                }
                do {
                    GoXlr.shared.status = try JSONDecoder().decode(Status.self, from: string.data(using: .utf8)!)
                } catch {
                    Logger().error("\(error)")
                }
                GoXlr.shared.device = GoXlr.shared.status?.data.status.mixers.first?.key ?? ""
            } else {
                if !self.holdUpdates {
                    let json = JSON(parseJSON: string)
                    for patch in json["data"]["Patch"].arrayValue {
                        if patch["path"].stringValue.starts(with: "/mixers/") {
                            let device = patch["path"].stringValue.components(separatedBy: "/")[2]
                            do {
                                var statusJSON = try JSON(data: try JSONEncoder().encode(GoXlr.shared.status!.data.status.mixers[device]!))
                                
                                statusJSON[Array(patch["path"].stringValue.components(separatedBy: "/").dropFirst(3))] = patch["value"]
                                GoXlr.shared.status!.data.status.mixers[device]! = try JSONDecoder().decode(Mixer.self, from: try statusJSON.rawData())
                            } catch let error {
                                Logger().error("\(error)")
                            }
                        } else {
                            do {
                                var statusJSON = try JSON(data: try JSONEncoder().encode(GoXlr.shared.status!.data.status))
                                statusJSON[Array(patch["path"].stringValue.components(separatedBy: "/"))] = patch["value"]
                                GoXlr.shared.status!.data.status = try JSONDecoder().decode(StatusClass.self, from: try statusJSON.rawData())
                            } catch let error {
                                Logger().error("\(error)")
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
        case .error(let error):
            self.socketConnexionStatus = .error
            Logger().error("\(error)")
        }
    }
}
