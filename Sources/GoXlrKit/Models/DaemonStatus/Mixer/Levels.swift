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
public final class Levels: Codable, ObservableObject {
    @Published public var submixSupported: Bool
    @child @Published public var volumes: Volumes
    @Parameter({ .SetSwearButtonVolume(Int($0)) }) public var bleep: Float = 0
    @Parameter({ .SetDeeser(Int($0)) }) public var deess: Float = 0
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
public final class Volumes: Codable, ObservableObject {
    @Parameter({ .SetVolume(.System, Int($0)) }) public var system: Float = 0
    @Parameter({ .SetVolume(.Mic, Int($0)) }) public var mic: Float = 0
    @Parameter({ .SetVolume(.LineIn, Int($0)) }) public var lineIn: Float = 0
    @Parameter({ .SetVolume(.Console, Int($0)) }) public var console: Float = 0
    @Parameter({ .SetVolume(.Game, Int($0)) }) public var game: Float = 0
    @Parameter({ .SetVolume(.Chat, Int($0)) }) public var chat: Float = 0
    @Parameter({ .SetVolume(.Sample, Int($0)) }) public var sample: Float = 0
    @Parameter({ .SetVolume(.Music, Int($0)) }) public var music: Float = 0
    @Parameter({ .SetVolume(.Headphones, Int($0)) }) public var headphones: Float = 0
    @Parameter({ .SetVolume(.MicMonitor, Int($0)) }) public var micMonitor: Float = 0
    @Parameter({ .SetVolume(.LineOut, Int($0)) }) public var lineOut: Float = 0
    
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
public final class SubmixesInputs: Codable, ObservableObject {
    @Parameter public var volume: Float = 0
    @Parameter public var linked: Bool = false
    @Published public var ratio: Double
    
    private var channel: ChannelName = .System
    
    func assign(_ channel: ChannelName) {
        self.channel = channel
        
        self._volume.setCommand({ .SetSubMixVolume(channel, Int($0)) })
        self._linked.setCommand({ .SetSubMixLinked(channel, $0) })
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
public final class SubmixesOutputs: Codable, ObservableObject {
    @Parameter({ .SetSubMixOutputMix(.Headphones, $0) }) public var headphones: SubmixAssignation = .A
    @Parameter({ .SetSubMixOutputMix(.BroadcastMix, $0) }) public var broadcastMix: SubmixAssignation = .A
    @Parameter({ .SetSubMixOutputMix(.ChatMic, $0) }) public var chatMic: SubmixAssignation = .A
    @Parameter({ .SetSubMixOutputMix(.Sampler, $0) }) public var sampler: SubmixAssignation = .A
    @Parameter({ .SetSubMixOutputMix(.LineOut, $0) }) public var lineOut: SubmixAssignation = .A
    
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
