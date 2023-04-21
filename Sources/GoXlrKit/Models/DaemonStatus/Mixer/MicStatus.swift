//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation

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
    @Published public var gain: [EqFrequencies: Float]{
        didSet {
            for (key, value) in gain {
                if oldValue[key] != value {
                    GoXlr.shared.command(.SetEqGain(key, Int(value)))
                }
            }
        }
    }
    @Published public var frequency: [EqFrequencies: Float] {
        didSet {
            for (key, value) in frequency {
                if oldValue[key] != value {
                    GoXlr.shared.command(.SetEqFreq(key, Float(value)))
                }
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case gain, frequency
    }
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gain = try values.decode([EqFrequencies: Float].self, forKey: .gain)
        frequency = try values.decode([EqFrequencies: Float].self, forKey: .frequency)
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
    @Published public var threshold: Float { didSet { GoXlr.shared.command(.SetGateThreshold(Int(min(0, max(-59, threshold))))) } }
    @Published public var attack: Float { didSet { GoXlr.shared.command(.SetGateAttack(.init(rawValue: Int(min(44, max(0, attenuation))))!)) } }
    @Published public var release: Float { didSet { GoXlr.shared.command(.SetGateRelease(.init(rawValue: Int(min(44, max(0, attenuation))))!)) } }
    @Published public var enabled: Bool { didSet { GoXlr.shared.command(.SetGateActive(enabled)) } }
    @Published public var attenuation: Float { didSet { GoXlr.shared.command(.SetGateAttenuation(Int(min(100, max(0, attenuation))))) } }
    
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
