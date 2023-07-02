//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation
import SwiftyJSON
import SwiftUI

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
    @Published public var profileName: String {
        didSet {
            guard profileName != oldValue else { return }
            GoXlr.shared.command(.LoadProfile(profileName, true))
        }
    }
    @Published public var micProfileName: String {
        didSet {
            guard micProfileName != oldValue else { return }
            GoXlr.shared.command(.LoadMicProfile(micProfileName, true))
        }
    }

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
        effects = try values.decodeIfPresent(Effects.self, forKey: .effects)
        sampler = try values.decodeIfPresent(Sampler.self, forKey: .sampler)
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
    @Published public var isToggle: Bool { didSet { GoXlr.shared.command(.SetCoughIsHold(!isToggle)) } }
    @Published public var muteType: MuteFunction { didSet { GoXlr.shared.command(.SetCoughMuteFunction(muteType)) } }
    @Published public var state: MuteState { didSet { GoXlr.shared.command(.SetCoughMuteState(state)) } }

    enum CodingKeys: String, CodingKey {
        case isToggle = "is_toggle"
        case muteType = "mute_type"
        case state
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isToggle = try values.decode(Bool.self, forKey: .isToggle)
        muteType = try values.decode(MuteFunction.self, forKey: .muteType)
        state = try values.decode(MuteState.self, forKey: .state)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isToggle, forKey: .isToggle)
        try container.encode(muteType, forKey: .muteType)
        try container.encode(state, forKey: .state)
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



// MARK: - S210401735CQKSampler
public class Sampler: Codable, ObservableObject {
    @Published public var activeBank: SampleBank
    @Published public var banks: Banks
    @Published public var clearActive: Bool
    @Published public var processingState: SamplerProcessingState
    @Published public var recordBuffer: Int { didSet { GoXlr.shared.command(.SetSamplerPreBufferDuration(recordBuffer)) } }

    enum CodingKeys: String, CodingKey {
        case banks
        case recordBuffer = "record_buffer"
        case activeBank = "active_bank"
        case clearActive = "clear_active"
        case processingState = "processing_state"
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        activeBank = try values.decode(SampleBank.self, forKey: .activeBank)
        banks = try values.decode(Banks.self, forKey: .banks)
        clearActive = try values.decode(Bool.self, forKey: .clearActive)
        processingState = try values.decode(SamplerProcessingState.self, forKey: .processingState)
        recordBuffer = try values.decode(Int.self, forKey: .recordBuffer)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(activeBank, forKey: .activeBank)
        try container.encode(banks, forKey: .banks)
        try container.encode(clearActive, forKey: .clearActive)
        try container.encode(processingState, forKey: .processingState)
        try container.encode(recordBuffer, forKey: .recordBuffer)
    }
}

// MARK: - processing state
public class SamplerProcessingState: Codable, ObservableObject {
    @Published public var lastError: String?
    @Published public var progress: Float?
    
    enum CodingKeys: String, CodingKey {
        case progress
        case lastError = "last_error"
    }
    
    public func clear() {
        GoXlr.shared.command(.ClearSampleProcessError)
    }

    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastError = try values.decodeIfPresent(String.self, forKey: .lastError)
        progress = try values.decodeIfPresent(Float.self, forKey: .progress)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lastError, forKey: .lastError)
        try container.encode(progress, forKey: .progress)
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
        let a = try values.decode(Bank.self, forKey: .A)
        a.assignSubValues(.A)
        A = a
        
        let b = try values.decode(Bank.self, forKey: .B)
        b.assignSubValues(.B)
        B = b
        
        let c = try values.decode(Bank.self, forKey: .C)
        c.assignSubValues(.C)
        C = c
        
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
    
    fileprivate var bank: SampleBank = .A
    
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
    
    fileprivate func assignSubValues(_ bank: SampleBank) {
        self.bank = bank
        self.BottomLeft.assignSubValues(bank, button: .BottomLeft)
        self.TopLeft.assignSubValues(bank, button: .TopLeft)
        self.TopRight.assignSubValues(bank, button: .TopRight)
        self.BottomRight.assignSubValues(bank, button: .BottomRight)
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
    @Published public var function: SamplePlaybackMode { didSet { GoXlr.shared.command(.SetSamplerFunction(bank, button, function)) } }
    @Published public var order: SamplePlayOrder { didSet { GoXlr.shared.command(.SetSamplerOrder(bank, button, order)) } }
    @Published public var samples: [Sample]
    @Published public var isPlaying: Bool

    fileprivate var bank: SampleBank = .A
    fileprivate var button: SampleButtons = .TopLeft
    
    enum CodingKeys: String, CodingKey {
        case function, order, samples
        case is_playing = "is_playing"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.function = try container.decode(SamplePlaybackMode.self, forKey: .function)
        self.order = try container.decode(SamplePlayOrder.self, forKey: .order)
        self.samples = try container.decode([Sample].self, forKey: .samples)
        self.isPlaying = try container.decode(Bool.self, forKey: .is_playing)
    }
    
    fileprivate func assignSubValues(_ bank: SampleBank, button: SampleButtons) {
        self.bank = bank
        self.button = button
        if !self.samples.isEmpty {
            for index in 0...self.samples.count {
                guard index < self.samples.count else { break }
                self.samples[index].bank = bank
                self.samples[index].button = button
                self.samples[index].index = index
            }
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.function, forKey: .function)
        try container.encode(self.order, forKey: .order)
        try container.encode(self.samples, forKey: .samples)
        try container.encode(self.isPlaying, forKey: .is_playing)
    }
}

// MARK: - Sample
public class Sample: Codable, ObservableObject, Equatable {
    
    public static func == (lhs: Sample, rhs: Sample) -> Bool {
        lhs.name == rhs.name && lhs.startPct == rhs.startPct && lhs.stopPct == rhs.stopPct
    }
    
    @Published public var name: String
    @Published public var startPct: Float
    @Published public var stopPct: Float

    fileprivate var bank: SampleBank = .A
    fileprivate var button: SampleButtons = .TopLeft
    
    public var index: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case startPct = "start_pct"
        case stopPct = "stop_pct"
    }
    
    public init(_ name: String) {
        self.name = name
        self.startPct = 0
        self.stopPct = 100
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.startPct = try container.decode(Float.self, forKey: .startPct)
        self.stopPct = try container.decode(Float.self, forKey: .stopPct)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.startPct, forKey: .startPct)
        try container.encode(self.stopPct, forKey: .stopPct)
    }
}

// MARK: - Settings
public class Settings: Codable, ObservableObject {
    @Published public var display: Display
    @Published public var muteHoldDuration: Int { didSet { GoXlr.shared.command(.SetMuteHoldDuration(muteHoldDuration)) } }
    @Published public var vcMuteAlsoMuteCM: Bool { didSet { GoXlr.shared.command(.SetVCMuteAlsoMuteCM(vcMuteAlsoMuteCM)) } }

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
