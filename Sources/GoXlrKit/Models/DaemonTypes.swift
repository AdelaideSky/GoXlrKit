//
//  DaemonTypes.swift
//
//  Used to store all Daemon structs
//  Translated in Swift from https://github.com/GoXLR-on-Linux/goxlr-utility/blob/main/types/src/lib.rs
//
//  Created by Adélaïde Sky on 27/12/2022.
//

import Foundation

public enum ChannelName: String, Codable, CaseIterable {
    case Mic,
    LineIn,
    Console,
    System,
    Game,
    Chat,
    Sample,
    Music,
    Headphones,
    MicMonitor,
    LineOut
}


public enum FaderName: String, Codable, Hashable {
    case A,
    B,
    C,
    D
}
public enum GoXlrModel: String, Codable, Hashable {
    case Full
    case Mini
}


public enum EncoderName: Double, Codable {
    case Pitch = 0x00,
    Gender = 0x01,
    Reverb = 0x02,
    Echo = 0x03
}

public enum OutputDevice: String, Codable, CaseIterable {
    case Headphones,
    BroadcastMix,
    LineOut,
    ChatMic,
    Sampler
}
extension OutputDevice {
    public var icon: String {
        switch self {
        case .Headphones:
            return "headphones"
        case .BroadcastMix:
            return "waveform"
        case .LineOut:
            return "chevron.right.to.line"
        case .ChatMic:
            return "message.and.waveform"
        case .Sampler:
            return "speaker.wave.2.bubble.left"
        }
    }
}

public enum InputDevice: String, Codable, CaseIterable {
    case Microphone,
    Chat,
    Music,
    Game,
    Console,
    LineIn,
    System,
    Samples
}
extension InputDevice {
    public var icon: String {
        switch self {
        case .Microphone:
            return "mic"
        case .Chat:
            return "speaker.wave.2.bubble.left"
        case .Music:
            return "music.note"
        case .Game:
            return "gamecontroller"
        case .Console:
            return "rectangle.on.rectangle"
        case .LineIn:
            return "chevron.backward.to.line"
        case .System:
            return "menubar.dock.rectangle"
        case .Samples:
            return "speaker.wave.2.bubble.left"
        }
    }
    
    public var index: Int {
        switch self {
        case .Microphone: 0
        case .Chat: 1
        case .Music: 2
        case .Game: 3
        case .Console: 4
        case .LineIn: 5
        case .System: 6
        case .Samples: 7
        }
    }
}


public enum EffectKey: Double, Codable {
    case DisableMic = 0x0158,
    BleepLevel = 0x0073,
    GateMode = 0x0010,
    GateThreshold = 0x0011,
    GateEnabled = 0x0014,
    GateAttenuation = 0x0015,
    GateAttack = 0x0016,
    GateRelease = 0x0017,
    MicCompSelect = 0x014b,
    Equalizer31HzFrequency = 0x0126,
    Equalizer31HzGain = 0x0127,
    Equalizer63HzFrequency = 0x00f8,
    Equalizer63HzGain = 0x00f9,
    Equalizer125HzFrequency = 0x0113,
    Equalizer125HzGain = 0x0114,
    Equalizer250HzFrequency = 0x0129,
    Equalizer250HzGain = 0x012a,
    Equalizer500HzFrequency = 0x0116,
    Equalizer500HzGain = 0x0117,
    Equalizer1KHzFrequency = 0x011d,
    Equalizer1KHzGain = 0x011e,
    Equalizer2KHzFrequency = 0x012c,
    Equalizer2KHzGain = 0x012d,
    Equalizer4KHzFrequency = 0x0120,
    Equalizer4KHzGain = 0x0121,
    Equalizer8KHzFrequency = 0x0109,
    Equalizer8KHzGain = 0x010a,
    Equalizer16KHzFrequency = 0x012f,
    Equalizer16KHzGain = 0x0130,
    CompressorThreshold = 0x013d,
    CompressorRatio = 0x013c,
    CompressorAttack = 0x013e,
    CompressorRelease = 0x013f,
    CompressorMakeUpGain = 0x0140,
    DeEsser = 0x000b,
    ReverbAmount = 0x0076,
    ReverbDecay = 0x002f,
    ReverbEarlyLevel = 0x0037,
    ReverbTailLevel = 0x0039, // Always sent as 0.
    ReverbPredelay = 0x0030,
    ReverbLowColor = 0x0032,
    ReverbHighColor = 0x0033,
    ReverbHighFactor = 0x0034,
    ReverbDiffuse = 0x0031,
    ReverbModSpeed = 0x0035,
    ReverbModDepth = 0x0036,
    ReverbType = 0x002e,
    EchoAmount = 0x0075,
    EchoFeedback = 0x0028,
    EchoTempo = 0x001f,
    EchoDelayL = 0x0022,
    EchoDelayR = 0x0023,
    EchoFeedbackL = 0x0024,
    EchoFeedbackR = 0x0025,
    EchoXFBLtoR = 0x0026,
    EchoXFBRtoL = 0x0027,
    EchoSource = 0x001e,
    EchoDivL = 0x0020,
    EchoDivR = 0x0021,
    EchoFilterStyle = 0x002a,
    PitchAmount = 0x005d,
    PitchCharacter = 0x0167,
    PitchThreshold = 0x0159,
    GenderAmount = 0x0060,
    MegaphoneAmount = 0x003c,
    MegaphonePostGain = 0x0040,
    MegaphoneStyle = 0x003a,
    MegaphoneHP = 0x003d,
    MegaphoneLP = 0x003e,
    MegaphonePreGain = 0x003f,
    MegaphoneDistType = 0x0041,
    MegaphonePresenceGain = 0x0042,
    MegaphonePresenceFC = 0x0043,
    MegaphonePresenceBW = 0x0044,
    MegaphoneBeatboxEnable = 0x0045,
    MegaphoneFilterControl = 0x0046,
    MegaphoneFilter = 0x0047,
    MegaphoneDrivePotGainCompMid = 0x0048,
    MegaphoneDrivePotGainCompMax = 0x0049,
    RobotLowGain = 0x0134,
    RobotLowFreq = 0x0133,
    RobotLowWidth = 0x0135,
    RobotMidGain = 0x013a,
    RobotMidFreq = 0x0139,
    RobotMidWidth = 0x013b,
    RobotHiGain = 0x0137,
    RobotHiFreq = 0x0136,
    RobotHiWidth = 0x0138,
    RobotWaveform = 0x0147,
    RobotPulseWidth = 0x0146,
    RobotThreshold = 0x0157,
    RobotDryMix = 0x014d,
    RobotStyle = 0x0000,
    HardTuneKeySource = 0x0059, // Always sent as 0.
    HardTuneAmount = 0x005a,
    HardTuneRate = 0x005c,
    HardTuneWindow = 0x005b,
    HardTuneScale = 0x005e,
    HardTunePitchAmount = 0x005f,

    RobotEnabled = 0x014e,
    MegaphoneEnabled = 0x00d7,
    HardTuneEnabled = 0x00d8,

    Encoder1Enabled = 0x00d5,
    Encoder2Enabled = 0x00d6,
    Encoder3Enabled = 0x0150,
    Encoder4Enabled = 0x0151
}

// Eq and Derivative allow for these to be added to a HashSet (the values make EnumSet unusable)

public enum MicrophoneParamKey: Double, Codable {
    case MicType = 0x000,
    DynamicGain = 0x001,
    CondenserGain = 0x002,
    JackGain = 0x003,
    GateThreshold = 0x30200,
    GateAttack = 0x30400,
    GateRelease = 0x30600,
    GateAttenuation = 0x30900,
    CompressorThreshold = 0x60200,
    CompressorRatio = 0x60300,
    CompressorAttack = 0x60400,
    CompressorRelease = 0x60600,
    CompressorMakeUpGain = 0x60700,
    BleepLevel = 0x70100,

    /*
     These are the values for the GoXLR mini, it seems there's a difference in how the two
     are setup, The Mini does EQ via mic parameters, where as the full does it via effects.
    */
    Equalizer90HzFrequency = 0x40000,
    Equalizer90HzGain = 0x40001,
    Equalizer250HzFrequency = 0x40003,
    Equalizer250HzGain = 0x40004,
    Equalizer500HzFrequency = 0x40006,
    Equalizer500HzGain = 0x40007,
    Equalizer1KHzFrequency = 0x50000,
    Equalizer1KHzGain = 0x50001,
    Equalizer3KHzFrequency = 0x50003,
    Equalizer3KHzGain = 0x50004,
    Equalizer8KHzFrequency = 0x50006,
    Equalizer8KHzGain = 0x50007
}


public enum FaderDisplayStyle: String, Codable, Hashable {
    case TwoColour,
    Gradient,
    Meter,
    GradientMeter
}


public enum GoXlrButton: String, Codable, Hashable {
    // These are all the buttons from the GoXLR Mini.
    case Fader1Mute,
    Fader2Mute,
    Fader3Mute,
    Fader4Mute,
    Bleep,
    Cough,

    // The rest are GoXLR Full Buttons. On the mini, they will simply be ignored.
    EffectSelect1,
    EffectSelect2,
    EffectSelect3,
    EffectSelect4,
    EffectSelect5,
    EffectSelect6,

    // FX Button labelled as 'fxClear' in config?
    EffectFx,
    EffectMegaphone,
    EffectRobot,
    EffectHardTune,

    SamplerSelectA,
    SamplerSelectB,
    SamplerSelectC,

    SamplerTopLeft,
    SamplerTopRight,
    SamplerBottomLeft,
    SamplerBottomRight,
    SamplerClear
}


public enum SimpleColourTargets: String, Codable, Hashable {
    case Global,
    Accent,
    Scribble1,
    Scribble2,
    Scribble3,
    Scribble4
}


public enum SamplerColourTargets: String, Codable, Hashable {
    case SamplerSelectA,
    SamplerSelectB,
    SamplerSelectC
}


public enum EncoderColourTargets: String, Codable, Hashable {
    case Reverb,
    Pitch,
    Echo,
    Gender
}

public enum ButtonColourGroups: String, Codable, Hashable {
    case FaderMute,
    EffectSelector,
    SampleBankSelector,
    SamplerButtons
}


public enum ButtonColourOffStyle: String, Codable, Hashable  {
    case Dimmed,
    Colour2,
    DimmedColour2
}

// MuteChat

public enum MuteFunction: String, Codable, Hashable {
    case All,
    ToStream,
    ToVoiceChat,
    ToPhones,
    ToLineOut
}


public enum MicrophoneType: String, Codable, Hashable {
    case Dynamic,
    Condenser,
    Jack
}

extension MicrophoneType {
    public func get_gain_param() -> MicrophoneParamKey {
        switch self {
        case .Dynamic:
            return MicrophoneParamKey.DynamicGain
        case .Condenser:
            return MicrophoneParamKey.CondenserGain
        case .Jack:
            return MicrophoneParamKey.JackGain
        }
    }

    public var has_phantom_power: Bool {
        return self == .Condenser
    }
}

public enum EffectBankPresets: String, Codable, CaseIterable {
    case Preset1,
    Preset2,
    Preset3,
    Preset4,
    Preset5,
    Preset6
}

public enum SampleBank: String, Codable, Hashable {
    case A,
    B,
    C
}

public enum MiniEqFrequencies: String, Codable, Hashable {
    case Equalizer90Hz,
    Equalizer250Hz,
    Equalizer500Hz,
    Equalizer1KHz,
    Equalizer3KHz,
    Equalizer8KHz
}

public enum EqFrequencies: String, Codable, Hashable {
    case Equalizer31Hz,
    Equalizer63Hz,
    Equalizer125Hz,
    Equalizer250Hz,
    Equalizer500Hz,
    Equalizer1KHz,
    Equalizer2KHz,
    Equalizer4KHz,
    Equalizer8KHz,
    Equalizer16KHz
}

/*
Ok, before we get started with these next couple of enums, lemme explain how the GoXLR works for
certain values. While the UI under windows appears to display a range, these values are all mapped
to fixed values in an array (eg. goxlr_shared.h line 415), and the index of that value is sent to
the GoXLR. This will most often occur for values that aren't linear, the ratio starts at increments
of 0.1, and by the end it's hitting increments of 16 and 32.

These enums are essentially the same maps, and use 'as usize' and strum::iter().nth to convert.
 */

public enum CompressorRatio: Int, Codable, CaseIterable {
    case Ratio1_0,
    Ratio1_1,
    Ratio1_2,
    Ratio1_4,
    Ratio1_6,
    Ratio1_8,
    Ratio2_0,
    Ratio2_5,
    Ratio3_2,
    Ratio4_0,
    Ratio5_6,
    Ratio8_0,
    Ratio16_0,
    Ratio32_0,
    Ratio64_0
}

public enum GateTimes: Int, Codable {
    case Gate10ms,
    Gate20ms,
    Gate30ms,
    Gate40ms,
    Gate50ms,
    Gate60ms,
    Gate70ms,
    Gate80ms,
    Gate90ms,
    Gate100ms,
    Gate110ms,
    Gate120ms,
    Gate130ms,
    Gate140ms,
    Gate150ms,
    Gate160ms,
    Gate170ms,
    Gate180ms,
    Gate190ms,
    Gate200ms,
    Gate250ms,
    Gate300ms,
    Gate350ms,
    Gate400ms,
    Gate450ms,
    Gate500ms,
    Gate550ms,
    Gate600ms,
    Gate650ms,
    Gate700ms,
    Gate750ms,
    Gate800ms,
    Gate850ms,
    Gate900ms,
    Gate950ms,
    Gate1000ms,
    Gate1100ms,
    Gate1200ms,
    Gate1300ms,
    Gate1400ms,
    Gate1500ms,
    Gate1600ms,
    Gate1700ms,
    Gate1800ms,
    Gate1900ms,
    Gate2000ms
}

public enum CompressorAttackTime: Int, Codable {
    // Note: 0ms is technically 0.001ms
    case Comp0ms,
    Comp2ms,
    Comp3ms,
    Comp4ms,
    Comp5ms,
    Comp6ms,
    Comp7ms,
    Comp8ms,
    Comp9ms,
    Comp10ms,
    Comp12ms,
    Comp14ms,
    Comp16ms,
    Comp18ms,
    Comp20ms,
    Comp23ms,
    Comp26ms,
    Comp30ms,
    Comp35ms,
    Comp40ms
}

public enum CompressorReleaseTime: Int, Codable {
    // Note: 0 is technically 15 :)
    case Comp0ms,
    Comp15ms,
    Comp25ms,
    Comp35ms,
    Comp45ms,
    Comp55ms,
    Comp65ms,
    Comp75ms,
    Comp85ms,
    Comp100ms,
    Comp115ms,
    Comp140ms,
    Comp170ms,
    Comp230ms,
    Comp340ms,
    Comp680ms,
    Comp1000ms,
    Comp1500ms,
    Comp2000ms,
    Comp3000ms
}

public enum ReverbStyle: String, Codable, CaseIterable {
    case Library,
    DarkBloom,
    MusicClub,
    RealPlate,
    Chapel,
    HockeyArena
}

public enum EchoStyle: String, Codable, CaseIterable {
    case Quarter,
    Eighth,
    Triplet,
    PingPong,
    ClassicSlap,
    MultiTap
}

public enum PitchStyle: String, Codable, CaseIterable {
    case Narrow,
    Wide
}

public enum GenderStyle: String, Codable, CaseIterable {
    case Narrow,
    Medium,
    Wide
}

public enum MegaphoneStyle: String, Codable, CaseIterable {
    case Megaphone,
    Radio,
    OnThePhone,
    Overdrive,
    BuzzCutt,
    Tweed
}


public enum RobotStyle: String, Codable, CaseIterable {
    case Robot1,
    Robot2,
    Robot3
}


public enum RobotRange: String, Codable, Hashable {
    case Low,
    Medium,
    High
}


public enum HardTuneStyle: String, Codable, CaseIterable {
    case Natural,
    Medium,
    Hard
}


public enum HardTuneSource: String, Codable, Hashable {
    case All,
    Music,
    Game,
    LineIn,
    System
}

public enum SampleButtons: String, Codable, Hashable {
    case TopLeft,
    TopRight,
    BottomLeft,
    BottomRight
}


public enum SamplePlaybackMode: String, Codable, Hashable {
    case PlayNext,
    PlayStop,
    PlayFade,
    StopOnRelease,
    FadeOnRelease,
    Loop
}


public enum SamplePlayOrder: String, Codable, Hashable {
    case Sequential,
    Random
}


public enum DisplayMode: String, Codable, Hashable {
    case Simple,
    Advanced
}


public enum DisplayModeComponents: String, Codable, Hashable {
    case NoiseGate,
    Equaliser,
    Compressor,
    EqFineTune
}


public enum MuteState: String, Codable, Hashable {
    case Unmuted,
    MutedToX,
    MutedToAll
}

public enum SubmixAssignation: String, Codable, Hashable {
    case A
    case B
}

public enum PathTypes: String, Codable, Hashable {
    case Profiles
    case MicProfiles
    case Presets
    case Samples
    case Icons
    case Logs
}
