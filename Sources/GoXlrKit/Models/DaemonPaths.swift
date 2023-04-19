//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 19/04/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import os

public struct Patch<Value> {
    let keyPath: WritableKeyPath<Mixer, Value>
    let value: ((JSON) -> Value)
}

public let floatPaths: [String: Patch] = [
    // MARK: - Volues
    "levels/volumes/System": Patch(keyPath: \.levels.volumes.system, value: \.floatValue),
    "levels/volumes/Mic": Patch(keyPath: \.levels.volumes.mic, value: \.floatValue),
    "levels/volumes/LineIn": Patch(keyPath: \.levels.volumes.lineIn, value: \.floatValue),
    "levels/volumes/Console": Patch(keyPath: \.levels.volumes.console, value: \.floatValue),
    "levels/volumes/Game": Patch(keyPath: \.levels.volumes.game, value: \.floatValue),
    "levels/volumes/Chat": Patch(keyPath: \.levels.volumes.chat, value: \.floatValue),
    "levels/volumes/Sample": Patch(keyPath: \.levels.volumes.sample, value: \.floatValue),
    "levels/volumes/Music": Patch(keyPath: \.levels.volumes.music, value: \.floatValue),
    "levels/volumes/Headphones": Patch(keyPath: \.levels.volumes.headphones, value: \.floatValue),
    "levels/volumes/MicMonitor": Patch(keyPath: \.levels.volumes.micMonitor, value: \.floatValue),
    "levels/volumes/LineOut": Patch(keyPath: \.levels.volumes.lineOut, value: \.floatValue),
    
    // MARK: - FaderStatus
    
    
]
public let channelNamePaths: [String: Patch] = [
    "fader_status/A/channel": Patch(keyPath: \.faderStatus.a.channel, value: { ChannelName(rawValue: $0.stringValue)! }),
    "fader_status/B/channel": Patch(keyPath: \.faderStatus.b.channel, value: { ChannelName(rawValue: $0.stringValue)! }),
    "fader_status/C/channel": Patch(keyPath: \.faderStatus.c.channel, value: { ChannelName(rawValue: $0.stringValue)! }),
    "fader_status/D/channel": Patch(keyPath: \.faderStatus.d.channel, value: { ChannelName(rawValue: $0.stringValue)! }),
]

public let muteFunctionPaths: [String: Patch] = [
    "fader_status/A/mute_type": Patch(keyPath: \.faderStatus.a.muteType, value: { MuteFunction(rawValue: $0.stringValue)! }),
    "fader_status/B/mute_type": Patch(keyPath: \.faderStatus.b.muteType, value: { MuteFunction(rawValue: $0.stringValue)! }),
    "fader_status/C/mute_type": Patch(keyPath: \.faderStatus.c.muteType, value: { MuteFunction(rawValue: $0.stringValue)! }),
    "fader_status/D/mute_type": Patch(keyPath: \.faderStatus.d.muteType, value: { MuteFunction(rawValue: $0.stringValue)! }),
]

public var patchTypes: [String: Any.Type] {
    var answer: [String: Any.Type] = [:]
    
    for path in floatPaths.keys { answer[path] = Float.self }
    for path in channelNamePaths.keys { answer[path] = ChannelName.self }
    for path in muteFunctionPaths.keys { answer[path] = MuteFunction.self }
    
    return answer
}

public func handlePatch(device: String, path: String, value: JSON) {
    guard let type = patchTypes[path] else { return }
    
    if type == Float.self {
        if let path = floatPaths[path] {
            GoXlr.shared.status?.data.status.mixers[device]![keyPath: path.keyPath] = path.value(value)
        } else {
            Logger().error("Not handling patch: device:\(device), path: \(path), value: \(value.stringValue)\nThis patch path needs implementation.")
        }
        
    } else if type == ChannelName.self {
        
        if let path = channelNamePaths[path] {
            GoXlr.shared.status?.data.status.mixers[device]![keyPath: path.keyPath] = path.value(value)
        } else {
            Logger().error("Not handling patch: device:\(device), path: \(path), value: \(value.stringValue)\nThis patch path needs implementation.")
        }
        
    } else if type == MuteFunction.self {
        
        if let path = muteFunctionPaths[path] {
            GoXlr.shared.status?.data.status.mixers[device]![keyPath: path.keyPath] = path.value(value)
        } else {
            Logger().error("Not handling patch: device:\(device), path: \(path), value: \(value.stringValue)\nThis patch path needs implementation.")
        }
        
    } else {
        Logger().error("Not handling patch: device:\(device), path: \(path), value: \(value.stringValue)\nThis patch type needs implementation.")
    }
}
