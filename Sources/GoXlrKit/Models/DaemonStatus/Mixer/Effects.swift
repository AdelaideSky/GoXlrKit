//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 22/04/2023.
//

import Foundation
import Patchable

// MARK: - Effects
@Patchable
public final class Effects: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Effects>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.isEnabled:
            return .SetFXEnabled(newValue as! Bool)
        case \.activePreset:
            return .SetActiveEffectPreset(newValue as! EffectBankPresets)
        default: return nil
        }
    }
    
    
    @Published public var isEnabled: Bool
    @Published public var activePreset: EffectBankPresets 
    @child @Published public var presetNames: PresetNames
    @child @Published public var current: CurrentEffectPreset

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case activePreset = "active_preset"
        case presetNames = "preset_names"
        case current
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try values.decode(Bool.self, forKey: .isEnabled)
        activePreset = try values.decode(EffectBankPresets.self, forKey: .activePreset)
        presetNames = try values.decode(PresetNames.self, forKey: .presetNames)
        current = try values.decode(CurrentEffectPreset.self, forKey: .current)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isEnabled, forKey: .isEnabled)
        try container.encode(activePreset, forKey: .activePreset)
        try container.encode(presetNames, forKey: .presetNames)
        try container.encode(current, forKey: .current)
    }
    
}

// MARK: - Current
@Patchable
public class CurrentEffectPreset: Codable, ObservableObject {
    @child @Published public var reverb: Reverb
    @child @Published public var echo: EchoClass
    @child @Published public var pitch: Pitch
    @child @Published public var gender: Gender
    @child @Published public var megaphone: Megaphone
    @child @Published public var robot: Robot
    @child @Published public var hardTune: HardTune

    enum CodingKeys: String, CodingKey {
        case reverb, echo, pitch, gender, megaphone, robot
        case hardTune = "hard_tune"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reverb = try values.decode(Reverb.self, forKey: .reverb)
        echo = try values.decode(EchoClass.self, forKey: .echo)
        pitch = try values.decode(Pitch.self, forKey: .pitch)
        gender = try values.decode(Gender.self, forKey: .gender)
        megaphone = try values.decode(Megaphone.self, forKey: .megaphone)
        robot = try values.decode(Robot.self, forKey: .robot)
        hardTune = try values.decode(HardTune.self, forKey: .hardTune)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reverb, forKey: .reverb)
        try container.encode(echo, forKey: .echo)
        try container.encode(pitch, forKey: .pitch)
        try container.encode(gender, forKey: .gender)
        try container.encode(megaphone, forKey: .megaphone)
        try container.encode(robot, forKey: .robot)
        try container.encode(hardTune, forKey: .hardTune)
    }
}

// MARK: - EchoClass
@Patchable
public final class EchoClass: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<EchoClass>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.style:
            return .SetEchoStyle(newValue as! EchoStyle)
        case \.amount:
            return .SetEchoAmount(Int(newValue as! Float))
        case \.feedback:
            return .SetEchoFeedback(Int(newValue as! Float))
        case \.tempo:
            return .SetEchoTempo(Int(newValue as! Float))
        case \.delayLeft:
            return .SetEchoDelayLeft(Int(newValue as! Float))
        case \.delayRight:
            return .SetEchoDelayRight(Int(newValue as! Float))
        case \.feedbackLeft:
            return .SetEchoFeedbackLeft(Int(newValue as! Float))
        case \.feedbackRight:
            return .SetEchoFeedbackRight(Int(newValue as! Float))
        case \.feedbackXfbLToR:
            return .SetEchoFeedbackXFBLtoR(Int(newValue as! Float))
        case \.feedbackXfbRToL:
            return .SetEchoFeedbackXFBRtoL(Int(newValue as! Float))
        default: return nil
        }
    }
    
    
    @Published public var style: EchoStyle
    @Published public var amount: Float
    @Published public var feedback: Float
    @Published public var tempo: Float
    @Published public var delayLeft: Float
    @Published public var delayRight: Float
    @Published public var feedbackLeft: Float
    @Published public var feedbackRight: Float
    @Published public var feedbackXfbLToR: Float
    @Published public var feedbackXfbRToL: Float

    enum CodingKeys: String, CodingKey {
        case style, amount, feedback, tempo
        case delayLeft = "delay_left"
        case delayRight = "delay_right"
        case feedbackLeft = "feedback_left"
        case feedbackRight = "feedback_right"
        case feedbackXfbLToR = "feedback_xfb_l_to_r"
        case feedbackXfbRToL = "feedback_xfb_r_to_l"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(EchoStyle.self, forKey: .style)
        amount = try container.decode(Float.self, forKey: .amount)
        feedback = try container.decode(Float.self, forKey: .feedback)
        tempo = try container.decode(Float.self, forKey: .tempo)
        delayLeft = try container.decode(Float.self, forKey: .delayLeft)
        delayRight = try container.decode(Float.self, forKey: .delayRight)
        feedbackLeft = try container.decode(Float.self, forKey: .feedbackLeft)
        feedbackRight = try container.decode(Float.self, forKey: .feedbackRight)
        feedbackXfbLToR = try container.decode(Float.self, forKey: .feedbackXfbLToR)
        feedbackXfbRToL = try container.decode(Float.self, forKey: .feedbackXfbRToL)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
        try container.encode(feedback, forKey: .feedback)
        try container.encode(tempo, forKey: .tempo)
        try container.encode(delayLeft, forKey: .delayLeft)
        try container.encode(delayRight, forKey: .delayRight)
        try container.encode(feedbackLeft, forKey: .feedbackLeft)
        try container.encode(feedbackRight, forKey: .feedbackRight)
        try container.encode(feedbackXfbLToR, forKey: .feedbackXfbLToR)
        try container.encode(feedbackXfbRToL, forKey: .feedbackXfbRToL)
    }
}

// MARK: - Gender
@Patchable
public final class Gender: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Gender>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.style:
            return .SetGenderStyle(newValue as! GenderStyle)
        case \.amount:
            return .SetGenderAmount(Int(newValue as! Float))
        default: return nil
        }
    }
    
    @Published public var style: GenderStyle
    @Published public var amount: Float
    
    enum CodingKeys: String, CodingKey {
        case style, amount
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        style = try values.decode(GenderStyle.self, forKey: .style)
        amount = try values.decode(Float.self, forKey: .amount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
    }
}


// MARK: - HardTune
@Patchable
public final class HardTune: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<HardTune>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.isEnabled:
            return .SetHardTuneEnabled(newValue as! Bool)
        case \.style:
            return .SetHardTuneStyle(newValue as! HardTuneStyle)
        case \.amount:
            return .SetHardTuneAmount(Int(newValue as! Float))
        case \.rate:
            return .SetHardTuneRate(Int(newValue as! Float))
        case \.window:
            return .SetHardTuneWindow(Int(newValue as! Float))
        case \.source:
            return .SetHardTuneSource(newValue as! HardTuneSource)
        default: return nil
        }
    }
    
    
    
    @Published public var isEnabled: Bool
    @Published public var style: HardTuneStyle
    @Published public var amount: Float
    @Published public var rate: Float
    @Published public var window: Float
    @Published public var source: HardTuneSource
    
    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case style, amount, rate, window, source
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
        style = try container.decode(HardTuneStyle.self, forKey: .style)
        amount = try container.decode(Float.self, forKey: .amount)
        rate = try container.decode(Float.self, forKey: .rate)
        window = try container.decode(Float.self, forKey: .window)
        source = try container.decode(HardTuneSource.self, forKey: .source)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isEnabled, forKey: .isEnabled)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
        try container.encode(rate, forKey: .rate)
        try container.encode(window, forKey: .window)
        try container.encode(source, forKey: .source)
    }
}

// MARK: - Megaphone
@Patchable
public final class Megaphone: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Megaphone>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.isEnabled:
            return .SetMegaphoneEnabled(newValue as! Bool)
        case \.style:
            return .SetMegaphoneStyle(newValue as! MegaphoneStyle)
        case \.amount:
            return .SetMegaphoneAmount(Int(newValue as! Float))
        case \.postGain:
            return .SetMegaphonePostGain(Int(newValue as! Float))
        default: return nil
        }
    }
    

    @Published public var isEnabled: Bool
    @Published public var style: MegaphoneStyle
    @Published public var amount: Float
    @Published public var postGain: Float

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case style, amount
        case postGain = "post_gain"
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
        style = try container.decode(MegaphoneStyle.self, forKey: .style)
        amount = try container.decode(Float.self, forKey: .amount)
        postGain = try container.decode(Float.self, forKey: .postGain)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isEnabled, forKey: .isEnabled)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
        try container.encode(postGain, forKey: .postGain)
    }
}

// MARK: - Pitch
@Patchable
public final class Pitch: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Pitch>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.style:
            .SetPitchStyle(newValue as! PitchStyle)
        case \.amount:
            .SetPitchAmount(Int(newValue as! Float))
        case \.character:
            .SetPitchCharacter(Int(newValue as! Float))
        default: nil
        }
    }
    
    @Published public var style: PitchStyle
    @Published public var amount: Float
    @Published public var character: Float

    enum CodingKeys: String, CodingKey {
        case style, amount, character
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        style = try values.decode(PitchStyle.self, forKey: .style)
        amount = try values.decode(Float.self, forKey: .amount)
        character = try values.decode(Float.self, forKey: .character)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
        try container.encode(character, forKey: .character)
    }
}


// MARK: - Reverb
@Patchable
public final class Reverb: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Reverb>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.style: .SetReverbStyle(newValue as! ReverbStyle)
        case \.amount: .SetReverbAmount(Int(newValue as! Float))
        case \.decay: .SetReverbDecay(Int(newValue as! Float))
        case \.earlyLevel: .SetReverbEarlyLevel(Int(newValue as! Float))
        case \.tailLevel: .SetReverbTailLevel(Int(newValue as! Float))
        case \.preDelay: .SetReverbPreDelay(Int(newValue as! Float))
        case \.loColour: .SetReverbLowColour(Int(newValue as! Float))
        case \.hiColour: .SetReverbHighColour(Int(newValue as! Float))
        case \.hiFactor: .SetReverbHighFactor(Int(newValue as! Float))
        case \.diffuse: .SetReverbDiffuse(Int(newValue as! Float))
        case \.modDepth: .SetReverbModDepth(Int(newValue as! Float))
        case \.modSpeed: .SetReverbModSpeed(Int(newValue as! Float))
        default: nil
        }
    }
    
    @Published public var style: ReverbStyle
        
    @Published public var amount: Float
    @Published public var decay: Float
    @Published public var earlyLevel: Float
    @Published public var tailLevel: Float
        
    @Published public var preDelay: Float
    @Published public var loColour: Float
    @Published public var hiColour: Float
    @Published public var hiFactor: Float
        
    @Published public var diffuse: Float
    @Published public var modSpeed: Float
    @Published public var modDepth: Float

    enum CodingKeys: String, CodingKey {
        case style, amount, decay
        case earlyLevel = "early_level"
        case tailLevel = "tail_level"
        case preDelay = "pre_delay"
        case loColour = "lo_colour"
        case hiColour = "hi_colour"
        case hiFactor = "hi_factor"
        case diffuse
        case modSpeed = "mod_speed"
        case modDepth = "mod_depth"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(ReverbStyle.self, forKey: .style)
        amount = try container.decode(Float.self, forKey: .amount)
        decay = try container.decode(Float.self, forKey: .decay)
        earlyLevel = try container.decode(Float.self, forKey: .earlyLevel)
        tailLevel = try container.decode(Float.self, forKey: .tailLevel)
        preDelay = try container.decode(Float.self, forKey: .preDelay)
        loColour = try container.decode(Float.self, forKey: .loColour)
        hiColour = try container.decode(Float.self, forKey: .hiColour)
        hiFactor = try container.decode(Float.self, forKey: .hiFactor)
        diffuse = try container.decode(Float.self, forKey: .diffuse)
        modSpeed = try container.decode(Float.self, forKey: .modSpeed)
        modDepth = try container.decode(Float.self, forKey: .modDepth)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(style, forKey: .style)
        try container.encode(amount, forKey: .amount)
        try container.encode(decay, forKey: .decay)
        try container.encode(earlyLevel, forKey: .earlyLevel)
        try container.encode(tailLevel, forKey: .tailLevel)
        try container.encode(preDelay, forKey: .preDelay)
        try container.encode(loColour, forKey: .loColour)
        try container.encode(hiColour, forKey: .hiColour)
        try container.encode(hiFactor, forKey: .hiFactor)
        try container.encode(diffuse, forKey: .diffuse)
        try container.encode(modSpeed, forKey: .modSpeed)
        try container.encode(modDepth, forKey: .modDepth)
    }
}

// MARK: - Robot
@Patchable
public final class Robot: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Robot>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.isEnabled: .SetRobotEnabled(newValue as! Bool)
        case \.style: .SetRobotStyle(newValue as! RobotStyle)
        case \.lowGain: .SetRobotGain(.Low, Int(newValue as! Float))
        case \.lowFreq: .SetRobotFreq(.Low, Int(newValue as! Float))
        case \.lowWidth: .SetRobotWidth(.Low, Int(newValue as! Float))
            
        case \.midGain: .SetRobotGain(.Medium, Int(newValue as! Float))
        case \.midFreq: .SetRobotFreq(.Medium, Int(newValue as! Float))
        case \.midWidth: .SetRobotWidth(.Medium, Int(newValue as! Float))
            
        case \.highGain: .SetRobotGain(.High, Int(newValue as! Float))
        case \.highFreq: .SetRobotFreq(.High, Int(newValue as! Float))
        case \.highWidth: .SetRobotWidth(.High, Int(newValue as! Float))
        default: nil
        }
    }
    
    
    @Published public var isEnabled: Bool
    @Published public var style: RobotStyle
    
    @Published public var lowGain: Float
    @Published public var lowFreq: Float
    @Published public var lowWidth: Float 
    
    @Published public var midGain: Float
    @Published public var midFreq: Float
    @Published public var midWidth: Float
    
    @Published public var highGain: Float
    @Published public var highFreq: Float
    @Published public var highWidth: Float
    
    @Published public var waveform: Float
    @Published public var pulseWidth: Float
    @Published public var threshold: Float
    @Published public var dryMix: Float

    enum CodingKeys: String, CodingKey {
        case isEnabled = "is_enabled"
        case style
        case lowGain = "low_gain"
        case lowFreq = "low_freq"
        case lowWidth = "low_width"
        case midGain = "mid_gain"
        case midFreq = "mid_freq"
        case midWidth = "mid_width"
        case highGain = "high_gain"
        case highFreq = "high_freq"
        case highWidth = "high_width"
        case waveform
        case pulseWidth = "pulse_width"
        case threshold
        case dryMix = "dry_mix"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isEnabled = try values.decode(Bool.self, forKey: .isEnabled)
        style = try values.decode(RobotStyle.self, forKey: .style)
        lowGain = try values.decode(Float.self, forKey: .lowGain)
        lowFreq = try values.decode(Float.self, forKey: .lowFreq)
        lowWidth = try values.decode(Float.self, forKey: .lowWidth)
        midGain = try values.decode(Float.self, forKey: .midGain)
        midFreq = try values.decode(Float.self, forKey: .midFreq)
        midWidth = try values.decode(Float.self, forKey: .midWidth)
        highGain = try values.decode(Float.self, forKey: .highGain)
        highFreq = try values.decode(Float.self, forKey: .highFreq)
        highWidth = try values.decode(Float.self, forKey: .highWidth)
        waveform = try values.decode(Float.self, forKey: .waveform)
        pulseWidth = try values.decode(Float.self, forKey: .pulseWidth)
        threshold = try values.decode(Float.self, forKey: .threshold)
        dryMix = try values.decode(Float.self, forKey: .dryMix)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isEnabled, forKey: .isEnabled)
        try container.encode(style, forKey: .style)
        try container.encode(lowGain, forKey: .lowGain)
        try container.encode(lowFreq, forKey: .lowFreq)
        try container.encode(lowWidth, forKey: .lowWidth)
        try container.encode(midGain, forKey: .midGain)
        try container.encode(midFreq, forKey: .midFreq)
        try container.encode(midWidth, forKey: .midWidth)
        try container.encode(highGain, forKey: .highGain)
        try container.encode(highFreq, forKey: .highFreq)
        try container.encode(highWidth, forKey: .highWidth)
        try container.encode(waveform, forKey: .waveform)
        try container.encode(pulseWidth, forKey: .pulseWidth)
        try container.encode(threshold, forKey: .threshold)
        try container.encode(dryMix, forKey: .dryMix)
    }
}

// MARK: - PresetNames
// WARNING: - Renaming presets only renames ACTIVE preset. Make sure to update names ONLY when the preset is active
@Patchable
public final class PresetNames: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<PresetNames>, newValue: Any) -> GoXLRCommand? {
        if let newValue = newValue as? String {
            return .RenameActivePreset(newValue)
        }
        return nil
    }
    
    @Published public var preset1: String
    @Published public var preset2: String
    @Published public var preset3: String
    @Published public var preset4: String
    @Published public var preset5: String
    @Published public var preset6: String

    enum CodingKeys: String, CodingKey {
        case preset5 = "Preset5"
        case preset2 = "Preset2"
        case preset1 = "Preset1"
        case preset3 = "Preset3"
        case preset4 = "Preset4"
        case preset6 = "Preset6"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        preset1 = try values.decode(String.self, forKey: .preset1)
        preset2 = try values.decode(String.self, forKey: .preset2)
        preset3 = try values.decode(String.self, forKey: .preset3)
        preset4 = try values.decode(String.self, forKey: .preset4)
        preset5 = try values.decode(String.self, forKey: .preset5)
        preset6 = try values.decode(String.self, forKey: .preset6)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(preset1, forKey: .preset1)
        try container.encode(preset2, forKey: .preset2)
        try container.encode(preset3, forKey: .preset3)
        try container.encode(preset4, forKey: .preset4)
        try container.encode(preset5, forKey: .preset5)
        try container.encode(preset6, forKey: .preset6)
    }
}
