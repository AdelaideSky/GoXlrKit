import Foundation
import KeyValueCoding
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
    
    public func startObserving() {
        self.socket.connect()
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
    
//    public mutating func getInformation() {
//        print(self.devices.internalTest.internalValue)
//        self.replace("newValue", key: "/internalTest/internalValue")
//        print(self.devices.internalTest.internalValue)
//    }
//    public mutating func replace(_ value: Any?, key: String) {
//        self.devices.setValue(value, key: key.dropFirst(1).replacingOccurrences(of: "/", with: "."))
//    }
//    public mutating func value(_ key: String) -> Any? {
//        return self.devices.value(key: key.dropFirst(1).replacingOccurrences(of: "/", with: "."))
//    }
}
//
//public class sharedGoXlrStatus: ObservableObject {
//    @Published public var status: Status? = nil
//
//    func clear() {
//        self.status = nil
//
//    }
//}
