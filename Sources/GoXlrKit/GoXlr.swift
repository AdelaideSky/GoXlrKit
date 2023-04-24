import Foundation
import SwiftUI
import Starscream
import SwiftyJSON
import RegexBuilder

/**
 GoXlr class. You can either initialise it or use the `shared` instance.
 This class conforms to ObservableObject.
 */
public class GoXlr: ObservableObject {
    
    public static var shared: GoXlr = {
        return GoXlr()
    }()
    
    @Published public var status: Status? = nil
    public var mixer: Mixer? {
        get {
            status?.data.status.mixers[device]
        }
        set {
            status?.data.status.mixers[device] = newValue
        }
    }
    public var holdUpdates: Bool = false
        
    public var daemon = Daemon()
    
    public var socket = DaemonWSocket()
    
    @Published public var device = ""
    
    public var logLevel: GoXlrLogLevel = .info
    
    public var utils = GoXlrUtils()
    
    /**
     Starts the daemon and connects to its Websocket.
     *Note: Websocket port is always 14564. The usecase where the daemon websocket isn't at the default port isn't already implemented.*
     */
    public func startObserving() {
        Task {
            self.daemon.start(args: [.noMenubarIcon])
            usleep(500000)
            self.socket.connect()
        }
    }
    /**
     Disconnects from the websocket and shut down the daemon.
     */
    public func stopObserving() {
        Task {
            self.socket.disconnect()
            self.daemon.stop()
        }
    }
    
    /**
     Sends a command to the daemon websocket to the `device` mixer.
     - Parameters:
        - command: The command to send, in `GoXLRCommand` type.
     */
    public func command(_ command: GoXLRCommand) {
        do {
            let commandString = String(data: try JSONEncoder().encode(command), encoding: .utf8)
            let firstRegex = #/\"_[0-9]\":/#
            let secondRegex = #/\":{/#
            let thirdRegex = #/}}/#
            
            switch command {
            case .SetRouter(let inputDevice, let outputDevice, let state):
                self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", {\"SetRouter\": [\"\(inputDevice.rawValue)\", \"\(outputDevice.rawValue)\", \(state)]}]}}")
                return
//            case .SetEncoderColour(let target, let colL, let colR, let colK):
//                self.socket.sendCommand(string: "{\"id\":0,\"data\":{\"Command\":[\"\(self.device)\",{\"SetEncoderColour\":[\"\(target.rawValue)\",\"000000\",\"00FFFF\",\"FFE7F5\"]}]}}")
//                return
//            case .SetFaderColours(let channel, let colA, let colB):
//                self.socket.sendCommand(string: "{\"id\":1,\"data\":{\"Command\":[\"\(self.device)\",{\"SetFaderColours\":[\"\(channel.rawValue)\",\"\(colA)\",\"\(colB)\"]}]}}")
            default:
                break
            }

            if commandString?.components(separatedBy: ",").count ?? 0 > 1 {
                if let commandString = commandString?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":[").replacing(thirdRegex, with: "]}") {
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", "+commandString+"]}}")
                }
            } else {
                if command.commandName == "" {
                    if let commandString = commandString?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":").replacing(thirdRegex, with: "}") {
                        self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", "+commandString+"]}}")
                    }
                } else {
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", {\""+command.commandName+"\":[]}]}}")
                }
            }
        } catch {}
    }
    
    public func command(_ command: DaemonCommand) {
        do {
            let commandString = String(data: try JSONEncoder().encode(command), encoding: .utf8)
            let firstRegex = #/\"_[0-9]\":/#
            let secondRegex = #/\":{/#
            let thirdRegex = #/}}/#

            if commandString?.components(separatedBy: ",").count ?? 0 > 1 {
                if let commandString = commandString?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":[").replacing(thirdRegex, with: "]}") {
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\(commandString)}}")
                }
            } else {
                if command.commandName == "" {
                    if let commandString = commandString?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":").replacing(thirdRegex, with: "}") {
                        self.socket.sendCommand(string: "{\"id\": 0, \"data\": "+commandString+"}")
                    }
                } else {
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\""+command.commandName+"\":[]}}")
                }
            }
            
        } catch {}
    }
    
    public func copyDebugInfo() {
        let returnValue = """
                        ✧──────────────・「 Debug Info 」・──────────────✧
                        
                        ・ Device : \(self.device)
                        
                        ・ Status object : \(self.status.debugDescription)
                        
                        ・ Daemon object : \(self.daemon)
                        
                        ・ WebSocket object : \(self.socket)
                        
                        ✧───────────────────────────────────────────────✧
                        """
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(returnValue, forType: .string)
    }
    
    public init() {}
    
    public enum GoXlrLogLevel {
        case none
        case info
        case debug
    }
}
