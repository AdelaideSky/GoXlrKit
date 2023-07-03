//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 03/07/2023.
//

import Foundation
import SwiftUI

// MARK: - Lighting
public class Lighting: Codable, ObservableObject {
    @Published public var faders: FaderColors
    @Published public var buttons: ButtonsLightning
    @Published public var simple: Simple
    @Published public var sampler: LightingSampler?
    @Published public var encoders: Encoders?

    enum CodingKeys: String, CodingKey {
        case faders
        case buttons
        case simple
        case sampler
        case encoders
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faders = try values.decode(FaderColors.self, forKey: .faders)
        buttons = try values.decode(ButtonsLightning.self, forKey: .buttons)
        simple = try values.decode(Simple.self, forKey: .simple)
        do {
            sampler = try values.decode(LightingSampler?.self, forKey: .sampler)
            encoders = try values.decode(Encoders?.self, forKey: .encoders)
        } catch {
            sampler = nil
            encoders = nil
        }
        
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(faders, forKey: .faders)
        try container.encode(buttons, forKey: .buttons)
        try container.encode(simple, forKey: .simple)
        try container.encode(sampler, forKey: .sampler)
        try container.encode(encoders, forKey: .encoders)
    }
}

public class ButtonsLightning: Codable, ObservableObject {
    
    @Published public var bleep: ButtonStyle { didSet { handleDidSet(bleep, .Bleep, oldValue) }}
    @Published public var cough: ButtonStyle { didSet { handleDidSet(cough, .Cough, oldValue) }}
    @Published public var effectFx: ButtonStyle? { didSet { handleDidSet(effectFx!, .EffectFx, oldValue!) }}
    @Published public var effectHardTune: ButtonStyle? { didSet { handleDidSet(effectHardTune!, .EffectHardTune, oldValue!) }}
    @Published public var effectMegaphone: ButtonStyle? { didSet { handleDidSet(effectMegaphone!, .EffectMegaphone, oldValue!) }}
    @Published public var effectRobot: ButtonStyle? { didSet { handleDidSet(effectRobot!, .EffectRobot, oldValue!) }}
    @Published public var effectSelect1: ButtonStyle? { didSet { handleDidSet(effectSelect1!, .EffectSelect1, oldValue!) }}
    @Published public var effectSelect2: ButtonStyle? { didSet { handleDidSet(effectSelect2!, .EffectSelect2, oldValue!) }}
    @Published public var effectSelect3: ButtonStyle? { didSet { handleDidSet(effectSelect3!, .EffectSelect3, oldValue!) }}
    @Published public var effectSelect4: ButtonStyle? { didSet { handleDidSet(effectSelect4!, .EffectSelect4, oldValue!) }}
    @Published public var effectSelect5: ButtonStyle? { didSet { handleDidSet(effectSelect5!, .EffectSelect5, oldValue!) }}
    @Published public var effectSelect6: ButtonStyle? { didSet { handleDidSet(effectSelect6!, .EffectSelect6, oldValue!) }}

    @Published public var fader1Mute: ButtonStyle { didSet { handleDidSet(fader1Mute, .Fader1Mute, oldValue) }}
    @Published public var fader2Mute: ButtonStyle { didSet { handleDidSet(fader2Mute, .Fader2Mute, oldValue) }}
    @Published public var fader3Mute: ButtonStyle { didSet { handleDidSet(fader3Mute, .Fader3Mute, oldValue) }}
    @Published public var fader4Mute: ButtonStyle { didSet { handleDidSet(fader4Mute, .Fader4Mute, oldValue) }}
    
    
    private func handleDidSet(_ style: ButtonStyle, _ button: GoXlrButton, _ oldValue: ButtonStyle) {
        if style.offStyle != oldValue.offStyle {
            GoXlr.shared.command(.SetButtonOffStyle(button, style.offStyle))
        } else {
            if liveUD {
                GoXlr.shared.command(.SetButtonColours(button, style.colours.colourOne, style.colours.colourTwo))
            }
        }
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case bleep = "Bleep"
        case cough = "Cough"
        case effectFX = "EffectFx"
        case effectHardTune = "EffectHardTune"
        case effectMegaphone = "EffectMegaphone"
        case effectRobot = "EffectRobot"
        case effectSelect1 = "EffectSelect1"
        case effectSelect2 = "EffectSelect2"
        case effectSelect3 = "EffectSelect3"
        case effectSelect4 = "EffectSelect4"
        case effectSelect5 = "EffectSelect5"
        case effectSelect6 = "EffectSelect6"
        case fader1Mute = "Fader1Mute"
        case fader2Mute = "Fader2Mute"
        case fader3Mute = "Fader3Mute"
        case fader4Mute = "Fader4Mute"
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(bleep, forKey: .bleep)
        try container.encode(cough, forKey: .cough)
        try container.encode(effectFx, forKey: .effectFX)
        try container.encode(effectHardTune, forKey: .effectHardTune)
        try container.encode(effectMegaphone, forKey: .effectMegaphone)
        try container.encode(effectRobot, forKey: .effectRobot)
        try container.encode(effectSelect1, forKey: .effectSelect1)
        try container.encode(effectSelect2, forKey: .effectSelect2)
        try container.encode(effectSelect3, forKey: .effectSelect3)
        try container.encode(effectSelect4, forKey: .effectSelect4)
        try container.encode(effectSelect5, forKey: .effectSelect5)
        try container.encode(effectSelect6, forKey: .effectSelect6)
        try container.encode(fader1Mute, forKey: .fader1Mute)
        try container.encode(fader2Mute, forKey: .fader2Mute)
        try container.encode(fader3Mute, forKey: .fader3Mute)
        try container.encode(fader4Mute, forKey: .fader4Mute)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bleep = try container.decode(ButtonStyle.self, forKey: .bleep)
        cough = try container.decode(ButtonStyle.self, forKey: .cough)
        effectFx = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectFX)
        effectHardTune = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectHardTune)
        effectMegaphone = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectMegaphone)
        effectRobot = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectRobot)
        effectSelect1 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect1)
        effectSelect2 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect2)
        effectSelect3 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect3)
        effectSelect4 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect4)
        effectSelect5 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect5)
        effectSelect6 = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectSelect6)
        fader1Mute = try container.decode(ButtonStyle.self, forKey: .fader1Mute)
        fader2Mute = try container.decode(ButtonStyle.self, forKey: .fader2Mute)
        fader3Mute = try container.decode(ButtonStyle.self, forKey: .fader3Mute)
        fader4Mute = try container.decode(ButtonStyle.self, forKey: .fader4Mute)
    }
}


// MARK: - Button
public struct ButtonStyle: Codable {
    public var offStyle: ButtonColourOffStyle
    public var colours: Colours

    enum CodingKeys: String, CodingKey {
        case offStyle = "off_style"
        case colours
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offStyle = try values.decode(ButtonColourOffStyle.self, forKey: .offStyle)
        colours = try values.decode(Colours.self, forKey: .colours)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offStyle, forKey: .offStyle)
        try container.encode(colours, forKey: .colours)
    }
}

// MARK: - Colours
public struct Colours: Codable {
    public var colourOne: Color
    public var colourTwo: Color

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
        case colourTwo = "colour_two"
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(Color.self, forKey: .colourOne)
        colourTwo = try values.decode(Color.self, forKey: .colourTwo)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colourOne, forKey: .colourOne)
        try container.encode(colourTwo, forKey: .colourTwo)
    }
}

// MARK: - Encoders
public class Encoders: Codable, ObservableObject {
    @Published public var reverb: GenderClass?
    @Published public var echo: GenderClass?
    @Published public var pitch: GenderClass?
    @Published public var gender: GenderClass?

    enum CodingKeys: String, CodingKey {
        case reverb = "Reverb"
        case echo = "Echo"
        case pitch = "Pitch"
        case gender = "Gender"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reverb = try values.decode(GenderClass?.self, forKey: .reverb)
        echo = try values.decode(GenderClass?.self, forKey: .echo)
        pitch = try values.decode(GenderClass?.self, forKey: .pitch)
        gender = try values.decode(GenderClass?.self, forKey: .gender)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reverb, forKey: .reverb)
        try container.encode(echo, forKey: .echo)
        try container.encode(pitch, forKey: .pitch)
        try container.encode(gender, forKey: .gender)
    }
}

// MARK: - GenderClass
public class GenderClass: Codable, ObservableObject {
    @Published public var colourOne: Color
    @Published public var colourTwo: Color
    @Published public var colourThree: Color

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
        case colourTwo = "colour_two"
        case colourThree = "colour_three"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(Color.self, forKey: .colourOne)
        colourTwo = try values.decode(Color.self, forKey: .colourTwo)
        colourThree = try values.decode(Color.self, forKey: .colourThree)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colourOne, forKey: .colourOne)
        try container.encode(colourTwo, forKey: .colourTwo)
        try container.encode(colourThree, forKey: .colourThree)
    }
}

// MARK: - Faders
public class FaderColors: Codable, ObservableObject {
    @Published public var a: FaderColor
    @Published public var b: FaderColor
    @Published public var c: FaderColor
    @Published public var d: FaderColor
    
    private func handleDidSet(_ style: FaderColor, _ fader: FaderName, _ oldValue: FaderColor) {
        if ((style.colours.colourOne != oldValue.colours.colourOne) || (style.colours.colourTwo != oldValue.colours.colourTwo)) && liveUD {
            GoXlr.shared.command(.SetFaderColours(fader, style.colours.colourOne, style.colours.colourTwo))
        } else {
            GoXlr.shared.command(.SetFaderDisplayStyle(fader, style.style))
        }
    }

    enum CodingKeys: String, CodingKey {
        case c = "C"
        case b = "B"
        case a = "A"
        case d = "D"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decode(FaderColor.self, forKey: .a)
        b = (try values.decode(FaderColor.self, forKey: .b))
        c = try values.decode(FaderColor.self, forKey: .c)
        d = try values.decode(FaderColor.self, forKey: .d)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(a, forKey: .a)
        try container.encode(b, forKey: .b)
        try container.encode(c, forKey: .c)
        try container.encode(d, forKey: .d)
    }
}

// MARK: - FadersA
public class FaderColor: Codable, ObservableObject {
    @Published public var style: FaderDisplayStyle
    @Published public var colours: Colours

    enum CodingKeys: String, CodingKey {
        case style
        case colours
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(FaderDisplayStyle.self, forKey: .style)
        colours = try container.decode(Colours.self, forKey: .colours)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        try container.encode(colours, forKey: .colours)
    }
}

// MARK: - LightingSampler
public class LightingSampler: Codable, ObservableObject {
    @Published public var samplerSelectA: SamplerSelect?
    @Published public var samplerSelectB: SamplerSelect?
    @Published public var samplerSelectC: SamplerSelect?

    enum CodingKeys: String, CodingKey {
        case samplerSelectA = "SamplerSelectA"
        case samplerSelectB = "SamplerSelectB"
        case samplerSelectC = "SamplerSelectC"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        samplerSelectA = try values.decode(SamplerSelect?.self, forKey: .samplerSelectA)
        samplerSelectB = try values.decode(SamplerSelect?.self, forKey: .samplerSelectB)
        samplerSelectC = try values.decode(SamplerSelect?.self, forKey: .samplerSelectC)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(samplerSelectA, forKey: .samplerSelectA)
        try container.encode(samplerSelectB, forKey: .samplerSelectB)
        try container.encode(samplerSelectC, forKey: .samplerSelectC)
    }
}

// MARK: - SamplerSelect
public class SamplerSelect: Codable, ObservableObject {
    @Published public var offStyle: ButtonColourOffStyle
    @Published public var colours: GenderClass

    enum CodingKeys: String, CodingKey {
        case offStyle = "off_style"
        case colours
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offStyle = try values.decode(ButtonColourOffStyle.self, forKey: .offStyle)
        colours = try values.decode(GenderClass.self, forKey: .colours)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offStyle, forKey: .offStyle)
        try container.encode(colours, forKey: .colours)
    }
}

// MARK: - Simple
public class Simple: Codable, ObservableObject {
    @Published public var scribble1: Accent? { didSet { handleDidSet(scribble1, .Scribble1, oldValue) } }
    @Published public var scribble2: Accent? { didSet { handleDidSet(scribble2, .Scribble2, oldValue) } }
    @Published public var scribble3: Accent? { didSet { handleDidSet(scribble3, .Scribble3, oldValue) } }
    @Published public var scribble4: Accent? { didSet { handleDidSet(scribble4, .Scribble4, oldValue) } }
    @Published public var global: Accent { didSet { handleDidSet(global, .Global, oldValue) } }
    @Published public var accent: Accent { didSet { handleDidSet(accent, .Accent, oldValue) } }

    private func handleDidSet(_ style: Accent?, _ simple: SimpleColourTargets, _ oldValue: Accent?) {
        guard style != nil && oldValue != nil else { return }
        
        if style!.colourOne != oldValue!.colourOne && liveUD {
            guard simple != .Global else {
                GoXlr.shared.command(.SetGlobalColour(style!.colourOne))
                return
            }
            
            GoXlr.shared.command(.SetSimpleColour(simple, style!.colourOne))
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case scribble3 = "Scribble3"
        case global = "Global"
        case scribble1 = "Scribble1"
        case scribble2 = "Scribble2"
        case scribble4 = "Scribble4"
        case accent = "Accent"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            scribble1 = try values.decode(Accent?.self, forKey: .scribble1)
            scribble2 = try values.decode(Accent?.self, forKey: .scribble2)
            scribble3 = try values.decode(Accent?.self, forKey: .scribble3)
            scribble4 = try values.decode(Accent?.self, forKey: .scribble4)
        } catch  {
            scribble1 = nil
            scribble2 = nil
            scribble3 = nil
            scribble4 = nil
        }
        global = try values.decode(Accent.self, forKey: .global)
        accent = try values.decode(Accent.self, forKey: .accent)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scribble1, forKey: .scribble1)
        try container.encode(scribble2, forKey: .scribble2)
        try container.encode(scribble3, forKey: .scribble3)
        try container.encode(scribble4, forKey: .scribble4)
        try container.encode(global, forKey: .global)
        try container.encode(accent, forKey: .accent)
    }
}

// MARK: - Accent
public struct Accent: Codable {
    public var colourOne: Color

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(Color.self, forKey: .colourOne)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colourOne, forKey: .colourOne)
    }
}
