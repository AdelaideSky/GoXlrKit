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
    
    @Published public var logLevel: GoXlrLogLevel = .info
    
    public var utils = GoXlrUtils()
    
    // Runs specified shortcut when specified button is pressed
    public var observationStore: Binding<[String : String]>? = nil
    
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
      Alternative for command(.StopDaemon)
     */
    public func stopObserving() {
        Task {
            self.command(.StopDaemon)
            self.socket.disconnect()
            self.daemon.daemonProcess.waitUntilExit()
            self.daemon.daemonStatus = .stopped
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
            let finalRegex = #/\{"\w+":\{/#
            
            switch command {
            case .SetRouter(let inputDevice, let outputDevice, let state):
                self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", {\"SetRouter\": [\"\(inputDevice.rawValue)\", \"\(outputDevice.rawValue)\", \(state)]}]}}")
                return
            case .SetEncoderColour(let target, let colL, let colR, let colK):
                self.socket.sendCommand(string: "{\"id\":0,\"data\":{\"Command\":[\"\(self.device)\",{\"SetEncoderColour\":[\"\(target.rawValue)\",\"\(colL)\",\"\(colR)\",\"\(colK)\"]}]}}")
                return
//            case .SetFaderColours(let channel, let colA, let colB):
//                self.socket.sendCommand(string: "{\"id\":1,\"data\":{\"Command\":[\"\(self.device)\",{\"SetFaderColours\":[\"\(channel.rawValue)\",\"\(colA)\",\"\(colB)\"]}]}}")
            default:
                break
            }

            if commandString?.components(separatedBy: ",").count ?? 0 > 1 {
                var answer = "\(commandString!.firstMatch(of: finalRegex)!.0)".dropLast()+"["
                if commandString!.contains("_0") {
                    answer += (commandString?.split(separator: ",").first(where: { $0.contains("_0") }))!
                        .replacing(firstRegex, with: "")
                        .replacing(thirdRegex, with: "")
                        .replacing(finalRegex, with: "")
                    if commandString!.contains("_1") {
                        answer += ","+(commandString?.split(separator: ",").first(where: { $0.contains("_1") }))!
                            .replacing(firstRegex, with: "")
                            .replacing(thirdRegex, with: "")
                            .replacing(finalRegex, with: "")
                        if commandString!.contains("_2") {
                            answer += ","+(commandString?.split(separator: ",").first(where: { $0.contains("_2") }))!
                                .replacing(firstRegex, with: "")
                                .replacing(thirdRegex, with: "")
                                .replacing(finalRegex, with: "")
                            if commandString!.contains("_3") {
                                answer += ","+(commandString?.split(separator: ",").first(where: { $0.contains("_3") }))!
                                    .replacing(firstRegex, with: "")
                                    .replacing(thirdRegex, with: "")
                                    .replacing(finalRegex, with: "")
                            }
                        }
                    }
                }
                answer+="]}"

                self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", "+answer+"]}}")
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
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Daemon\": {\(commandString)}}}")
                }
            } else {
                if command.commandName == "" {
                    if let commandString = commandString?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":").replacing(thirdRegex, with: "}") {
                        self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Daemon\": {"+commandString+"}}}")
                    }
                } else {
                    self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Daemon\":{\"\(command.commandName)\"}}}")
                }
            }
            
        } catch {}
    }
    
    public func copyDebugInfo() {
        var statusObject: String {
            do {
                if let returnString = String(data: try JSONEncoder().encode(self.status), encoding: .utf8) {
                    return returnString
                } else {
                    return "Error translating JSON data to string, description: \(self.status.debugDescription)"
                }
            } catch let error {
                return "Couldn't JSONEncode with error: \(error)"
            }
        }
        let returnValue = """
                        ✧──────────────・「 Debug Info 」・──────────────✧
                        
                        ・ Device : \(self.device)
                        
                        ・ Status object : \(statusObject)
                        
                        ・ Daemon object : \(self.daemon)
                        
                        ・ WebSocket object : \(self.socket)
                        
                        ✧───────────────────────────────────────────────✧
                        """
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(returnValue, forType: .string)
    }
    
    public enum profilesubfolders: String {
        case profiles
        case micprofiles = "mic-profiles"
        case presets
        case samples
        case icons
    }
    
    public func importFile(_ url: URL, path: profilesubfolders) {
        let folderName = "org.GoXLR-on-Linux.GoXLR-Utility/\(path.rawValue)/"
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let filePath = tDocumentDirectory.appendingPathComponent("\(folderName)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                    try fileManager.copyItem(at: url, to: filePath.appendingPathComponent("\(url.lastPathComponent)"))
                } catch {print("Couldn't create document directory or can't copy file")}
            }
            do {
                try fileManager.copyItem(at: url, to: filePath.appendingPathComponent("\(url.lastPathComponent)"))
            } catch (let error) {
                print("error on copying file: \(error)")
            }
        }
    }
    
    public init() {}
    
    public enum GoXlrLogLevel {
        case none
        case info
        case debug
    }
}
