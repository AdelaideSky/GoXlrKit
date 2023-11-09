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
public final class MicStatus: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<MicStatus>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.micType:
            return .SetMicrophoneType(newValue as! MicrophoneType)
        default: return nil
        }
    }
    
    @Published public var micType: MicrophoneType
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
public final class Compressor: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Compressor>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.threshold:
            return .SetCompressorThreshold(Int(newValue as! Float))
        case \.ratio:
            return .SetCompressorRatio(.init(rawValue: Int(newValue as! Float))!)
        case \.attack:
            return .SetCompressorAttack(.init(rawValue: Int(newValue as! Float))!)
        case \.release:
            return .SetCompressorReleaseTime(.init(rawValue: Int(newValue as! Float))!)
        case \.makeupGain:
            return .SetCompressorMakeupGain(Int(newValue as! Float))
        default: return nil
        }
    }
    
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
@Patchable
public final class Equaliser: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Equaliser>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.gain:
            for (key, value) in newValue as! [String: Float] {
                if gain[key] != value {
                    return .SetEqGain(.init(rawValue: key)!, Int(value))
                }
            }
        case \.frequency:
            for (key, value) in newValue as! [String: Float] {
                if gain[key] != value {
                    return .SetEqGain(.init(rawValue: key)!, Int(value))
                }
            }
        default: return nil
        }
        return nil
    }
    
    @Published public var gain: [String: Float]
    @Published public var frequency: [String: Float]
    
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
public final class Gain: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Gain>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.equalizer250Hz:
            return .SetEqMiniGain(.Equalizer250Hz, Int(newValue as! Float))
        case \.equalizer1KHz:
            return .SetEqMiniGain(.Equalizer1KHz, Int(newValue as! Float))
        case \.equalizer500Hz:
            return .SetEqMiniGain(.Equalizer500Hz, Int(newValue as! Float))
        case \.equalizer8KHz:
            return .SetEqMiniGain(.Equalizer8KHz, Int(newValue as! Float))
        case \.equalizer90Hz:
            return .SetEqMiniGain(.Equalizer90Hz, Int(newValue as! Float))
        case \.equalizer3KHz:
            return .SetEqMiniGain(.Equalizer3KHz, Int(newValue as! Float))
        default: return nil
        }
    }
    
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

// MARK: - Frequency
@Patchable
public final class Frequency: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<Frequency>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.equalizer250Hz:
            return .SetEqMiniFreq(.Equalizer250Hz, newValue as! Float)
        case \.equalizer1KHz:
            return .SetEqMiniFreq(.Equalizer1KHz, newValue as! Float)
        case \.equalizer500Hz:
            return .SetEqMiniFreq(.Equalizer500Hz, newValue as! Float)
        case \.equalizer8KHz:
            return .SetEqMiniFreq(.Equalizer8KHz, newValue as! Float)
        case \.equalizer90Hz:
            return .SetEqMiniFreq(.Equalizer90Hz, newValue as! Float)
        case \.equalizer3KHz:
            return .SetEqMiniFreq(.Equalizer3KHz, newValue as! Float)
        default: return nil
        }
    }
    
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
@Patchable
public final class MicGains: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<MicGains>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.dynamic:
            return .SetMicrophoneGain(.Dynamic, Int(newValue as! Float))
        case \.condenser:
            return .SetMicrophoneGain(.Condenser, Int(newValue as! Float))
        case \.jack:
            return .SetMicrophoneGain(.Jack, Int(newValue as! Float))
        default: return nil
        }
    }
    
    
    @Published public var dynamic: Float
    @Published public var condenser: Float
    @Published public var jack: Float

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
public final class NoiseGate: Codable, ObservableObject, GoXLRCommandConvertible {
    public func command(for value: PartialKeyPath<NoiseGate>, newValue: Any) -> GoXLRCommand? {
        switch value {
        case \.threshold:
            return .SetGateThreshold(Int(min(0, max(-59, newValue as! Float))))
        case \.attack:
            return .SetGateAttack(.init(rawValue: Int(min(44, max(0, newValue as! Float))))!)
        case \.release:
            return .SetGateRelease(.init(rawValue: Int(min(44, max(0, newValue as! Float))))!)
        case \.enabled:
            return .SetGateActive(newValue as! Bool)
        case \.attenuation:
            return .SetGateAttenuation(Int(min(100, max(0, newValue as! Float))))
        default: return nil
        }
    }
    
    
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
