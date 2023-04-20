// This file was generated from JSON Schema using quicktype, do not modify it directly.
//
// Status structs.
import Foundation

public var valueUpdatedByUI = true

// MARK: - Status
/**
 Base Status struct. Only used to decode daemon's JSON. Doesn't contain any useful information.
 */
public class Status: Codable, ObservableObject {
    @Published public var id: Int
    @Published public var data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case id, data
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        data = try values.decode(DataClass.self, forKey: .data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(data, forKey: .data)
    }
}

// MARK: - DataClass
/**
 Enclosing struct of the status.
 */
public class DataClass: Codable, ObservableObject {
    @Published public var status: StatusClass

    enum CodingKeys: String, CodingKey {
        case status = "Status"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decode(StatusClass.self, forKey: .status)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
    }
}

// MARK: - StatusClass
/**
 Status struct. Root of the Daemon Status.
 */
public class StatusClass: Codable, ObservableObject {
    @Published public var config: Config
    @Published public var mixers: [String:Mixer]
    @Published public var paths: Paths
    @Published public var files: Files
    
    enum CodingKeys: String, CodingKey {
        case config, mixers, paths, files
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        config = try values.decode(Config.self, forKey: .config)
        mixers = try values.decode([String:Mixer].self, forKey: .mixers)
        paths = try values.decode(Paths.self, forKey: .paths)
        files = try values.decode(Files.self, forKey: .files)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(config, forKey: .config)
        try container.encode(mixers, forKey: .mixers)
        try container.encode(paths, forKey: .paths)
        try container.encode(files, forKey: .files)
    }
}

// MARK: - Config
public class Config: Codable, ObservableObject {
    @Published public var daemonVersion: String
    @Published public var autostartEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case daemonVersion = "daemon_version"
        case autostartEnabled = "autostart_enabled"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        daemonVersion = try values.decode(String.self, forKey: .daemonVersion)
        autostartEnabled = try values.decode(Bool.self, forKey: .autostartEnabled)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(daemonVersion, forKey: .daemonVersion)
        try container.encode(autostartEnabled, forKey: .autostartEnabled)
    }
}

// MARK: - Files
public class Files: Codable, ObservableObject {
    @Published public var profiles: [String]
    @Published public var micProfiles: [String]
    @Published public var presets: [String]
    @Published public var samples: [String: String]
    @Published public var icons: [String]

    enum CodingKeys: String, CodingKey {
        case profiles
        case micProfiles = "mic_profiles"
        case presets, samples, icons
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profiles = try values.decode([String].self, forKey: .profiles)
        micProfiles = try values.decode([String].self, forKey: .micProfiles)
        presets = try values.decode([String].self, forKey: .presets)
        
        samples = try values.decode([String: String].self, forKey: .samples)
        icons = try values.decode([String].self, forKey: .icons)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profiles, forKey: .profiles)
        try container.encode(micProfiles, forKey: .micProfiles)
        try container.encode(presets, forKey: .presets)
        try container.encode(samples, forKey: .samples)
        try container.encode(icons, forKey: .icons)
    }
}

// MARK: - Mixer
public class Mixer: Codable, ObservableObject {
    @Published public var hardware: Hardware
    @Published public var faderStatus: FadersStatus
    @Published public var micStatus: MicStatus
    @Published public var levels: Levels
    @Published public var router: Router
    @Published public var coughButton: CoughButton
    @Published public var lighting: Lighting
    @Published public var effects: Effects?
    @Published public var sampler: Sampler?
    @Published public var settings: Settings
    @Published public var button_down: ButtonDown
    @Published public var profileName: String { didSet { GoXlr.shared.command(.LoadProfile(profileName)) } }
    @Published public var micProfileName: String { didSet { GoXlr.shared.command(.LoadMicProfile(micProfileName)) } }

    enum CodingKeys: String, CodingKey {
        case hardware
        case faderStatus = "fader_status"
        case micStatus = "mic_status"
        case levels, router
        case coughButton = "cough_button"
        case lighting, effects, sampler, settings
        case button_down = "button_down"
        case profileName = "profile_name"
        case micProfileName = "mic_profile_name"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hardware = try values.decode(Hardware.self, forKey: .hardware)
        faderStatus = try values.decode(FadersStatus.self, forKey: .faderStatus)
        micStatus = try values.decode(MicStatus.self, forKey: .micStatus)
        levels = try values.decode(Levels.self, forKey: .levels)
        router = try values.decode(Router.self, forKey: .router)
        coughButton = try values.decode(CoughButton.self, forKey: .coughButton)
        lighting = try values.decode(Lighting.self, forKey: .lighting)
        effects = try values.decode(Effects?.self, forKey: .effects)
        sampler = try values.decode(Sampler.self, forKey: .sampler)
        settings = try values.decode(Settings.self, forKey: .settings)
        button_down = try values.decode(ButtonDown.self, forKey: .button_down)
        profileName = try values.decode(String.self, forKey: .profileName)
        micProfileName = try values.decode(String.self, forKey: .micProfileName)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hardware, forKey: .hardware)
        try container.encode(faderStatus, forKey: .faderStatus)
        try container.encode(micStatus, forKey: .micStatus)
        try container.encode(levels, forKey: .levels)
        try container.encode(router, forKey: .router)
        try container.encode(coughButton, forKey: .coughButton)
        try container.encode(lighting, forKey: .lighting)
        try container.encode(effects, forKey: .effects)
        try container.encode(sampler, forKey: .sampler)
        try container.encode(settings, forKey: .settings)
        try container.encode(button_down, forKey: .button_down)
        try container.encode(profileName, forKey: .profileName)
        try container.encode(micProfileName, forKey: .micProfileName)
    }
}

public class ButtonDown: Codable, ObservableObject {
    @Published public var Fader1Mute: Bool
    @Published public var Fader2Mute: Bool
    @Published public var Fader3Mute: Bool
    @Published public var Fader4Mute: Bool
    
    @Published public var Bleep: Bool
    @Published public var Cough: Bool

    // The rest are GoXLR Full Buttons. On the mini, they will simply be ignored.
    @Published public var EffectSelect1: Bool
    @Published public var EffectSelect2: Bool
    @Published public var EffectSelect3: Bool
    @Published public var EffectSelect4: Bool
    @Published public var EffectSelect5: Bool
    @Published public var EffectSelect6: Bool
    
    // FX Button labelled as 'fxClear' in config?
    @Published public var EffectFx: Bool
    @Published public var EffectMegaphone: Bool
    @Published public var EffectRobot: Bool
    @Published public var EffectHardTune: Bool

    @Published public var SamplerSelectA: Bool?
    @Published public var SamplerSelectB: Bool?
    @Published public var SamplerSelectC: Bool?

    @Published public var SamplerTopLeft: Bool
    @Published public var SamplerTopRight: Bool
    @Published public var SamplerBottomLeft: Bool
    @Published public var SamplerBottomRight: Bool
    @Published public var SamplerClear: Bool
    
    enum CodingKeys: String, CodingKey {
        case Fader1Mute, Fader2Mute, Fader3Mute, Fader4Mute
        case Bleep, Cough
        case EffectSelect1, EffectSelect2, EffectSelect3, EffectSelect4, EffectSelect5, EffectSelect6
        case EffectFx, EffectMegaphone, EffectRobot, EffectHardTune
        case SamplerSelectA, SamplerSelectB, SamplerSelectC
        case SamplerTopLeft, SamplerTopRight, SamplerBottomLeft, SamplerBottomRight, SamplerClear
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Fader1Mute = try container.decode(Bool.self, forKey: .Fader1Mute)
        Fader2Mute = try container.decode(Bool.self, forKey: .Fader2Mute)
        Fader3Mute = try container.decode(Bool.self, forKey: .Fader3Mute)
        Fader4Mute = try container.decode(Bool.self, forKey: .Fader4Mute)
        Bleep = try container.decode(Bool.self, forKey: .Bleep)
        Cough = try container.decode(Bool.self, forKey: .Cough)
        EffectSelect1 = try container.decode(Bool.self, forKey: .EffectSelect1)
        EffectSelect2 = try container.decode(Bool.self, forKey: .EffectSelect2)
        EffectSelect3 = try container.decode(Bool.self, forKey: .EffectSelect3)
        EffectSelect4 = try container.decode(Bool.self, forKey: .EffectSelect4)
        EffectSelect5 = try container.decode(Bool.self, forKey: .EffectSelect5)
        EffectSelect6 = try container.decode(Bool.self, forKey: .EffectSelect6)
        EffectFx = try container.decode(Bool.self, forKey: .EffectFx)
        EffectMegaphone = try container.decode(Bool.self, forKey: .EffectMegaphone)
        EffectRobot = try container.decode(Bool.self, forKey: .EffectRobot)
        EffectHardTune = try container.decode(Bool.self, forKey: .EffectHardTune)
        SamplerSelectA = try container.decodeIfPresent(Bool.self, forKey: .SamplerSelectA)
        SamplerSelectB = try container.decodeIfPresent(Bool.self, forKey: .SamplerSelectB)
        SamplerSelectC = try container.decodeIfPresent(Bool.self, forKey: .SamplerSelectC)
        SamplerTopLeft = try container.decode(Bool.self, forKey: .SamplerTopLeft)
        SamplerTopRight = try container.decode(Bool.self, forKey: .SamplerTopRight)
        SamplerBottomLeft = try container.decode(Bool.self, forKey: .SamplerBottomLeft)
        SamplerBottomRight = try container.decode(Bool.self, forKey: .SamplerBottomRight)
        SamplerClear = try container.decode(Bool.self, forKey: .SamplerClear)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(Fader1Mute, forKey: .Fader1Mute)
        try container.encode(Fader2Mute, forKey: .Fader2Mute)
        try container.encode(Fader3Mute, forKey: .Fader3Mute)
        try container.encode(Fader4Mute, forKey: .Fader4Mute)
        
        try container.encode(Bleep, forKey: .Bleep)
        try container.encode(Cough, forKey: .Cough)

        try container.encode(EffectSelect1, forKey: .EffectSelect1)
        try container.encode(EffectSelect2, forKey: .EffectSelect2)
        try container.encode(EffectSelect3, forKey: .EffectSelect3)
        try container.encode(EffectSelect4, forKey: .EffectSelect4)
        try container.encode(EffectSelect5, forKey: .EffectSelect5)
        try container.encode(EffectSelect6, forKey: .EffectSelect6)
        
        try container.encode(EffectFx, forKey: .EffectFx)
        try container.encode(EffectMegaphone, forKey: .EffectMegaphone)
        try container.encode(EffectRobot, forKey: .EffectRobot)
        try container.encode(EffectHardTune, forKey: .EffectHardTune)

        try container.encodeIfPresent(SamplerSelectA, forKey: .SamplerSelectA)
        try container.encodeIfPresent(SamplerSelectB, forKey: .SamplerSelectB)
        try container.encodeIfPresent(SamplerSelectC, forKey: .SamplerSelectC)

        try container.encode(SamplerTopLeft, forKey: .SamplerTopLeft)
        try container.encode(SamplerTopRight, forKey: .SamplerTopRight)
        try container.encode(SamplerBottomLeft, forKey: .SamplerBottomLeft)
        try container.encode(SamplerBottomRight, forKey: .SamplerBottomRight)
        try container.encode(SamplerClear, forKey: .SamplerClear)
    }
}

// MARK: - CoughButton
public class CoughButton: Codable, ObservableObject {
    @Published public var isToggle: Bool
    @Published public var muteType: String
    @Published public var state: String

    enum CodingKeys: String, CodingKey {
        case isToggle = "is_toggle"
        case muteType = "mute_type"
        case state
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isToggle = try values.decode(Bool.self, forKey: .isToggle)
        muteType = try values.decode(String.self, forKey: .muteType)
        state = try values.decode(String.self, forKey: .state)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isToggle, forKey: .isToggle)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(state, forKey: .state)
    }
}

// MARK: - Effects
public class Effects: Codable, ObservableObject {
    @Published public var isEnabled: Bool
    @Published public var activePreset: String
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
        activePreset = try values.decode(String.self, forKey: .activePreset)
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
public class Gender: Codable, ObservableObject {
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
public class HardTune: Codable, ObservableObject {
    @Published public var isEnabled: Bool
    @Published public var style: HardTuneStyle
    @Published public var amount: Float
    @Published public var rate: Float
    @Published public var window: Float
    @Published public var source: String
    
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
        source = try container.decode(String.self, forKey: .source)
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
public class Pitch: Codable, ObservableObject {
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
public class Reverb: Codable, ObservableObject {
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
public class Robot: Codable, ObservableObject {
    @Published public var isEnabled: Bool
    @Published public var style: RobotStyle
    
    @Published public var lowGain: Int
    @Published public var lowFreq: Int
    @Published public var lowWidth: Int
    
    @Published public var midGain: Int
    @Published public var midFreq: Int
    @Published public var midWidth: Int
    
    @Published public var highGain: Int
    @Published public var highFreq: Int
    @Published public var highWidth: Int
    
    @Published public var waveform: Int
    @Published public var pulseWidth: Int
    @Published public var threshold: Int
    @Published public var dryMix: Int

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
        lowGain = try values.decode(Int.self, forKey: .lowGain)
        lowFreq = try values.decode(Int.self, forKey: .lowFreq)
        lowWidth = try values.decode(Int.self, forKey: .lowWidth)
        midGain = try values.decode(Int.self, forKey: .midGain)
        midFreq = try values.decode(Int.self, forKey: .midFreq)
        midWidth = try values.decode(Int.self, forKey: .midWidth)
        highGain = try values.decode(Int.self, forKey: .highGain)
        highFreq = try values.decode(Int.self, forKey: .highFreq)
        highWidth = try values.decode(Int.self, forKey: .highWidth)
        waveform = try values.decode(Int.self, forKey: .waveform)
        pulseWidth = try values.decode(Int.self, forKey: .pulseWidth)
        threshold = try values.decode(Int.self, forKey: .threshold)
        dryMix = try values.decode(Int.self, forKey: .dryMix)
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
public class Scribble: Codable, ObservableObject {
    @Published public var fileName: String
    @Published public var bottomText: String
    @Published public var leftText: String?
    @Published public var inverted: Bool

    enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case bottomText = "bottom_text"
        case leftText = "left_text"
        case inverted
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try values.decode(String.self, forKey: .fileName)
        bottomText = try values.decode(String.self, forKey: .bottomText)
        leftText = try values.decode(String?.self, forKey: .leftText)
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

// MARK: - Hardware
public class Hardware: Codable, ObservableObject {
    @Published public var versions: Versions
    @Published public var serialNumber: String
    @Published public var manufacturedDate: String
    @Published public var deviceType: GoXlrModel
    @Published public var usbDevice: USBDevice

    enum CodingKeys: String, CodingKey {
        case versions = "versions"
        case serialNumber = "serial_number"
        case manufacturedDate = "manufactured_date"
        case deviceType = "device_type"
        case usbDevice = "usb_device"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        versions = try values.decode(Versions.self, forKey: .versions)
        serialNumber = try values.decode(String.self, forKey: .serialNumber)
        manufacturedDate = try values.decode(String.self, forKey: .manufacturedDate)
        deviceType = try values.decode(GoXlrModel.self, forKey: .deviceType)
        usbDevice = try values.decode(USBDevice.self, forKey: .usbDevice)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(versions, forKey: .versions)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(manufacturedDate, forKey: .manufacturedDate)
        try container.encode(deviceType, forKey: .deviceType)
        try container.encode(usbDevice, forKey: .usbDevice)
    }
}


// MARK: - USBDevice
public class USBDevice: Codable, ObservableObject {
    @Published public var manufacturerName: String
    @Published public var productName: String
    @Published public var version: [Int]
    @Published public var busNumber: Int
    @Published public var address: Int
    @Published public var identifier: JSONNull?

    enum CodingKeys: String, CodingKey {
        case manufacturerName = "manufacturer_name"
        case productName = "product_name"
        case version
        case busNumber = "bus_number"
        case address, identifier
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        manufacturerName = try values.decode(String.self, forKey: .manufacturerName)
        productName = try values.decode(String.self, forKey: .productName)
        version = try values.decode([Int].self, forKey: .version)
        busNumber = try values.decode(Int.self, forKey: .busNumber)
        address = try values.decode(Int.self, forKey: .address)
        identifier = try values.decode(JSONNull?.self, forKey: .identifier)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(manufacturerName, forKey: .manufacturerName)
        try container.encode(productName, forKey: .productName)
        try container.encode(version, forKey: .version)
        try container.encode(busNumber, forKey: .busNumber)
        try container.encode(address, forKey: .address)
        try container.encode(identifier, forKey: .identifier)
    }
}

// MARK: - Versions
public class Versions: Codable, ObservableObject {
    @Published public var firmware: [Int]
    @Published public var fpgaCount: Int
    @Published public var dice: [Int]

    enum CodingKeys: String, CodingKey {
        case firmware
        case fpgaCount = "fpga_count"
        case dice
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firmware = try values.decode([Int].self, forKey: .firmware)
        fpgaCount = try values.decode(Int.self, forKey: .fpgaCount)
        dice = try values.decode([Int].self, forKey: .dice)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firmware, forKey: .firmware)
        try container.encode(fpgaCount, forKey: .fpgaCount)
        try container.encode(dice, forKey: .dice)
    }
}

// MARK: - Levels
public class Levels: Codable, ObservableObject {
    @Published public var volumes: Volumes
    @Published public var bleep: Float
    @Published public var deess: Float

    enum CodingKeys: String, CodingKey {
        case volumes
        case bleep
        case deess
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        volumes = try values.decode(Volumes.self, forKey: .volumes)
        bleep = try values.decode(Float.self, forKey: .bleep)
        deess = try values.decode(Float.self, forKey: .deess)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(volumes, forKey: .volumes)
        try container.encode(bleep, forKey: .bleep)
        try container.encode(deess, forKey: .deess)
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

// MARK: - Lighting
public class Lighting: Codable, ObservableObject {
    @Published public var faders: FaderColors
    @Published public var buttons: [String: ButtonStyle]
    @Published public var simple: Simple
    @Published public var sampler: LightingSampler
    @Published public var encoders: Encoders

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
        buttons = try values.decode([String: ButtonStyle].self, forKey: .buttons)
        simple = try values.decode(Simple.self, forKey: .simple)
        sampler = try values.decode(LightingSampler.self, forKey: .sampler)
        encoders = try values.decode(Encoders.self, forKey: .encoders)
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


// MARK: - Button
public class ButtonStyle: Codable, ObservableObject {
    @Published public var offStyle: ButtonColourOffStyle
    @Published public var colours: Colours

    enum CodingKeys: String, CodingKey {
        case offStyle = "off_style"
        case colours
    }
    
    public required init(from decoder: Decoder) throws {
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
public class Colours: Codable, ObservableObject {
    @Published public var colourOne: String
    @Published public var colourTwo: String

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
        case colourTwo = "colour_two"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(String.self, forKey: .colourOne)
        colourTwo = try values.decode(String.self, forKey: .colourTwo)
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
    @Published public var colourOne: String
    @Published public var colourTwo: String
    @Published public var colourThree: String

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
        case colourTwo = "colour_two"
        case colourThree = "colour_three"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(String.self, forKey: .colourOne)
        colourTwo = try values.decode(String.self, forKey: .colourTwo)
        colourThree = try values.decode(String.self, forKey: .colourThree)
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

    enum CodingKeys: String, CodingKey {
        case c = "C"
        case b = "B"
        case a = "A"
        case d = "D"
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decode(FaderColor.self, forKey: .a)
        b = try values.decode(FaderColor.self, forKey: .b)
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
    @Published public var style: String
    @Published public var colours: Colours

    enum CodingKeys: String, CodingKey {
        case style
        case colours
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        style = try container.decode(String.self, forKey: .style)
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
    @Published public var scribble1: Accent?
    @Published public var scribble2: Accent?
    @Published public var scribble3: Accent?
    @Published public var scribble4: Accent?
    @Published public var global: Accent
    @Published public var accent: Accent

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
        scribble1 = try values.decode(Accent?.self, forKey: .scribble1)
        scribble2 = try values.decode(Accent?.self, forKey: .scribble2)
        scribble3 = try values.decode(Accent?.self, forKey: .scribble3)
        scribble4 = try values.decode(Accent?.self, forKey: .scribble4)
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
public class Accent: Codable, ObservableObject {
    @Published public var colourOne: String

    enum CodingKeys: String, CodingKey {
        case colourOne = "colour_one"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        colourOne = try values.decode(String.self, forKey: .colourOne)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colourOne, forKey: .colourOne)
    }
}

// MARK: - MicStatus
public class MicStatus: Codable, ObservableObject {
    @Published public var micType: String
    @Published public var micGains: MicGains
    @Published public var equaliser: Equaliser
    @Published public var equaliserMini: EqualiserMini
    @Published public var noiseGate: NoiseGate
    @Published public var compressor: Compressor

    enum CodingKeys: String, CodingKey {
        case micType = "mic_type"
        case micGains = "mic_gains"
        case equaliser
        case equaliserMini = "equaliser_mini"
        case noiseGate = "noise_gate"
        case compressor
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        micType = try values.decode(String.self, forKey: .micType)
        micGains = try values.decode(MicGains.self, forKey: .micGains)
        equaliser = try values.decode(Equaliser.self, forKey: .equaliser)
        equaliserMini = try values.decode(EqualiserMini.self, forKey: .equaliserMini)
        noiseGate = try values.decode(NoiseGate.self, forKey: .noiseGate)
        compressor = try values.decode(Compressor.self, forKey: .compressor)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(micType, forKey: .micType)
        try container.encode(micGains, forKey: .micGains)
        try container.encode(equaliser, forKey: .equaliser)
        try container.encode(equaliserMini, forKey: .equaliserMini)
        try container.encode(noiseGate, forKey: .noiseGate)
        try container.encode(compressor, forKey: .compressor)
    }
}

// MARK: - Compressor
public class Compressor: Codable, ObservableObject {
    @Published public var threshold: Float
    @Published public var ratio: Float
    @Published public var attack: Float
    @Published public var release: Float
    @Published public var makeupGain: Float

    enum CodingKeys: String, CodingKey {
        case threshold, ratio, attack, release
        case makeupGain = "makeup_gain"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        threshold = try values.decode(Float.self, forKey: .threshold)
        ratio = try values.decode(Float.self, forKey: .ratio)
        attack = try values.decode(Float.self, forKey: .attack)
        release = try values.decode(Float.self, forKey: .release)
        makeupGain = try values.decode(Float.self, forKey: .makeupGain)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(threshold, forKey: .threshold)
        try container.encode(ratio, forKey: .ratio)
        try container.encode(attack, forKey: .attack)
        try container.encode(release, forKey: .release)
        try container.encode(makeupGain, forKey: .makeupGain)
    }
}

// MARK: - Equaliser
public class Equaliser: Codable, ObservableObject {
    @Published public var gain: [String: Double]
    @Published public var frequency: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case gain, frequency
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gain = try values.decode([String: Double].self, forKey: .gain)
        frequency = try values.decode([String: Double].self, forKey: .frequency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gain, forKey: .gain)
        try container.encode(frequency, forKey: .frequency)
    }
}

// MARK: - EqualiserMini
public class EqualiserMini: Codable, ObservableObject {
    @Published public var gain: Frequency
    @Published public var frequency: Frequency
    
    enum CodingKeys: String, CodingKey {
        case gain, frequency
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gain = try values.decode(Frequency.self, forKey: .gain)
        frequency = try values.decode(Frequency.self, forKey: .frequency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gain, forKey: .gain)
        try container.encode(frequency, forKey: .frequency)
    }
}

// MARK: - Frequency
public class Frequency: Codable, ObservableObject {
    @Published public var equalizer250Hz: Float
    @Published public var equalizer1KHz: Float
    @Published public var equalizer500Hz: Float
    @Published public var equalizer8KHz: Float
    @Published public var equalizer90Hz: Float
    @Published public var equalizer3KHz: Float

    enum CodingKeys: String, CodingKey {
        case equalizer250Hz = "Equalizer250Hz"
        case equalizer1KHz = "Equalizer1KHz"
        case equalizer500Hz = "Equalizer500Hz"
        case equalizer8KHz = "Equalizer8KHz"
        case equalizer90Hz = "Equalizer90Hz"
        case equalizer3KHz = "Equalizer3KHz"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        equalizer250Hz = try values.decode(Float.self, forKey: .equalizer250Hz)
        equalizer1KHz = try values.decode(Float.self, forKey: .equalizer1KHz)
        equalizer500Hz = try values.decode(Float.self, forKey: .equalizer500Hz)
        equalizer8KHz = try values.decode(Float.self, forKey: .equalizer8KHz)
        equalizer90Hz = try values.decode(Float.self, forKey: .equalizer90Hz)
        equalizer3KHz = try values.decode(Float.self, forKey: .equalizer3KHz)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(equalizer250Hz, forKey: .equalizer250Hz)
        try container.encode(equalizer1KHz, forKey: .equalizer1KHz)
        try container.encode(equalizer500Hz, forKey: .equalizer500Hz)
        try container.encode(equalizer8KHz, forKey: .equalizer8KHz)
        try container.encode(equalizer90Hz, forKey: .equalizer90Hz)
        try container.encode(equalizer3KHz, forKey: .equalizer3KHz)
    }
}

// MARK: - MicGains
public class MicGains: Codable, ObservableObject {
    @Published public var micGainsDynamic: Float
    @Published public var condenser: Float
    @Published public var jack: Float

    enum CodingKeys: String, CodingKey {
        case micGainsDynamic = "Dynamic"
        case condenser = "Condenser"
        case jack = "Jack"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        micGainsDynamic = try values.decode(Float.self, forKey: .micGainsDynamic)
        condenser = try values.decode(Float.self, forKey: .condenser)
        jack = try values.decode(Float.self, forKey: .jack)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(micGainsDynamic, forKey: .micGainsDynamic)
        try container.encode(condenser, forKey: .condenser)
        try container.encode(jack, forKey: .jack)
    }
}

// MARK: - NoiseGate
public class NoiseGate: Codable, ObservableObject {
    @Published public var threshold: Float
    @Published public var attack: Float
    @Published public var release: Float
    @Published public var enabled: Bool
    @Published public var attenuation: Float
    
    enum CodingKeys: String, CodingKey {
        case threshold, attack, release, enabled, attenuation
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        threshold = try values.decode(Float.self, forKey: .threshold)
        attack = try values.decode(Float.self, forKey: .attack)
        release = try values.decode(Float.self, forKey: .release)
        enabled = try values.decode(Bool.self, forKey: .enabled)
        attenuation = try values.decode(Float.self, forKey: .attenuation)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(threshold, forKey: .threshold)
        try container.encode(attack, forKey: .attack)
        try container.encode(release, forKey: .release)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(attenuation, forKey: .attenuation)
    }
}

// MARK: - Router
public class Router: Codable, ObservableObject {
    @Published public var microphone: Chat
    @Published public var chat: Chat
    @Published public var music: Chat
    @Published public var game: Chat
    @Published public var console: Chat
    @Published public var lineIn: Chat
    @Published public var system: Chat
    @Published public var samples: Chat

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
        self.microphone = try container.decode(Chat.self, forKey: .microphone)
        self.chat = try container.decode(Chat.self, forKey: .chat)
        self.music = try container.decode(Chat.self, forKey: .music)
        self.game = try container.decode(Chat.self, forKey: .game)
        self.console = try container.decode(Chat.self, forKey: .console)
        self.lineIn = try container.decode(Chat.self, forKey: .lineIn)
        self.system = try container.decode(Chat.self, forKey: .system)
        self.samples = try container.decode(Chat.self, forKey: .samples)
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

// MARK: - Chat
public class Chat: Codable, ObservableObject {
    @Published public var headphones: Bool
    @Published public var broadcastMix: Bool
    @Published public var lineOut: Bool
    @Published public var chatMic: Bool
    @Published public var sampler: Bool

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

// MARK: - S210401735CQKSampler
public class Sampler: Codable, ObservableObject {
    @Published public var banks: Banks

    enum CodingKeys: String, CodingKey {
        case banks
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banks = try values.decode(Banks.self, forKey: .banks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(banks, forKey: .banks)
    }
}


// MARK: - Banks
public class Banks: Codable, ObservableObject {
    @Published public var A: Bank
    @Published public var B: Bank
    @Published public var C: Bank

    enum CodingKeys: String, CodingKey {
        case C = "C"
        case A = "A"
        case B = "B"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        A = try values.decode(Bank.self, forKey: .A)
        B = try values.decode(Bank.self, forKey: .B)
        C = try values.decode(Bank.self, forKey: .C)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(A, forKey: .A)
        try container.encode(B, forKey: .B)
        try container.encode(C, forKey: .C)
    }
}

// MARK: - BanksA
public class Bank: Codable, ObservableObject {
    @Published public var BottomLeft: SamplerButton
    @Published public var TopLeft: SamplerButton
    @Published public var TopRight: SamplerButton
    @Published public var BottomRight: SamplerButton
    
    enum CodingKeys: String, CodingKey {
        case BottomLeft = "BottomLeft"
        case TopLeft = "TopLeft"
        case TopRight = "TopRight"
        case BottomRight = "BottomRight"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        BottomLeft = try container.decode(SamplerButton.self, forKey: .BottomLeft)
        TopLeft = try container.decode(SamplerButton.self, forKey: .TopLeft)
        TopRight = try container.decode(SamplerButton.self, forKey: .TopRight)
        BottomRight = try container.decode(SamplerButton.self, forKey: .BottomRight)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(BottomLeft, forKey: .BottomLeft)
        try container.encode(TopLeft, forKey: .TopLeft)
        try container.encode(TopRight, forKey: .TopRight)
        try container.encode(BottomRight, forKey: .BottomRight)
    }
}

// MARK: - BottomLeft
public class SamplerButton: Codable, ObservableObject {
    @Published public var function: SamplePlaybackMode
    @Published public var order: SamplePlayOrder
    @Published public var samples: [JSONAny]
    @Published public var is_playing: Bool

    enum CodingKeys: String, CodingKey {
        case function, order, samples
        case is_playing = "is_playing"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.function = try container.decode(SamplePlaybackMode.self, forKey: .function)
        self.order = try container.decode(SamplePlayOrder.self, forKey: .order)
        self.samples = try container.decode([JSONAny].self, forKey: .samples)
        self.is_playing = try container.decode(Bool.self, forKey: .is_playing)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.function, forKey: .function)
        try container.encode(self.order, forKey: .order)
        try container.encode(self.samples, forKey: .samples)
        try container.encode(self.is_playing, forKey: .is_playing)
    }
}

// MARK: - Settings
public class Settings: Codable, ObservableObject {
    @Published public var display: Display
    @Published public var muteHoldDuration: Int
    @Published public var vcMuteAlsoMuteCM: Bool

    enum CodingKeys: String, CodingKey {
        case display
        case muteHoldDuration = "mute_hold_duration"
        case vcMuteAlsoMuteCM = "vc_mute_also_mute_cm"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        display = try container.decode(Display.self, forKey: .display)
        muteHoldDuration = try container.decode(Int.self, forKey: .muteHoldDuration)
        vcMuteAlsoMuteCM = try container.decode(Bool.self, forKey: .vcMuteAlsoMuteCM)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(display, forKey: .display)
        try container.encode(muteHoldDuration, forKey: .muteHoldDuration)
        try container.encode(vcMuteAlsoMuteCM, forKey: .vcMuteAlsoMuteCM)
    }
}

// MARK: - Display
public class Display: Codable, ObservableObject {
    @Published public var gate: String
    @Published public var compressor: String
    @Published public var equaliser: String
    @Published public var equaliserFine: String
    
    enum CodingKeys: String, CodingKey {
        case gate, compressor, equaliser
        case equaliserFine = "equaliser_fine"
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gate = try container.decode(String.self, forKey: .gate)
        compressor = try container.decode(String.self, forKey: .compressor)
        equaliser = try container.decode(String.self, forKey: .equaliser)
        equaliserFine = try container.decode(String.self, forKey: .equaliserFine)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gate, forKey: .gate)
        try container.encode(compressor, forKey: .compressor)
        try container.encode(equaliser, forKey: .equaliser)
        try container.encode(equaliserFine, forKey: .equaliserFine)
    }
}

// MARK: - Paths
public class Paths: Codable, ObservableObject {
    @Published public var profileDirectory: String
    @Published public var micProfileDirectory: String
    @Published public var samplesDirectory: String
    @Published public var presetsDirectory: String
    @Published public var iconsDirectory: String

    enum CodingKeys: String, CodingKey {
        case profileDirectory = "profile_directory"
        case micProfileDirectory = "mic_profile_directory"
        case samplesDirectory = "samples_directory"
        case presetsDirectory = "presets_directory"
        case iconsDirectory = "icons_directory"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        profileDirectory = try container.decode(String.self, forKey: .profileDirectory)
        micProfileDirectory = try container.decode(String.self, forKey: .micProfileDirectory)
        samplesDirectory = try container.decode(String.self, forKey: .samplesDirectory)
        presetsDirectory = try container.decode(String.self, forKey: .presetsDirectory)
        iconsDirectory = try container.decode(String.self, forKey: .iconsDirectory)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(profileDirectory, forKey: .profileDirectory)
        try container.encode(micProfileDirectory, forKey: .micProfileDirectory)
        try container.encode(samplesDirectory, forKey: .samplesDirectory)
        try container.encode(presetsDirectory, forKey: .presetsDirectory)
        try container.encode(iconsDirectory, forKey: .iconsDirectory)
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    public let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    public var intValue: Int? {
        return nil
    }

    public var stringValue: String {
        return key
    }
}

public class JSONAny: Codable {

    public let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
