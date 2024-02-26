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
public final class Effects: Codable, ObservableObject {
    @Parameter({ .SetFXEnabled($0) }) public var isEnabled: Bool = false
    @Parameter({ .SetActiveEffectPreset($0) }) public var activePreset: EffectBankPresets = .Preset1
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
public final class EchoClass: Codable, ObservableObject {
    @Parameter({ .SetEchoStyle($0) }) public var style: EchoStyle = .ClassicSlap
    @Parameter({ .SetEchoAmount(Int($0)) }) public var amount: Float = 0
    @Parameter({ .SetEchoFeedback(Int($0)) }) public var feedback: Float = 0
    @Parameter({ .SetEchoTempo(Int($0)) }) public var tempo: Float = 0
    @Parameter({ .SetEchoDelayLeft(Int($0)) }) public var delayLeft: Float = 0
    @Parameter({ .SetEchoDelayRight(Int($0)) }) public var delayRight: Float = 0
    @Parameter({ .SetEchoFeedbackLeft(Int($0)) }) public var feedbackLeft: Float = 0
    @Parameter({ .SetEchoFeedbackRight(Int($0)) }) public var feedbackRight: Float = 0
    @Parameter({ .SetEchoFeedbackXFBLtoR(Int($0)) }) public var feedbackXfbLToR: Float = 0
    @Parameter({ .SetEchoFeedbackXFBRtoL(Int($0)) }) public var feedbackXfbRToL: Float = 0

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
public final class Gender: Codable, ObservableObject {
    @Parameter({ .SetGenderStyle($0) }) public var style: GenderStyle = .Medium
    @Parameter({ .SetGenderAmount(Int($0)) }) public var amount: Float = 0
    
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
public final class HardTune: Codable, ObservableObject {
    @Parameter({ .SetHardTuneEnabled($0) }) public var isEnabled: Bool = false
    @Parameter({ .SetHardTuneStyle($0) }) public var style: HardTuneStyle = .Medium
    @Parameter({ .SetHardTuneAmount(Int($0)) }) public var amount: Float = 0
    @Parameter({ .SetHardTuneRate(Int($0)) }) public var rate: Float = 0
    @Parameter({ .SetHardTuneWindow(Int($0)) }) public var window: Float = 0
    @Parameter({ .SetHardTuneSource($0) }) public var source: HardTuneSource = .All
    
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
public final class Megaphone: Codable, ObservableObject {
    @Parameter({ .SetMegaphoneEnabled($0) }) public var isEnabled: Bool = false
    @Parameter({ .SetMegaphoneStyle($0) }) public var style: MegaphoneStyle = .Megaphone
    @Parameter({ .SetMegaphoneAmount(Int($0)) }) public var amount: Float = 0
    @Parameter({ .SetMegaphonePostGain(Int($0)) }) public var postGain: Float = 0

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
public final class Pitch: Codable, ObservableObject {
    @Parameter({ .SetPitchStyle($0) }) public var style: PitchStyle = .Narrow
    @Parameter({ .SetPitchAmount(Int($0)) }) public var amount: Float = 0
    @Parameter({ .SetPitchCharacter(Int($0)) }) public var character: Float = 0

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
public final class Reverb: Codable, ObservableObject {
    @Parameter({ .SetReverbStyle($0) }) public var style: ReverbStyle = .Chapel
        
    @Parameter({ .SetReverbAmount(Int($0)) }) public var amount: Float = 0
    @Parameter({ .SetReverbDecay(Int($0)) }) public var decay: Float = 0
    @Parameter({ .SetReverbEarlyLevel(Int($0)) }) public var earlyLevel: Float = 0
    @Parameter({ .SetReverbTailLevel(Int($0)) }) public var tailLevel: Float = 0
        
    @Parameter({ .SetReverbPreDelay(Int($0)) }) public var preDelay: Float = 0
    @Parameter({ .SetReverbLowColour(Int($0)) }) public var loColour: Float = 0
    @Parameter({ .SetReverbHighColour(Int($0)) }) public var hiColour: Float = 0
    @Parameter({ .SetReverbHighFactor(Int($0)) }) public var hiFactor: Float = 0
        
    @Parameter({ .SetReverbDiffuse(Int($0)) }) public var diffuse: Float = 0
    @Parameter({ .SetReverbModDepth(Int($0)) }) public var modSpeed: Float = 0
    @Parameter({ .SetReverbModSpeed(Int($0)) }) public var modDepth: Float = 0

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
public final class Robot: Codable, ObservableObject {
    @Parameter({ .SetRobotEnabled($0) }) public var isEnabled: Bool = false
    @Parameter({ .SetRobotStyle($0) }) public var style: RobotStyle = .Robot1
    
    @Parameter({ .SetRobotGain(.Low, Int($0)) }) public var lowGain: Float = 0
    @Parameter({ .SetRobotFreq(.Low, Int($0)) }) public var lowFreq: Float = 0
    @Parameter({ .SetRobotWidth(.Low, Int($0)) }) public var lowWidth: Float = 0
    
    @Parameter({ .SetRobotGain(.Medium, Int($0)) }) public var midGain: Float = 0
    @Parameter({ .SetRobotFreq(.Medium, Int($0)) }) public var midFreq: Float = 0
    @Parameter({ .SetRobotWidth(.Medium, Int($0)) }) public var midWidth: Float = 0
    
    @Parameter({ .SetRobotGain(.High, Int($0)) }) public var highGain: Float = 0
    @Parameter({ .SetRobotFreq(.High, Int($0)) }) public var highFreq: Float = 0
    @Parameter({ .SetRobotWidth(.High, Int($0)) }) public var highWidth: Float = 0
    
    @Parameter({ .SetRobotWaveform(Int($0)) }) public var waveform: Float = 0
    @Parameter({ .SetRobotPulseWidth(Int($0)) }) public var pulseWidth: Float = 0
    @Parameter({ .SetRobotThreshold(Int($0)) }) public var threshold: Float = 0
    @Parameter({ .SetRobotDryMix(Int($0)) }) public var dryMix: Float = 0

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
public final class PresetNames: Codable, ObservableObject {
    @Parameter({ .RenameActivePreset($0) }) public var preset1: String = ""
    @Parameter({ .RenameActivePreset($0) }) public var preset2: String = ""
    @Parameter({ .RenameActivePreset($0) }) public var preset3: String = ""
    @Parameter({ .RenameActivePreset($0) }) public var preset4: String = ""
    @Parameter({ .RenameActivePreset($0) }) public var preset5: String = ""
    @Parameter({ .RenameActivePreset($0) }) public var preset6: String = ""

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
