//
//  Daemon.swift
//  
//
//  Created by Adélaïde Sky on 27/12/2022.
//

import Foundation
import Starscream
import KeyValueCoding
import SwiftUI
import SwiftyJSON

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
        let daemonPath = Bundle.main.url(forResource: "goxlr-daemon", withExtension: "")
        daemonProcess.executableURL = daemonPath!
        if args != nil {
            daemonProcess.arguments = args
        }
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        daemonProcess.standardOutput = outputPipe
        daemonProcess.standardError = errorPipe
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
        socket?.write(string: string, completion: {print("sent command: \(string)")})
    }
    public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        switch event {
        case .connected(let headers):
            self.socketConnexionStatus = .connected
            print("websocket is connected: \(headers)")
            socket?.write(string: "{\"id\": 0, \"data\": \"GetStatus\"}") {}
        case .disconnected(let reason, let code):
            self.socketConnexionStatus = .disconnected
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            if string.contains("Status") {
                print("status recived")
                do {
                    GoXlr.shared.status = try JSONDecoder().decode(Status.self, from: string.data(using: .utf8)!)
                } catch {
                    print(error)
                }
                GoXlr.shared.device = GoXlr.shared.status?.data.status.mixers.first?.key ?? ""
            } else {
                if !self.holdUpdates {
                    let json = JSON(parseJSON: string)
                    for patch in json["data"]["Patch"].arrayValue {
                        if patch["path"].stringValue.starts(with: "/mixers/") {
                            let keyPath = patch["path"].stringValue.components(separatedBy: "/").dropFirst(3).joined(separator: ".")
                            let device = patch["path"].stringValue.components(separatedBy: "/")[2]
                            print(device)
                            print(keyPath)
                            print(GoXlr.shared.status)
                            GoXlr.shared.status!.data.status.mixers[device]!.setValue(patch["value"].object, key: keyPath)
                        }
                    }
                }
            }
        case .binary(let data):
            print("Received data: \(data.count)")
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
            print(error ?? "error")
        }
    }
}
