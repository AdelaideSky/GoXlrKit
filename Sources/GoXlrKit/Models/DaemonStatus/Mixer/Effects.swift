//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 22/04/2023.
//

import Foundation

// MARK: - Effects
public class Effects: Codable, ObservableObject {
    @Published public var isEnabled: Bool { didSet { GoXlr.shared.command(.SetFXEnabled(isEnabled)) } }
    @Published public var activePreset: EffectBankPresets { didSet { GoXlr.shared.command(.SetActiveEffectPreset(activePreset)) } }
    @Published public var presetNames: PresetNames
    @Published public var current: CurrentEffectPreset

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
public class CurrentEffectPreset: Codable, ObservableObject {
    @Published public var reverb: Reverb
    @Published public var echo: EchoClass
    @Published public var pitch: Pitch
    @Published public var gender: Gender
    @Published public var megaphone: Megaphone
    @Published public var robot: Robot
    @Published public var hardTune: HardTune

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
public class EchoClass: Codable, ObservableObject {
    @Published public var style: EchoStyle { didSet { GoXlr.shared.command(.SetEchoStyle(style)) } }
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetEchoAmount(Int(amount))) } }
    @Published public var feedback: Float { didSet { GoXlr.shared.command(.SetEchoFeedback(Int(feedback))) } }
    @Published public var tempo: Float { didSet { GoXlr.shared.command(.SetEchoTempo(Int(tempo))) } }
    @Published public var delayLeft: Float { didSet { GoXlr.shared.command(.SetEchoDelayLeft(Int(delayLeft))) } }
    @Published public var delayRight: Float { didSet { GoXlr.shared.command(.SetEchoDelayRight(Int(delayRight))) } }
    @Published public var feedbackLeft: Float { didSet { GoXlr.shared.command(.SetEchoFeedbackLeft(Int(feedbackLeft))) } }
    @Published public var feedbackRight: Float { didSet { GoXlr.shared.command(.SetEchoFeedbackRight(Int(feedbackRight))) } }
    @Published public var feedbackXfbLToR: Float { didSet { GoXlr.shared.command(.SetEchoFeedbackXFBLtoR(Int(feedbackXfbLToR))) } }
    @Published public var feedbackXfbRToL: Float { didSet { GoXlr.shared.command(.SetEchoFeedbackXFBRtoL(Int(feedbackXfbRToL))) } }

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
public class Gender: Codable, ObservableObject {
    @Published public var style: GenderStyle { didSet { GoXlr.shared.command(.SetGenderStyle(style)) } }
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetGenderAmount(Int(amount))) } }
    
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
public class HardTune: Codable, ObservableObject {
    @Published public var isEnabled: Bool { didSet { GoXlr.shared.command(.SetHardTuneEnabled(isEnabled)) } }
    @Published public var style: HardTuneStyle { didSet { GoXlr.shared.command(.SetHardTuneStyle(style)) } }
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetHardTuneAmount(Int(amount))) } }
    @Published public var rate: Float { didSet { GoXlr.shared.command(.SetHardTuneRate(Int(rate))) } }
    @Published public var window: Float { didSet { GoXlr.shared.command(.SetHardTuneWindow(Int(window))) } }
    @Published public var source: HardTuneSource { didSet { GoXlr.shared.command(.SetHardTuneSource(source)) } }
    
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
public class Megaphone: Codable, ObservableObject {
    @Published public var isEnabled: Bool { didSet { GoXlr.shared.command(.SetMegaphoneEnabled(isEnabled)) } }
    @Published public var style: MegaphoneStyle { didSet { GoXlr.shared.command(.SetMegaphoneStyle(style)) } }
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetMegaphoneAmount(Int(amount))) } }
    @Published public var postGain: Float { didSet { GoXlr.shared.command(.SetMegaphonePostGain(Int(postGain))) } }

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
public class Pitch: Codable, ObservableObject {
    @Published public var style: PitchStyle { didSet { GoXlr.shared.command(.SetPitchStyle(style)) } }
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetPitchAmount(Int(amount))) } }
    @Published public var character: Float { didSet { GoXlr.shared.command(.SetPitchCharacter(Int(character))) } }

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
public class Reverb: Codable, ObservableObject {
    @Published public var style: ReverbStyle { didSet { GoXlr.shared.command(.SetReverbStyle(style)) } }
        
    @Published public var amount: Float { didSet { GoXlr.shared.command(.SetReverbAmount(Int(amount))) } }
    @Published public var decay: Float { didSet { GoXlr.shared.command(.SetReverbDecay(Int(decay))) } }
    @Published public var earlyLevel: Float { didSet { GoXlr.shared.command(.SetReverbEarlyLevel(Int(earlyLevel))) } }
    @Published public var tailLevel: Float { didSet { GoXlr.shared.command(.SetReverbTailLevel(Int(tailLevel))) } }
        
    @Published public var preDelay: Float { didSet { GoXlr.shared.command(.SetReverbPreDelay(Int(preDelay))) } }
    @Published public var loColour: Float { didSet { GoXlr.shared.command(.SetReverbLowColour(Int(loColour))) } }
    @Published public var hiColour: Float { didSet { GoXlr.shared.command(.SetReverbHighColour(Int(hiColour))) } }
    @Published public var hiFactor: Float { didSet { GoXlr.shared.command(.SetReverbHighFactor(Int(hiFactor))) } }
        
    @Published public var diffuse: Float { didSet { GoXlr.shared.command(.SetReverbDiffuse(Int(diffuse))) } }
    @Published public var modSpeed: Float { didSet { GoXlr.shared.command(.SetReverbModSpeed(Int(modSpeed))) } }
    @Published public var modDepth: Float { didSet { GoXlr.shared.command(.SetReverbModDepth(Int(modDepth))) } }

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
public class Robot: Codable, ObservableObject {
    @Published public var isEnabled: Bool
    @Published public var style: RobotStyle
    
    @Published public var lowGain: Float { didSet { GoXlr.shared.command(.SetRobotGain(.Low, Int(lowGain))) } }
    @Published public var lowFreq: Float { didSet { GoXlr.shared.command(.SetRobotFreq(.Low, Int(lowFreq))) } }
    @Published public var lowWidth: Float { didSet { GoXlr.shared.command(.SetRobotWidth(.Low, Int(lowWidth))) } }
    
    @Published public var midGain: Float { didSet { GoXlr.shared.command(.SetRobotGain(.Medium, Int(midGain))) } }
    @Published public var midFreq: Float { didSet { GoXlr.shared.command(.SetRobotFreq(.Medium, Int(midFreq))) } }
    @Published public var midWidth: Float { didSet { GoXlr.shared.command(.SetRobotWidth(.Medium, Int(midWidth))) } }
    
    @Published public var highGain: Float { didSet { GoXlr.shared.command(.SetRobotGain(.High, Int(highGain))) } }
    @Published public var highFreq: Float { didSet { GoXlr.shared.command(.SetRobotFreq(.High, Int(highFreq))) } }
    @Published public var highWidth: Float { didSet { GoXlr.shared.command(.SetRobotWidth(.High, Int(highWidth))) } }
    
    @Published public var waveform: Float { didSet { GoXlr.shared.command(.SetRobotWaveform(Int(waveform))) } }
    @Published public var pulseWidth: Float { didSet { GoXlr.shared.command(.SetRobotPulseWidth(Int(pulseWidth))) } }
    @Published public var threshold: Float { didSet { GoXlr.shared.command(.SetRobotThreshold(Int(threshold))) } }
    @Published public var dryMix: Float { didSet { GoXlr.shared.command(.SetRobotDryMix(Int(dryMix))) } }

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
public class PresetNames: Codable, ObservableObject {
    @Published public var preset1: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset1)) } }
    @Published public var preset2: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset2)) } }
    @Published public var preset3: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset3)) } }
    @Published public var preset4: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset4)) } }
    @Published public var preset5: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset5)) } }
    @Published public var preset6: String { didSet { GoXlr.shared.command(.RenameActivePreset(preset6)) } }

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
