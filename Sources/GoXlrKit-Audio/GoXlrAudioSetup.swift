//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SimplyCoreAudio
import SwiftUI
import os

public enum GoXlrModel: String {
    case Mini = "GoXLRMini"
    case Full = "GoXLR"
}


public enum Aggregate: String, CaseIterable {
    case system = "com.adecorp.goxlr.audio-device.system:"
    case game = "com.adecorp.goxlr.audio-device.game:"
    case chat = "com.adecorp.goxlr.audio-device.chat:"
    case music = "com.adecorp.goxlr.audio-device.music:"
    case broadcastMix = "com.adecorp.goxlr.audio-device.broadcastmix:"
    case chatMix = "com.adecorp.goxlr.audio-device.chatmix:"
    
    case sample1 = "com.adecorp.goxlr.audio-device.sample1:"
    case sample2 = "com.adecorp.goxlr.audio-device.sample2:"
}
extension Aggregate {
    var displayName: String {
        switch self {
        case .system:
            return "System"
        case .game:
            return "Game"
        case .chat:
            return "Chat"
        case .music:
            return "Music"
        case .broadcastMix:
            return "Broadcast Mix"
        case .chatMix:
            return "Chat Mix"
        case .sample1:
            return "Sample"
        case .sample2:
            return "Sample"
        }
    }
    
    var isOutput: Bool {
        switch self {
        case .broadcastMix:
            return false
        case .chatMix:
            return false
        case .sample2:
            return false
        default:
            return true
        }
    }
}

public class GoXlrAudioSetup {
    private var simplyCA = SimplyCoreAudio()
    
    public func createAggregates(_ model: GoXlrModel, serial: String) {
        let listdevices = simplyCA.allNonAggregateDevices
        
        if let device = listdevices.filter({$0.name == model.rawValue}).first {
            
            Logger().debug("Found device \(device.description), configuring aggregates...")
            Logger().info("Started the creation of GoXLR aggregate devices.")
            
            for aggregateType in Aggregate.allCases {
                guard model != .Mini || (aggregateType != .sample1 || aggregateType != .sample2) else { break }
                
                let uid = aggregateType.rawValue+serial
                
                Logger().info("Setting up device \(aggregateType.displayName)")
                
                let aggregate = simplyCA.createAggregateDevice(mainDevice: device, secondDevice: nil, named: aggregateType.displayName, uid: uid)
                
                guard aggregate != nil else {
                    Logger().error("Failed to setup device \(uid)")
                    break
                }
                
                aggregate?.setPreferedChannels(aggregateType)
                
                GoXlrAudio.shared.managedAggregates.insert(.init(uid: aggregate!.uid ?? aggregateType.rawValue, name: aggregate!.name, type: aggregateType, deviceModel: model))
            }
            Logger().debug("Found device \(device.description), configuring aggregates...")
        }
    }
}

extension AudioDevice {
    func setPreferedChannels(_ type: Aggregate) {
        if type.isOutput {
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 0, right: 0), scope: .input)
        } else {
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 0, right: 0), scope: .output)
        }
        switch type {
        case .system:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 1, right: 2), scope: .output)
        case .game:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 3, right: 4), scope: .output)
        case .chat:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 5, right: 6), scope: .output)
        case .music:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 7, right: 8), scope: .output)
        case .sample1:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 9, right: 10), scope: .output)
        case .broadcastMix:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 1, right: 2), scope: .input)
        case .chatMix:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 3, right: 4), scope: .input)
        case .sample2:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 5, right: 6), scope: .input)
        }
    }
}
