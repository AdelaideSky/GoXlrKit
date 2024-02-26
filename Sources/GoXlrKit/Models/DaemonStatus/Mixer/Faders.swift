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
    @child @Published public var a: Fader
    @child @Published public var b: Fader
    @child @Published public var c: Fader
    @child @Published public var d: Fader

    enum CodingKeys: String, CodingKey {
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decode(Fader.self, forKey: .a)
        b = try values.decode(Fader.self, forKey: .b)
        c = try values.decode(Fader.self, forKey: .c)
        d = try values.decode(Fader.self, forKey: .d)
        
        a.assign(.A)
        b.assign(.B)
        c.assign(.C)
        d.assign(.D)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)
    }
}

@Patchable
public final class Fader: Codable, ObservableObject {
    @Parameter public var channel: ChannelName = .System
    @Parameter public var muteType: MuteFunction = .All
    @child @Published public var scribble: Scribble?
    @Parameter public var muteState: MuteState = .Unmuted
    
    private var fader: FaderName = .A
    
    func assign(_ fader: FaderName) {
        self.fader = fader
        
        self._channel.setCommand({ .SetFader(fader, $0) })
        self._muteType.setCommand({ .SetFaderMuteFunction(fader, $0) })
        self._muteState.setCommand({ .SetFaderMuteState(fader, $0) })
        
        if scribble != nil {
            scribble!.assign(fader)
        }
    }
    
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
@Patchable
public final class Scribble: Codable, ObservableObject {
    @Parameter public var fileName: String? = nil
    @Parameter public var bottomText: String = ""
    @Parameter public var leftText: String? = nil
    @Parameter public var inverted: Bool = false
    
    private var fader: FaderName = .A

    public func assign(_ fader: FaderName) {
        self.fader = fader
        
        self._fileName.setCommand { .SetScribbleIcon(fader, $0 ?? "") }
        self._bottomText.setCommand { .SetScribbleIcon(fader, $0) }
        self._leftText.setCommand { .SetScribbleNumber(fader, $0 ?? "") }
        self._inverted.setCommand { .SetScribbleInvert(fader, $0) }
    }
    
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
