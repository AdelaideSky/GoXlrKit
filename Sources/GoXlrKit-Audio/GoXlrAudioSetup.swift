//
//  GoXlrAudioSetup.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SimplyCoreAudio
import SwiftUI
import os

public enum GoXlrModel: String, Codable {
    case Mini = "GoXLRMini"
    case Full = "GoXLR"
}


public enum Aggregate: String, CaseIterable, Codable {
    case system = "com.adecorp.goxlr.audio-device.system:"
    case game = "com.adecorp.goxlr.audio-device.game:"
    case chat = "com.adecorp.goxlr.audio-device.chat:"
    case music = "com.adecorp.goxlr.audio-device.music:"
    case broadcastMix = "com.adecorp.goxlr.audio-device.broadcastmix:"
    case chatMic = "com.adecorp.goxlr.audio-device.chatmix:"
    
    case sample = "com.adecorp.goxlr.audio-device.sample:"
    case sampler = "com.adecorp.goxlr.audio-device.sampler:"
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
            return "Broadcast Mic"
        case .chatMic:
            return "Chat Mic"
        case .sample:
            return "Sample"
        case .sampler:
            return "Sampler"
        }
    }
    
    var isOutput: Bool {
        switch self {
        case .broadcastMix:
            return false
        case .chatMic:
            return false
        case .sampler:
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
                guard model != .Mini || (aggregateType != .sample || aggregateType != .sampler) else { break }
                
                let uid = aggregateType.rawValue+serial
                
                Logger().info("Setting up device \(aggregateType.displayName)")
                
                let aggregate = simplyCA.createAggregateDevice(mainDevice: device, secondDevice: nil, named: aggregateType.displayName, uid: uid)
                
                guard aggregate != nil else {
                    Logger().error("Failed to setup device \(uid)")
                    break
                }
                
                if aggregate!.setPreferedChannels(aggregateType) {
                    GoXlrAudio.shared.managedAggregates.insert(.init(aggregate!.uid ?? aggregateType.rawValue, name: aggregate!.name, type: aggregateType, deviceModel: model, scope: .input))
                } else {
                    GoXlrAudio.shared.managedAggregates.insert(.init(aggregate!.uid ?? aggregateType.rawValue, name: aggregate!.name, type: aggregateType, deviceModel: model, scope: .output))
                }
                
                
            }
            Logger().debug("Found device \(device.description), configuring aggregates...")
        }
    }
}

extension AudioDevice {
    func setPreferedChannels(_ type: Aggregate) -> Bool {
        // bool is true: input, false: output
        switch type {
        case .system:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 1, right: 2), scope: .output)
        case .game:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 3, right: 4), scope: .output)
        case .chat:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 5, right: 6), scope: .output)
        case .music:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 7, right: 8), scope: .output)
        case .sample:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 9, right: 10), scope: .output)
        case .broadcastMix:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 1, right: 2), scope: .input)
        case .chatMic:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 3, right: 4), scope: .input)
        case .sampler:
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 5, right: 6), scope: .input)
        }
        if type.isOutput {
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 0, right: 0), scope: .input)
            return false
        } else {
            self.setPreferredChannelsForStereo(channels: StereoPair(left: 0, right: 0), scope: .output)
            return true
        }
    }
}
