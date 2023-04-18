//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 18/04/2023.
//

import Foundation
import SwiftUI

extension ChannelName {
    var icon: String {
        switch self {
        case .Mic:
            return "mic"
        case .LineIn:
            return "chevron.backward.to.line"
        case .Console:
            return "rectangle.on.rectangle"
        case .System:
            return "menubar.dock.rectangle"
        case .Game:
            return "gamecontroller"
        case .Chat:
            return "speaker.wave.2.bubble.left"
        case .Sample:
            return "speaker.wave.2.bubble.left"
        case .Music:
            return "music.note"
        case .Headphones:
            return "headphones"
        case .MicMonitor:
            return "mic.and.signal.meter"
        case .LineOut:
            return "chevron.right.to.line"
        }
    }
}
