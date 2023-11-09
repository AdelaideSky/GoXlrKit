//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation
import Patchable

// MARK: - FaderStatus
@Patchable
public class FadersStatus: Codable, ObservableObject {
    @child @Published public var a: FaderA
    @child @Published public var b: FaderB
    @child @Published public var c: FaderC
    @child @Published public var d: FaderD

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
@Patchable
public final class FaderA: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<FaderA>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.channel:
            return .SetFader(.A, newValue as! ChannelName)
        case \.muteType:
            return .SetFader(.A, newValue as! ChannelName)
        default: return nil
        }
    }
    
    @Published public var channel: ChannelName
    @Published public var muteType: MuteFunction
    @child @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
//
//    func handleDidSet(_ value: Scribble?, _ oldValue: Scribble?) {
//        guard value != nil && oldValue != nil else { return }
//        if value?.bottomText != oldValue?.bottomText {
//            GoXlr.shared.command(.SetScribbleText(.A, value!.bottomText))
//        } else if value?.fileName != oldValue?.fileName {
//            GoXlr.shared.command(.SetScribbleIcon(.A, value!.fileName ?? ""))
//        } else if value?.leftText != oldValue?.leftText {
//            GoXlr.shared.command(.SetScribbleNumber(.A, value!.leftText ?? ""))
//        } else {
//            GoXlr.shared.command(.SetScribbleInvert(.A, value!.inverted))
//        }
//    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
        if scribble != nil {
            scribble!.assign(.A)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

@Patchable
public final class FaderB: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<FaderB>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.channel:
            return .SetFader(.B, newValue as! ChannelName)
        case \.muteType:
            return .SetFader(.B, newValue as! ChannelName)
        default: return nil
        }
    }
    @Published public var channel: ChannelName
    @Published public var muteType: MuteFunction
    @child @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
//    func handleDidSet(_ value: Scribble?, _ oldValue: Scribble?) {
//        guard value != nil && oldValue != nil else { return }
//        if value?.bottomText != oldValue?.bottomText {
//            GoXlr.shared.command(.SetScribbleText(.B, value!.bottomText))
//        } else if value?.fileName != oldValue?.fileName {
//            GoXlr.shared.command(.SetScribbleIcon(.B, value!.fileName ?? ""))
//        } else if value?.leftText != oldValue?.leftText {
//            GoXlr.shared.command(.SetScribbleNumber(.B, value!.leftText ?? ""))
//        } else {
//            GoXlr.shared.command(.SetScribbleInvert(.B, value!.inverted))
//        }
//    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
        if scribble != nil {
            scribble!.assign(.B)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

@Patchable
public final class FaderC: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<FaderC>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.channel:
            return .SetFader(.C, newValue as! ChannelName)
        case \.muteType:
            return .SetFader(.C, newValue as! ChannelName)
        default: return nil
        }
    }
    @Published public var channel: ChannelName
    @Published public var muteType: MuteFunction
    @child @Published public var scribble: Scribble?
    @Published public var muteState: MuteState

    enum CodingKeys: String, CodingKey {
        case channel
        case muteType = "mute_type"
        case scribble
        case muteState = "mute_state"
    }
    
//    func handleDidSet(_ value: Scribble?, _ oldValue: Scribble?) {
//        guard value != nil && oldValue != nil else { return }
//        if value?.bottomText != oldValue?.bottomText {
//            GoXlr.shared.command(.SetScribbleText(.C, value!.bottomText))
//        } else if value?.fileName != oldValue?.fileName {
//            GoXlr.shared.command(.SetScribbleIcon(.C, value!.fileName ?? ""))
//        } else if value?.leftText != oldValue?.leftText {
//            GoXlr.shared.command(.SetScribbleNumber(.C, value!.leftText ?? ""))
//        } else {
//            GoXlr.shared.command(.SetScribbleInvert(.C, value!.inverted))
//        }
//    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        channel = try values.decode(ChannelName.self, forKey: .channel)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        scribble = try values.decode(Scribble?.self, forKey: .scribble)
        muteState = try values.decode(MuteState.self, forKey: .muteState)
        if scribble != nil {
            scribble!.assign(.C)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(channel, forKey: .channel)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(scribble, forKey: .scribble)
        try container.encode(muteState, forKey: .muteState)
    }
}

@Patchable
public final class FaderD: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<FaderD>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.channel:
            return .SetFader(.D, newValue as! ChannelName)
        case \.muteType:
            return .SetFader(.D, newValue as! ChannelName)
        default: return nil
        }
    }
    @Published public var channel: ChannelName
    @Published public var muteType: MuteFunction
    @child @Published public var scribble: Scribble?
    @Published public var muteState: MuteState
    
//    func handleDidSet(_ value: Scribble?, _ oldValue: Scribble?) {
//        guard value != nil && oldValue != nil else { return }
//        if value?.bottomText != oldValue?.bottomText {
//            GoXlr.shared.command(.SetScribbleText(.D, value!.bottomText))
//        } else if value?.fileName != oldValue?.fileName {
//            GoXlr.shared.command(.SetScribbleIcon(.D, value!.fileName ?? ""))
//        } else if value?.leftText != oldValue?.leftText {
//            GoXlr.shared.command(.SetScribbleNumber(.D, value!.leftText ?? ""))
//        } else {
//            GoXlr.shared.command(.SetScribbleInvert(.D, value!.inverted))
//        }
//    }

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
        if scribble != nil {
            scribble!.assign(.D)
        }
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
@Patchable
public final class Scribble: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Scribble>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.fileName:
            return .SetScribbleIcon(fader, newValue as! String? ?? "")
        case \.bottomText:
            return .SetScribbleText(fader, newValue as! String)
        case \.leftText:
            return .SetScribbleNumber(fader, newValue as! String? ?? "")
        case \.inverted:
            return .SetScribbleInvert(fader, newValue as! Bool)
        default: return nil
        }
    }
    
    @Published public var fileName: String?
    @Published public var bottomText: String
    @Published public var leftText: String?
    @Published public var inverted: Bool
    
    private var fader: FaderName = .A

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
    
    public func assign(_ fader: FaderName) {
        self.fader = fader
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fileName, forKey: .fileName)
        try container.encode(bottomText, forKey: .bottomText)
        try container.encode(leftText, forKey: .leftText)
        try container.encode(inverted, forKey: .inverted)
    }
}
