//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 19/04/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

public struct Patch<Value> {
    let keyPath: WritableKeyPath<Mixer, Value>
    let value: WritableKeyPath<JSON, Value>
}

public let patchPaths: [String: Patch] = [
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
]
