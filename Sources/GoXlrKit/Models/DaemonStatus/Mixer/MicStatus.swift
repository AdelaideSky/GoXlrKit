//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation
import Patchable

// MARK: - MicStatus
@Patchable
public final class MicStatus: Codable, ObservableObject {
    @Parameter({ .SetMicrophoneType($0) }) public var micType: MicrophoneType = .Condenser
    @child @Published public var micGains: MicGains
    @child @Published public var equaliser: Equaliser
    @child @Published public var equaliserMini: EqualiserMini
    @child @Published public var noiseGate: NoiseGate
    @child @Published public var compressor: Compressor

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
        micType = try values.decode(MicrophoneType.self, forKey: .micType)
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
@Patchable
public final class Compressor: Codable, ObservableObject {
    @Parameter({ .SetCompressorThreshold(Int($0)) }) public var threshold: Float = 0
    @Parameter({ .SetCompressorRatio(.init(rawValue: Int($0)) ?? .Ratio1_0) }) public var ratio: Float = 0
    @Parameter({ .SetCompressorAttack(.init(rawValue: Int($0)) ?? .Comp0ms) }) public var attack: Float = 0
    @Parameter({ .SetCompressorReleaseTime(.init(rawValue: Int($0)) ?? .Comp0ms) }) public var release: Float = 0
    @Parameter({ .SetCompressorMakeupGain(Int($0)) }) public var makeupGain: Float = 0

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
@Patchable
public final class Equaliser: Codable, ObservableObject {
    @Parameter({ oldValue, newValue in
        for (key, value) in newValue {
            if oldValue[key] != value {
                return .SetEqGain(.init(rawValue: key) ?? .Equalizer1KHz, Int(value))
            }
        }
        return nil
    })
    public var gain: [String: Float] = [:]
    
    @Parameter({ oldValue, newValue in
        for (key, value) in newValue {
            if oldValue[key] != value {
                return .SetEqFreq(.init(rawValue: key) ?? .Equalizer1KHz, value)
            }
        }
        return nil
    })
    public var frequency: [String: Float] = [:]
    
    enum CodingKeys: String, CodingKey {
        case gain, frequency
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gain = try values.decode([String: Float].self, forKey: .gain)
        frequency = try values.decode([String: Float].self, forKey: .frequency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gain, forKey: .gain)
        try container.encode(frequency, forKey: .frequency)
    }
}

// MARK: - EqualiserMini
//TODO: why is that different from full eq??
@Patchable
public class EqualiserMini: Codable, ObservableObject {
    @child @Published public var gain: Gain
    @child @Published public var frequency: Frequency
    
    enum CodingKeys: String, CodingKey {
        case gain, frequency
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gain = try values.decode(Gain.self, forKey: .gain)
        frequency = try values.decode(Frequency.self, forKey: .frequency)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gain, forKey: .gain)
        try container.encode(frequency, forKey: .frequency)
    }
}

@Patchable
public final class Gain: Codable, ObservableObject {
    @Parameter({ .SetEqMiniGain(.Equalizer250Hz, Int($0)) }) public var equalizer250Hz: Float = 0
    @Parameter({ .SetEqMiniGain(.Equalizer1KHz, Int($0)) }) public var equalizer1KHz: Float = 0
    @Parameter({ .SetEqMiniGain(.Equalizer500Hz, Int($0)) }) public var equalizer500Hz: Float = 0
    @Parameter({ .SetEqMiniGain(.Equalizer8KHz, Int($0)) }) public var equalizer8KHz: Float = 0
    @Parameter({ .SetEqMiniGain(.Equalizer90Hz, Int($0)) }) public var equalizer90Hz: Float = 0
    @Parameter({ .SetEqMiniGain(.Equalizer3KHz, Int($0)) }) public var equalizer3KHz: Float = 0

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

// MARK: - Frequency
@Patchable
public final class Frequency: Codable, ObservableObject {
    @Parameter({ .SetEqMiniFreq(.Equalizer250Hz, $0) }) public var equalizer250Hz: Float = 0
    @Parameter({ .SetEqMiniFreq(.Equalizer1KHz, $0) }) public var equalizer1KHz: Float = 0
    @Parameter({ .SetEqMiniFreq(.Equalizer500Hz, $0) }) public var equalizer500Hz: Float = 0
    @Parameter({ .SetEqMiniFreq(.Equalizer8KHz, $0) }) public var equalizer8KHz: Float = 0
    @Parameter({ .SetEqMiniFreq(.Equalizer90Hz, $0) }) public var equalizer90Hz: Float = 0
    @Parameter({ .SetEqMiniFreq(.Equalizer3KHz, $0) }) public var equalizer3KHz: Float = 0

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
@Patchable
public final class MicGains: Codable, ObservableObject {
    @Parameter({ .SetMicrophoneGain(.Dynamic, Int($0)) }) public var dynamic: Float = 0
    @Parameter({ .SetMicrophoneGain(.Condenser, Int($0)) }) public var condenser: Float = 0
    @Parameter({ .SetMicrophoneGain(.Jack, Int($0)) }) public var jack: Float = 0

    enum CodingKeys: String, CodingKey {
        case dynamic = "Dynamic"
        case condenser = "Condenser"
        case jack = "Jack"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dynamic = try values.decode(Float.self, forKey: .dynamic)
        condenser = try values.decode(Float.self, forKey: .condenser)
        jack = try values.decode(Float.self, forKey: .jack)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dynamic, forKey: .dynamic)
        try container.encode(condenser, forKey: .condenser)
        try container.encode(jack, forKey: .jack)
    }
}

// MARK: - NoiseGate
@Patchable
public final class NoiseGate: Codable, ObservableObject {
    @Parameter({ .SetGateThreshold(Int(min(0, max(-59, $0)))) }) public var threshold: Float = 0
    @Parameter({ .SetGateAttack(.init(rawValue: Int(min(44, max(0, $0)))) ?? .Gate10ms) }) public var attack: Float = 0
    @Parameter({ .SetGateRelease(.init(rawValue: Int(min(44, max(0, $0)))) ?? .Gate10ms) }) public var release: Float = 0
    @Parameter({ .SetGateActive($0) }) public var enabled: Bool = false
    @Parameter({ .SetGateAttenuation(Int(min(100, max(0, $0)))) }) public var attenuation: Float = 0
    
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
