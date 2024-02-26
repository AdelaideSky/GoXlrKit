//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 03/07/2023.
//

import Foundation
import SwiftUI
import Patchable

// MARK: - Lighting
@Patchable
public class Lighting: Codable, ObservableObject {
    @child @Published public var faders: FaderColors
    @child @Published public var buttons: ButtonsLightning
    @child @Published public var simple: Simple
    @child @Published public var sampler: LightingSampler?
    @child @Published public var encoders: Encoders?

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

@Patchable
public class ButtonsLightning: Codable, ObservableObject {
    
    @child @Published public var bleep: ButtonStyle
    @child @Published public var cough: ButtonStyle
    @child @Published public var effectFx: ButtonStyle?
    @child @Published public var effectHardTune: ButtonStyle?
    @child @Published public var effectMegaphone: ButtonStyle?
    @child @Published public var effectRobot: ButtonStyle?
    @child @Published public var effectSelect1: ButtonStyle?
    @child @Published public var effectSelect2: ButtonStyle?
    @child @Published public var effectSelect3: ButtonStyle?
    @child @Published public var effectSelect4: ButtonStyle?
    @child @Published public var effectSelect5: ButtonStyle?
    @child @Published public var effectSelect6: ButtonStyle?

    @child @Published public var fader1Mute: ButtonStyle
    @child @Published public var fader2Mute: ButtonStyle
    @child @Published public var fader3Mute: ButtonStyle
    @child @Published public var fader4Mute: ButtonStyle
    
//    
//    private func handleDidSet(_ style: ButtonStyle, _ button: GoXlrButton, _ oldValue: ButtonStyle) {
//        if style.offStyle != oldValue.offStyle {
//            GoXlr.shared.command(.SetButtonOffStyle(button, style.offStyle))
//        } else {
////            if liveUD {
////                GoXlr.shared.command(.SetButtonColours(button, style.colours.colourOne, style.colours.colourTwo))
////            }
//        }
//    }
    
    
    private enum CodingKeys: String, CodingKey {
        case bleep = "Bleep"
        case cough = "Cough"
        case effectFx = "EffectFx"
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
        try container.encode(effectFx, forKey: .effectFx)
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
        effectFx = try container.decodeIfPresent(ButtonStyle.self, forKey: .effectFx)
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
        
        bleep.assign(.Bleep)
        cough.assign(.Cough)
        
        if effectFx != nil {
            effectFx?.assign(.EffectFx)
            effectHardTune?.assign(.EffectHardTune)
            effectMegaphone?.assign(.EffectMegaphone)
            effectRobot?.assign(.EffectRobot)
            effectSelect1?.assign(.EffectSelect1)
            effectSelect2?.assign(.EffectSelect2)
            effectSelect3?.assign(.EffectSelect3)
            effectSelect4?.assign(.EffectSelect4)
            effectSelect5?.assign(.EffectSelect5)
            effectSelect6?.assign(.EffectSelect6)
        }

        fader1Mute.assign(.Fader1Mute)
        fader2Mute.assign(.Fader2Mute)
        fader3Mute.assign(.Fader3Mute)
        fader4Mute.assign(.Fader4Mute)

    }
}


// MARK: - Button
@Patchable
public final class ButtonStyle: Codable, ObservableObject {
    @Parameter public var offStyle: ButtonColourOffStyle = .Dimmed
    @child @Published public var colours: Colours
    
    private var button: GoXlrButton = .Bleep
    
    func assign(_ button: GoXlrButton) {
        self.button = button
        self.colours.assign(button)
        self._offStyle.setCommand({ .SetButtonOffStyle(button, $0) })
    }

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
@Patchable
public final class Colours: Codable {
    @Parameter public var colourOne: Color = .black
    @Parameter public var colourTwo: Color = .black
    
    private var button: GoXlrButton = .Bleep
    
    func assign(_ button: GoXlrButton) {
        self.button = button
        
        self._colourOne.setCommand({ .SetButtonColours(button, $0, self.colourTwo)})
        self._colourTwo.setCommand({ .SetButtonColours(button, self.colourOne, $0)})
    }

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
@Patchable
public class Encoders: Codable, ObservableObject {
    @child @Published public var reverb: GenderClass?
    @child @Published public var echo: GenderClass?
    @child @Published public var pitch: GenderClass?
    @child @Published public var gender: GenderClass?

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
        
        if reverb != nil {
            reverb?.assign(.Reverb)
            echo?.assign(.Echo)
            pitch?.assign(.Pitch)
            gender?.assign(.Gender)
        }
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
@Patchable
public final class GenderClass: Codable, ObservableObject {
    @Parameter public var colourOne: Color = .black
    @Parameter public var colourTwo: Color = .black
    @Parameter public var colourThree: Color = .black
    
    private var encoder: EncoderColourTargets = .Echo
    
    func assign(_ encoder: EncoderColourTargets) {
        self.encoder = encoder
        
        self._colourOne.setCommand({ .SetEncoderColour(encoder, $0, self.colourTwo, self.colourThree) })
        self._colourTwo.setCommand({ .SetEncoderColour(encoder, self.colourOne, $0, self.colourThree) })
        self._colourThree.setCommand({ .SetEncoderColour(encoder, self.colourOne, self.colourTwo, $0) })
    }

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
@Patchable
public class FaderColors: Codable, ObservableObject {
    @child @Published public var a: FaderColor
    @child @Published public var b: FaderColor
    @child @Published public var c: FaderColor
    @child @Published public var d: FaderColor
    
//    private func handleDidSet(_ style: FaderColor, _ fader: FaderName, _ oldValue: FaderColor) {
////        if ((style.colours.colourOne != oldValue.colours.colourOne) || (style.colours.colourTwo != oldValue.colours.colourTwo)) && liveUD {
////            GoXlr.shared.command(.SetFaderColours(fader, style.colours.colourOne, style.colours.colourTwo))
////        } else {
////            GoXlr.shared.command(.SetFaderDisplayStyle(fader, style.style))
////        }
//        if style.style != oldValue.style {
//            GoXlr.shared.command(.SetFaderDisplayStyle(fader, style.style))
//        }
//    }

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

// MARK: - FadersA
@Patchable
public final class FaderColor: Codable, ObservableObject {
    @Parameter public var style: FaderDisplayStyle = .TwoColour
    @Published public var colours: Colours
    
    private var fader: FaderName = .A
    
    func assign(_ fader: FaderName) {
        self.fader = fader
        
        self._style.setCommand({ .SetFaderDisplayStyle(fader, $0) })
    }

    enum CodingKeys: String, CodingKey {
        case style
        case colours
    }
    
    public init(from decoder: Decoder) throws {
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
@Patchable
public class LightingSampler: Codable, ObservableObject {
    @child @Published public var samplerSelectA: SamplerSelect?
    @child @Published public var samplerSelectB: SamplerSelect?
    @child @Published public var samplerSelectC: SamplerSelect?

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
@Patchable
public final class SamplerSelect: Codable, ObservableObject {
    @Parameter public var offStyle: ButtonColourOffStyle = .Dimmed
    @child @Published public var colours: SamplerColors
    
    private var sample: SamplerColourTargets = .SamplerSelectA
    
    func assign(_ sample: SamplerColourTargets) {
        self.sample = sample
        self.colours.assign(sample)
        
        self._offStyle.setCommand({ .SetSampleOffStyle(sample, $0) })
    }

    enum CodingKeys: String, CodingKey {
        case offStyle = "off_style"
        case colours
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offStyle = try values.decode(ButtonColourOffStyle.self, forKey: .offStyle)
        colours = try values.decode(SamplerColors.self, forKey: .colours)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(offStyle, forKey: .offStyle)
        try container.encode(colours, forKey: .colours)
    }
}

@Patchable
public final class SamplerColors: Codable, ObservableObject {
    @Parameter public var colourOne: Color = .black
    @Parameter public var colourTwo: Color = .black
    @Parameter public var colourThree: Color = .black
    
    private var sample: SamplerColourTargets = .SamplerSelectA
    
    func assign(_ sample: SamplerColourTargets) {
        self.sample = sample
        
        self._colourOne.setCommand({ .SetSampleColour(sample, $0, self.colourTwo, self.colourThree) })
        self._colourTwo.setCommand({ .SetSampleColour(sample, self.colourOne, $0, self.colourThree) })
        self._colourThree.setCommand({ .SetSampleColour(sample, self.colourOne, self.colourTwo, $0) })
    }

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
// MARK: - Simple
@Patchable
public class Simple: Codable, ObservableObject {
    @child @Published public var scribble1: Accent?
    @child @Published public var scribble2: Accent?
    @child @Published public var scribble3: Accent?
    @child @Published public var scribble4: Accent?
    @child @Published public var global: Accent
    @child @Published public var accent: Accent

//    private func handleDidSet(_ style: Accent?, _ simple: SimpleColourTargets, _ oldValue: Accent?) {
////        guard style != nil && oldValue != nil else { return }
////        
////        if style!.colourOne != oldValue!.colourOne && liveUD {
////            guard simple != .Global else { return }
////            
////            GoXlr.shared.command(.SetSimpleColour(simple, style!.colourOne))
////        }
//    }
    
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
        
        global.assign(.Global)
        accent.assign(.Accent)
        if scribble1 != nil {
            scribble1?.assign(.Scribble1)
            scribble2?.assign(.Scribble2)
            scribble3?.assign(.Scribble3)
            scribble4?.assign(.Scribble4)
        }
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
@Patchable
public final class Accent: Codable, ObservableObject {
    public func command(for value: PartialKeyPath<Accent>, newValue: Any) -> GoXLRCommand? {
        return .SetSimpleColour(simple, newValue as! Color)
    }
    
    @Parameter public var colourOne: Color = .black

    private var simple: SimpleColourTargets = .Global
    
    func assign(_ simple: SimpleColourTargets) {
        self.simple = simple
        
        self._colourOne.setCommand({ .SetSimpleColour(simple, $0) })
    }
    
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
