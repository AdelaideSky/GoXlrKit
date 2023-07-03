//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 20/01/2023.
//

import Foundation
import SwiftUI

/**
 GoXlr command type, with corresponding parameters.
 */
public enum GoXLRCommand: Codable, Hashable {
    case SetFader(FaderName, ChannelName)
    case SetFaderMuteFunction(FaderName, MuteFunction)

    case SetVolume(ChannelName, Int)
    case SetMicrophoneType(MicrophoneType)
    case SetMicrophoneGain(MicrophoneType, Int)
    case SetRouter(InputDevice, OutputDevice, Bool)

    // Cough Button
    case SetCoughMuteFunction(MuteFunction)
    case SetCoughIsHold(Bool)

    // Bleep Button
    case SetSwearButtonVolume(Int)

    // EQ Settings
    case SetEqMiniGain(MiniEqFrequencies, Int)
    case SetEqMiniFreq(MiniEqFrequencies, Float)
    case SetEqGain(EqFrequencies, Int)
    case SetEqFreq(EqFrequencies, Float)

    // Gate Settings
    case SetGateThreshold(Int)
    case SetGateAttenuation(Int)
    case SetGateAttack(GateTimes)
    case SetGateRelease(GateTimes)
    case SetGateActive(Bool)

    // Compressor..
    case SetCompressorThreshold(Int)
    case SetCompressorRatio(CompressorRatio)
    case SetCompressorAttack(CompressorAttackTime)
    case SetCompressorReleaseTime(CompressorReleaseTime)
    case SetCompressorMakeupGain(Int)

    // Used to switch between display modes..
    case SetElementDisplayMode(DisplayModeComponents, DisplayMode)

    // DeEss
    case SetDeeser(Int)

    // Colour Related Settings..
    case SetFaderDisplayStyle(FaderName, FaderDisplayStyle)
    case SetFaderColours(FaderName, Color, Color)
    case SetAllFaderColours(Color, Color)
    case SetAllFaderDisplayStyle(FaderDisplayStyle)

    case SetButtonColours(GoXlrButton, Color, Color?)
    case SetButtonOffStyle(GoXlrButton, ButtonColourOffStyle)
    case SetButtonGroupColours(ButtonColourGroups, Color, Color?)
    case SetButtonGroupOffStyle(ButtonColourGroups, ButtonColourOffStyle)

    case SetSimpleColour(SimpleColourTargets, Color)
    case SetEncoderColour(EncoderColourTargets, Color, Color, Color)
    case SetSampleColour(SamplerColourTargets, Color, Color, Color)
    case SetSampleOffStyle(SamplerColourTargets, ButtonColourOffStyle)
    case SetGlobalColour(Color)

    // Effect Related Settings..
    case LoadEffectPreset(String)
    case RenameActivePreset(String)
    case SaveActivePreset

    // Reverb
    case SetReverbStyle(ReverbStyle)
    case SetReverbAmount(Int)
    case SetReverbDecay(Int)
    case SetReverbEarlyLevel(Int)
    case SetReverbTailLevel(Int)
    case SetReverbPreDelay(Int)
    case SetReverbLowColour(Int)
    case SetReverbHighColour(Int)
    case SetReverbHighFactor(Int)
    case SetReverbDiffuse(Int)
    case SetReverbModSpeed(Int)
    case SetReverbModDepth(Int)

    // Echo..
    case SetEchoStyle(EchoStyle)
    case SetEchoAmount(Int)
    case SetEchoFeedback(Int)
    case SetEchoTempo(Int)
    case SetEchoDelayLeft(Int)
    case SetEchoDelayRight(Int)
    case SetEchoFeedbackLeft(Int)
    case SetEchoFeedbackRight(Int)
    case SetEchoFeedbackXFBLtoR(Int)
    case SetEchoFeedbackXFBRtoL(Int)

    // Pitch
    case SetPitchStyle(PitchStyle)
    case SetPitchAmount(Int)
    case SetPitchCharacter(Int)

    // Gender
    case SetGenderStyle(GenderStyle)
    case SetGenderAmount(Int)

    // Megaphone
    case SetMegaphoneStyle(MegaphoneStyle)
    case SetMegaphoneAmount(Int)
    case SetMegaphonePostGain(Int)

    // Robot
    case SetRobotStyle(RobotStyle)
    case SetRobotGain(RobotRange, Int)
    case SetRobotFreq(RobotRange, Int)
    case SetRobotWidth(RobotRange, Int)
    case SetRobotWaveform(Int)
    case SetRobotPulseWidth(Int)
    case SetRobotThreshold(Int)
    case SetRobotDryMix(Int)

    // Hardtune
    case SetHardTuneStyle(HardTuneStyle)
    case SetHardTuneAmount(Int)
    case SetHardTuneRate(Int)
    case SetHardTuneWindow(Int)
    case SetHardTuneSource(HardTuneSource)

    // Sampler..
    case ClearSampleProcessError
    case SetSamplerFunction(SampleBank, SampleButtons, SamplePlaybackMode)
    case SetSamplerOrder(SampleBank, SampleButtons, SamplePlayOrder)
    case AddSample(SampleBank, SampleButtons, String)
    case SetSampleStartPercent(SampleBank, SampleButtons, Int, Float)
    case SetSampleStopPercent(SampleBank, SampleButtons, Int, Float)
    case RemoveSampleByIndex(SampleBank, SampleButtons, Int)
    case PlaySampleByIndex(SampleBank, SampleButtons, Int)
    case PlayNextSample(SampleBank, SampleButtons)
    case StopSamplePlayback(SampleBank, SampleButtons)
    case SetSamplerPreBufferDuration(Int)

    // Scribbles
    case SetScribbleIcon(FaderName, String)
    case SetScribbleText(FaderName, String)
    case SetScribbleNumber(FaderName, String)
    case SetScribbleInvert(FaderName, Bool)

    // Profile Handling..
    case NewProfile(String)
    case LoadProfile(String, Bool)
    case LoadProfileColours(String)
    case SaveProfile
    case SaveProfileAs(String)
    case DeleteProfile(String)

    case NewMicProfile(String)
    case LoadMicProfile(String, Bool)
    case SaveMicProfile
    case SaveMicProfileAs(String)
    case DeleteMicProfile(String)

    // General Settings
    case SetMuteHoldDuration(Int)
    case SetVCMuteAlsoMuteCM(Bool)

    // These control the current GoXLR 'State'..
    case SetActiveEffectPreset(EffectBankPresets)
    case SetActiveSamplerBank(SampleBank)
    case SetMegaphoneEnabled(Bool)
    case SetRobotEnabled(Bool)
    case SetHardTuneEnabled(Bool)
    case SetFXEnabled(Bool)
    case SetFaderMuteState(FaderName, MuteState)
    case SetCoughMuteState(MuteState)
    
    // Submix Commands
    case SetSubMixEnabled(Bool)
    case SetSubMixVolume(ChannelName, Int)
    case SetSubMixLinked(ChannelName, Bool)
    case SetSubMixOutputMix(OutputDevice, SubmixAssignation)
    case SetShutdownCommands([GoXLRCommand])
}

extension GoXLRCommand {
    var commandName: String {
        switch self {
        case .SaveActivePreset:
            return "SaveActivePreset"
        case .SaveProfile:
            return "SaveProfile"
        case .SaveMicProfile:
            return "SaveMicProfile"
        case .ClearSampleProcessError:
            return "ClearSampleProcessError"
        default:
            return ""
        }
    }
}

/**
 Daemon command type, with corresponding parameters.
 */
public enum DaemonCommand: Codable {
    case Ping
    case OpenUi
    case GetStatus
    case StopDaemon
    case GetHttpState
    case OpenPath(PathTypes)
    case SetShowTrayIcon(Bool)
    case SetTTSEnabled(Bool)
    case SetAutoStartEnabled(Bool)
    case SetLogLevel(Daemon.logLevels)
    case SetAllowNetworkAccess(Bool)
    case RecoverDefaults(PathTypes)
}

extension DaemonCommand {
    var commandName: String {
        switch self {
        case .StopDaemon:
            return "StopDaemon"
        default:
            return ""
        }
    }
}
