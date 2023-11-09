//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation
import Patchable

// MARK: - Levels
@Patchable
public final class Levels: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Levels>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.bleep:
            return .SetSwearButtonVolume(Int(newValue as! Float))
        case \.deess:
            return .SetDeeser(Int(newValue as! Float))
        default: return nil
        }
    }
    
    @Published public var submixSupported: Bool
    @child @Published public var volumes: Volumes
    @Published public var bleep: Float
    @Published public var deess: Float
    @child @Published public var submix: Submix?
    
    enum CodingKeys: String, CodingKey {
        case volumes
        case bleep
        case deess
        case submixSupported = "submix_supported"
        case submix
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        submixSupported = try values.decode(Bool.self, forKey: .submixSupported)
        volumes = try values.decode(Volumes.self, forKey: .volumes)
        bleep = try values.decode(Float.self, forKey: .bleep)
        deess = try values.decode(Float.self, forKey: .deess)
        submix = try values.decode(Submix?.self, forKey: .submix)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(submixSupported, forKey: .submixSupported)
        try container.encode(volumes, forKey: .volumes)
        try container.encode(bleep, forKey: .bleep)
        try container.encode(deess, forKey: .deess)
        try container.encode(submix, forKey: .submix)
    }
}

// MARK: - Volumes
@Patchable
public final class Volumes: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Volumes>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.system:
            return .SetVolume(.System, Int(newValue as! Float))
        case \.mic:
            return .SetVolume(.Mic, Int(newValue as! Float))
        case \.lineIn:
            return .SetVolume(.LineIn, Int(newValue as! Float))
        case \.console:
            return .SetVolume(.Console, Int(newValue as! Float))
        case \.game:
            return .SetVolume(.Game, Int(newValue as! Float))
        case \.chat:
            return .SetVolume(.Chat, Int(newValue as! Float))
        case \.sample:
            return .SetVolume(.Sample, Int(newValue as! Float))
        case \.music:
            return .SetVolume(.Music, Int(newValue as! Float))
        case \.headphones:
            return .SetVolume(.Headphones, Int(newValue as! Float))
        case \.micMonitor:
            return .SetVolume(.MicMonitor, Int(newValue as! Float))
        case \.lineOut:
            return .SetVolume(.LineOut, Int(newValue as! Float))
        default: return nil
        }
    }
    
    @Published public var system: Float
    @Published public var mic: Float
    @Published public var lineIn: Float
    @Published public var console: Float
    @Published public var game: Float
    @Published public var chat: Float
    @Published public var sample: Float
    @Published public var music: Float
    @Published public var headphones: Float
    @Published public var micMonitor: Float
    @Published public var lineOut: Float
    
    enum CodingKeys: String, CodingKey {
        case mic = "Mic"
        case lineIn = "LineIn"
        case console = "Console"
        case system = "System"
        case game = "Game"
        case chat = "Chat"
        case sample = "Sample"
        case music = "Music"
        case headphones = "Headphones"
        case micMonitor = "MicMonitor"
        case lineOut = "LineOut"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        system = try values.decode(Float.self, forKey: .system)
        mic = try values.decode(Float.self, forKey: .mic)
        lineIn = try values.decode(Float.self, forKey: .lineIn)
        console = try values.decode(Float.self, forKey: .console)
        game = try values.decode(Float.self, forKey: .game)
        chat = try values.decode(Float.self, forKey: .chat)
        sample = try values.decode(Float.self, forKey: .sample)
        music = try values.decode(Float.self, forKey: .music)
        headphones = try values.decode(Float.self, forKey: .headphones)
        micMonitor = try values.decode(Float.self, forKey: .micMonitor)
        lineOut = try values.decode(Float.self, forKey: .lineOut)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(system, forKey: .system)
        try container.encode(mic, forKey: .mic)
        try container.encode(lineIn, forKey: .lineIn)
        try container.encode(console, forKey: .console)
        try container.encode(game, forKey: .game)
        try container.encode(chat, forKey: .chat)
        try container.encode(sample, forKey: .sample)
        try container.encode(music, forKey: .music)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(micMonitor, forKey: .micMonitor)
        try container.encode(lineOut, forKey: .lineOut)
    }
}
// MARK: - Submix
@Patchable
public class Submix: Codable, ObservableObject {
    @child @Published public var inputs: Inputs
    @child @Published public var outputs: SubmixesOutputs
    
    enum CodingKeys: String, CodingKey {
        case inputs
        case outputs
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(inputs, forKey: .inputs)
        try container.encode(outputs, forKey: .outputs)
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        inputs = try values.decode(Inputs.self, forKey: .inputs)
        outputs = try values.decode(SubmixesOutputs.self, forKey: .outputs)
    }
}

// MARK: - Inputs
@Patchable
public class Inputs: Codable, ObservableObject {
    @child @Published public var mic: SubmixesInputs
    @child @Published public var lineIn: SubmixesInputs
    @child @Published public var console: SubmixesInputs
    @child @Published public var system: SubmixesInputs
    @child @Published public var game: SubmixesInputs
    @child @Published public var chat: SubmixesInputs
    @child @Published public var sample: SubmixesInputs
    @child @Published public var music: SubmixesInputs
    
    enum CodingKeys: String, CodingKey {
        case mic = "Mic"
        case lineIn = "LineIn"
        case console = "Console"
        case system = "System"
        case game = "Game"
        case chat = "Chat"
        case sample = "Sample"
        case music = "Music"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(mic, forKey: .mic)
        try container.encode(lineIn, forKey: .lineIn)
        try container.encode(console, forKey: .console)
        try container.encode(system, forKey: .system)
        try container.encode(game, forKey: .game)
        try container.encode(chat, forKey: .chat)
        try container.encode(sample, forKey: .sample)
        try container.encode(music, forKey: .music)
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mic = try values.decode(SubmixesInputs.self, forKey: .mic)
        lineIn = try values.decode(SubmixesInputs.self, forKey: .lineIn)
        console = try values.decode(SubmixesInputs.self, forKey: .console)
        system = try values.decode(SubmixesInputs.self, forKey: .system)
        game = try values.decode(SubmixesInputs.self, forKey: .game)
        chat = try values.decode(SubmixesInputs.self, forKey: .chat)
        sample = try values.decode(SubmixesInputs.self, forKey: .sample)
        music = try values.decode(SubmixesInputs.self, forKey: .music)
        mic.assign(.Mic)
        lineIn.assign(.LineIn)
        console.assign(.Console)
        system.assign(.System)
        game.assign(.Game)
        chat.assign(.Chat)
        sample.assign(.Sample)
        music.assign(.Music)
    }
}

// MARK: - Chat
@Patchable
public final class SubmixesInputs: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<SubmixesInputs>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.volume:
            return .SetSubMixVolume(channel, Int(newValue as! Float))
        case \.linked:
            return .SetSubMixLinked(channel, newValue as! Bool)
        default: return nil
        }
    }
    
    @Published public var volume: Float
    @Published public var linked: Bool
    @Published public var ratio: Double
    
    private var channel: ChannelName = .System
    
    func assign(_ channel: ChannelName) {
        self.channel = channel
    }
    
    enum CodingKeys: String, CodingKey {
        case volume
        case linked
        case ratio
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(volume, forKey: .volume)
        try container.encode(linked, forKey: .linked)
        try container.encode(ratio, forKey: .ratio)
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        volume = try values.decode(Float.self, forKey: .volume)
        linked = try values.decode(Bool.self, forKey: .linked)
        ratio = try values.decode(Double.self, forKey: .ratio)
    }
}

// MARK: - Outputs
@Patchable
public final class SubmixesOutputs: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<SubmixesOutputs>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.headphones:
            return .SetSubMixOutputMix(.Headphones, newValue as! SubmixAssignation)
        case \.broadcastMix:
            return .SetSubMixOutputMix(.BroadcastMix, newValue as! SubmixAssignation)
        case \.chatMic:
            return .SetSubMixOutputMix(.ChatMic, newValue as! SubmixAssignation)
        case \.sampler:
            return .SetSubMixOutputMix(.Sampler, newValue as! SubmixAssignation)
        case \.lineOut:
            return .SetSubMixOutputMix(.LineOut, newValue as! SubmixAssignation)
        default: return nil
        }
    }
    
    @Published public var headphones: SubmixAssignation
    @Published public var broadcastMix: SubmixAssignation
    @Published public var chatMic: SubmixAssignation
    @Published public var sampler: SubmixAssignation
    @Published public var lineOut: SubmixAssignation
    
    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
        case lineOut = "LineOut"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(SubmixAssignation.self, forKey: .headphones)
        broadcastMix = try values.decode(SubmixAssignation.self, forKey: .broadcastMix)
        chatMic = try values.decode(SubmixAssignation.self, forKey: .chatMic)
        sampler = try values.decode(SubmixAssignation.self, forKey: .sampler)
        lineOut = try values.decode(SubmixAssignation.self, forKey: .lineOut)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
        try container.encode(lineOut, forKey: .lineOut)
    }
}
