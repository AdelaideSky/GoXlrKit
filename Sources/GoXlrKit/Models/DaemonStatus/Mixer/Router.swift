//
//  SwiftUIView.swift
//  
//
//  Created by Adélaïde Sky on 23/04/2023.
//

import Foundation
import SwiftUI

protocol RouterInputs {
    var headphones: Bool { get set }
    var broadcastMix: Bool { get set }
    var lineOut: Bool  { get set }
    var chatMic: Bool  { get set }
    var sampler: Bool  { get set }
}

// MARK: - Router
public class Router: Codable, ObservableObject {
    @Published public var microphone: Microphone
    @Published public var chat: Chat
    @Published public var music: Music
    @Published public var game: Game
    @Published public var console: Console
    @Published public var lineIn: LineIn
    @Published public var system: System
    @Published public var samples: RoutingSamples
    
    public var everyHeadphones: [Binding<Bool>] {
        return [
            Binding(get: { self.microphone.headphones }, set: { self.microphone.headphones = $0 }),
            Binding(get: { self.chat.headphones }, set: { self.chat.headphones = $0 }),
            Binding(get: { self.music.headphones }, set: { self.music.headphones = $0 }),
            Binding(get: { self.game.headphones }, set: { self.game.headphones = $0 }),
            Binding(get: { self.console.headphones }, set: { self.console.headphones = $0 }),
            Binding(get: { self.lineIn.headphones }, set: { self.lineIn.headphones = $0 }),
            Binding(get: { self.system.headphones }, set: { self.system.headphones = $0 }),
            Binding(get: { self.samples.headphones }, set: { self.samples.headphones = $0 }),
        ]
    }
    public var everyBroadcastMix: [Binding<Bool>] {
        return [
            Binding(get: { self.microphone.broadcastMix }, set: { self.microphone.broadcastMix = $0 }),
            Binding(get: { self.chat.broadcastMix }, set: { self.chat.broadcastMix = $0 }),
            Binding(get: { self.music.broadcastMix }, set: { self.music.broadcastMix = $0 }),
            Binding(get: { self.game.broadcastMix }, set: { self.game.broadcastMix = $0 }),
            Binding(get: { self.console.broadcastMix }, set: { self.console.broadcastMix = $0 }),
            Binding(get: { self.lineIn.broadcastMix }, set: { self.lineIn.broadcastMix = $0 }),
            Binding(get: { self.system.broadcastMix }, set: { self.system.broadcastMix = $0 }),
            Binding(get: { self.samples.broadcastMix }, set: { self.samples.broadcastMix = $0 }),
        ]
    }
    public var everyLineOut: [Binding<Bool>] {
        return [
            Binding(get: { self.microphone.lineOut }, set: { self.microphone.lineOut = $0 }),
            Binding(get: { self.chat.lineOut }, set: { self.chat.lineOut = $0 }),
            Binding(get: { self.music.lineOut }, set: { self.music.lineOut = $0 }),
            Binding(get: { self.game.lineOut }, set: { self.game.lineOut = $0 }),
            Binding(get: { self.console.lineOut }, set: { self.console.lineOut = $0 }),
            Binding(get: { self.lineIn.lineOut }, set: { self.lineIn.lineOut = $0 }),
            Binding(get: { self.system.lineOut }, set: { self.system.lineOut = $0 }),
            Binding(get: { self.samples.lineOut }, set: { self.samples.lineOut = $0 }),
        ]
    }
    public var everyChatMic: [Binding<Bool>] {
        return [
            Binding(get: { self.microphone.chatMic }, set: { self.microphone.chatMic = $0 }),
            Binding(get: { self.chat.chatMic }, set: { self.chat.chatMic = $0 }),
            Binding(get: { self.music.chatMic }, set: { self.music.chatMic = $0 }),
            Binding(get: { self.game.chatMic }, set: { self.game.chatMic = $0 }),
            Binding(get: { self.console.chatMic }, set: { self.console.chatMic = $0 }),
            Binding(get: { self.lineIn.chatMic }, set: { self.lineIn.chatMic = $0 }),
            Binding(get: { self.system.chatMic }, set: { self.system.chatMic = $0 }),
            Binding(get: { self.samples.chatMic }, set: { self.samples.chatMic = $0 }),
        ]
    }
    
    public var everySampler: [Binding<Bool>] {
        return [
            Binding(get: { self.microphone.sampler }, set: { self.microphone.sampler = $0 }),
            Binding(get: { self.chat.sampler }, set: { self.chat.sampler = $0 }),
            Binding(get: { self.music.sampler }, set: { self.music.sampler = $0 }),
            Binding(get: { self.game.sampler }, set: { self.game.sampler = $0 }),
            Binding(get: { self.console.sampler }, set: { self.console.sampler = $0 }),
            Binding(get: { self.lineIn.sampler }, set: { self.lineIn.sampler = $0 }),
            Binding(get: { self.system.sampler }, set: { self.system.sampler = $0 }),
            Binding(get: { self.samples.sampler }, set: { self.samples.sampler = $0 }),
        ]
    }

    enum CodingKeys: String, CodingKey {
        case microphone = "Microphone"
        case chat = "Chat"
        case music = "Music"
        case game = "Game"
        case console = "Console"
        case lineIn = "LineIn"
        case system = "System"
        case samples = "Samples"
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.microphone = try container.decode(Microphone.self, forKey: .microphone)
        self.chat = try container.decode(Chat.self, forKey: .chat)
        self.music = try container.decode(Music.self, forKey: .music)
        self.game = try container.decode(Game.self, forKey: .game)
        self.console = try container.decode(Console.self, forKey: .console)
        self.lineIn = try container.decode(LineIn.self, forKey: .lineIn)
        self.system = try container.decode(System.self, forKey: .system)
        self.samples = try container.decode(RoutingSamples.self, forKey: .samples)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.microphone, forKey: .microphone)
        try container.encode(self.chat, forKey: .chat)
        try container.encode(self.music, forKey: .music)
        try container.encode(self.game, forKey: .game)
        try container.encode(self.console, forKey: .console)
        try container.encode(self.lineIn, forKey: .lineIn)
        try container.encode(self.system, forKey: .system)
        try container.encode(self.samples, forKey: .samples)
    }
}

public class Microphone: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Microphone, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Microphone, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Microphone, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Microphone, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Microphone, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class Chat: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Chat, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Chat, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Chat, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Chat, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Chat, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class Music: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Music, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Music, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Music, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Music, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Music, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class Game: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Game, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Game, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Game, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Game, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Game, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class Console: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Console, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Console, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Console, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Console, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Console, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class LineIn: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.LineIn, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.LineIn, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.LineIn, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.LineIn, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.LineIn, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class System: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.System, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.System, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.System, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.System, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.System, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}

public class RoutingSamples: Codable, ObservableObject, RouterInputs {
    @Published public var headphones: Bool { didSet { GoXlr.shared.command(.SetRouter(.Samples, .Headphones, headphones)) } }
    @Published public var broadcastMix: Bool { didSet { GoXlr.shared.command(.SetRouter(.Samples, .BroadcastMix, broadcastMix)) } }
    @Published public var lineOut: Bool { didSet { GoXlr.shared.command(.SetRouter(.Samples, .LineOut, lineOut)) } }
    @Published public var chatMic: Bool { didSet { GoXlr.shared.command(.SetRouter(.Samples, .ChatMic, chatMic)) } }
    @Published public var sampler: Bool { didSet { GoXlr.shared.command(.SetRouter(.Samples, .Sampler, sampler)) } }

    enum CodingKeys: String, CodingKey {
        case headphones = "Headphones"
        case broadcastMix = "BroadcastMix"
        case lineOut = "LineOut"
        case chatMic = "ChatMic"
        case sampler = "Sampler"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headphones = try values.decode(Bool.self, forKey: .headphones)
        broadcastMix = try values.decode(Bool.self, forKey: .broadcastMix)
        lineOut = try values.decode(Bool.self, forKey: .lineOut)
        chatMic = try values.decode(Bool.self, forKey: .chatMic)
        sampler = try values.decode(Bool.self, forKey: .sampler)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(headphones, forKey: .headphones)
        try container.encode(broadcastMix, forKey: .broadcastMix)
        try container.encode(lineOut, forKey: .lineOut)
        try container.encode(chatMic, forKey: .chatMic)
        try container.encode(sampler, forKey: .sampler)
    }
}
