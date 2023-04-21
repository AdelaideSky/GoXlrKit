//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation

// MARK: - Levels
public class Levels: Codable, ObservableObject {
    @Published public var submixSupported: Bool
    @Published public var volumes: Volumes
    @Published public var bleep: Float
    @Published public var deess: Float
    @Published public var submix: Submix?
    
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
public class Volumes: Codable, ObservableObject {
    @Published public var system: Float { didSet { GoXlr.shared.command(.SetVolume(.System, Int(system))) } }
    @Published public var mic: Float { didSet { GoXlr.shared.command(.SetVolume(.Mic, Int(mic))) } }
    @Published public var lineIn: Float { didSet { GoXlr.shared.command(.SetVolume(.LineIn, Int(lineIn))) } }
    @Published public var console: Float { didSet { GoXlr.shared.command(.SetVolume(.Console, Int(console))) } }
    @Published public var game: Float { didSet { GoXlr.shared.command(.SetVolume(.Game, Int(game))) } }
    @Published public var chat: Float { didSet { GoXlr.shared.command(.SetVolume(.Chat, Int(chat))) } }
    @Published public var sample: Float { didSet { GoXlr.shared.command(.SetVolume(.Sample, Int(sample))) } }
    @Published public var music: Float { didSet { GoXlr.shared.command(.SetVolume(.Music, Int(music))) } }
    @Published public var headphones: Float { didSet { GoXlr.shared.command(.SetVolume(.Headphones, Int(headphones))) } }
    @Published public var micMonitor: Float { didSet { GoXlr.shared.command(.SetVolume(.MicMonitor, Int(micMonitor))) } }
    @Published public var lineOut: Float { didSet { GoXlr.shared.command(.SetVolume(.LineOut, Int(lineOut))) } }

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
public class Submix: Codable {
    var inputs: Inputs
    var outputs: SubmixesOutputs
}

// MARK: - Inputs
public class Inputs: Codable {
    @Published public var mic: SubmixesInputs
    @Published public var lineIn: SubmixesInputs
    @Published public var console: SubmixesInputs
    @Published public var system: SubmixesInputs
    @Published public var game: SubmixesInputs
    @Published public var chat: SubmixesInputs
    @Published public var sample: SubmixesInputs
    @Published public var music: SubmixesInputs
    
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
    }
}

// MARK: - Chat
public class SubmixesInputs: Codable {
    @Published public var volume: Float
    @Published public var linked: Bool
    @Published public var ratio: Double
    
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
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        volume = try values.decode(Float.self, forKey: .volume)
        linked = try values.decode(Bool.self, forKey: .linked)
        ratio = try values.decode(Double.self, forKey: .ratio)
    }
}

// MARK: - Outputs
public class SubmixesOutputs: Codable, ObservableObject {
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
