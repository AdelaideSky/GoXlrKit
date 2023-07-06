//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation

// MARK: - FaderStatus
public class FadersStatus: Codable, ObservableObject {
    @Published public var a: FaderA
    @Published public var b: FaderB
    @Published public var c: FaderC
    @Published public var d: FaderD

    enum CodingKeys: String, CodingKey {
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decode(FaderA.self, forKey: .a)
        b = try values.decode(FaderB.self, forKey: .b)
        c = try values.decode(FaderC.self, forKey: .c)
        d = try values.decode(FaderD.self, forKey: .d)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)
    }
}

// MARK: - FaderStatus
public class FaderA: Codable, ObservableObject {
    @Published public var channel: ChannelName { didSet { GoXlr.shared.command(.SetFader(.A, channel)) } }
    @Published public var muteType: MuteFunction { didSet { GoXlr.shared.command(.SetFaderMuteFunction(.A, muteType)) } }
    @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

public class FaderB: Codable, ObservableObject {
    @Published public var channel: ChannelName { didSet { GoXlr.shared.command(.SetFader(.B, channel)) } }
    @Published public var muteType: MuteFunction { didSet { GoXlr.shared.command(.SetFaderMuteFunction(.B, muteType)) } }
    @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

public class FaderC: Codable, ObservableObject {
    @Published public var channel: ChannelName { didSet { GoXlr.shared.command(.SetFader(.C, channel)) } }
    @Published public var muteType: MuteFunction { didSet { GoXlr.shared.command(.SetFaderMuteFunction(.C, muteType)) } }
    @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

public class FaderD: Codable, ObservableObject {
    @Published public var channel: ChannelName { didSet { GoXlr.shared.command(.SetFader(.D, channel)) } }
    @Published public var muteType: MuteFunction { didSet { GoXlr.shared.command(.SetFaderMuteFunction(.D, muteType)) } }
    @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

// MARK: - Scribble
public struct Scribble: Codable {
    public var fileName: String?
    public var bottomText: String
    public var leftText: String?
    public var inverted: Bool

    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case bottomText = "bottom_text"
        case leftText = "left_text"
        case inverted
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        if let text = try values.decodeIfPresent(String.self, forKey: .bottomText) {
            bottomText = text
        } else {
            bottomText = ""
        }
        leftText = try values.decodeIfPresent(String.self, forKey: .leftText)
        inverted = try values.decode(Bool.self, forKey: .inverted)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(bottomText, forKey: .bottomText)
        try container.encode(leftText, forKey: .leftText)
        try container.encode(inverted, forKey: .inverted)
    }
}
