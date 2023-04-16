import Foundation
import Starscream
import SwiftyJSON
import RegexBuilder


public class GoXlr: ObservableObject {
    
    public static var shared: GoXlr = {
        return GoXlr()
    }()
    
    @Published public var status: Status? = nil
    public var holdUpdates: Bool = false
        
    public var daemon = Daemon()
    
    public var socket = DaemonWSocket()
    
    public var device = ""
    
    public var logLevel: GoXlrLogLevel = .info
    
    public func startObserving() {
        Task {
            self.daemon.start(args: nil)
            sleep(2)
            self.socket.connect()
        }
    }
    public func stopObserving() {
        Task {
            self.socket.disconnect()
            self.daemon.stop()
        }
    }
    
    public func command(_ command: GoXLRCommand) {
        do {
            let command = String(data: try JSONEncoder().encode(command), encoding: .utf8)
            let firstRegex = #/\"_[0-9]\":/#
            let secondRegex = #/\":{/#
            let thirdRegex = #/}}/#
            if let commandString = command?.replacing(firstRegex, with: "").replacing(secondRegex, with: "\":[").replacing(thirdRegex, with: "]}") {
                self.socket.sendCommand(string: "{\"id\": 0, \"data\": {\"Command\": [\"\(self.device)\", "+commandString+"]}}")
            }
        } catch {}
    }
    
    public init() {}
    
    public enum GoXlrLogLevel {
        case none
        case info
        case debug
    }
}
