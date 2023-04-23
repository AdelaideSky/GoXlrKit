//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 19/04/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import os

public func handleMixerPatch(mixer: inout Mixer, path: [String], value: JSON) {
    let key = path.last!
    
    if path.contains(["levels", "volumes"]) {
        mixer.levels.volumes = patch(value: mixer.levels.volumes as any Codable, key: key, newValue: value)!
        
    } else if path.contains(["fader_status"]) {
        
        if path.contains(["fader_status", "A"]) {
            mixer.faderStatus.a = patch(value: mixer.faderStatus.a as any Codable, key: key, newValue: value)!
            
        } else if path.contains(["fader_status", "B"]) {
            mixer.faderStatus.b = patch(value: mixer.faderStatus.b as any Codable, key: key, newValue: value)!
            
        } else if path.contains(["fader_status", "C"]) {
            mixer.faderStatus.c = patch(value: mixer.faderStatus.c as any Codable, key: key, newValue: value)!
            
        } else if path.contains(["fader_status", "D"]) {
            mixer.faderStatus.d = patch(value: mixer.faderStatus.d as any Codable, key: key, newValue: value)!
        }
        
    } else if path.contains(["mic_profile_name"]) {
        mixer.micProfileName = value.stringValue
        
    } else if path.contains(["profile_name"]) {
        mixer.profileName = value.stringValue
        
    } else if path.contains(["mic_status"]) {
        
        if path.contains(["mic_status", "noise_gate"]) {
            mixer.micStatus.noiseGate = patch(value: mixer.micStatus.noiseGate, key: key, newValue: value)!
            
        } else if path.contains(["mic_status", "equaliser"]) {
            mixer.micStatus.equaliser = patch(value: mixer.micStatus.equaliser, key: key, newValue: value)!
            
        } else if path.contains(["mic_status", "compressor"]) {
            mixer.micStatus.compressor = patch(value: mixer.micStatus.compressor, key: key, newValue: value)!
        }
        
    } else if path.contains(["effects"]) {
        
        if path.contains(["preset_names"]) {
            mixer.effects!.presetNames = patch(value: mixer.effects!.presetNames, key: key, newValue: value)!
            
        } else if path.contains(["active_preset"]) {
            mixer.effects!.activePreset = .init(rawValue: value.stringValue)!
            
        } else if path.contains(["is_enabled"]) {
            mixer.effects!.isEnabled = value.boolValue
            
        } else if path.contains(["current"]) {
            
            if path.contains(["reverb"]) {
                mixer.effects!.current.reverb = patch(value: mixer.effects!.current.reverb, key: key, newValue: value)!
                
            } else if path.contains(["echo"]) {
                mixer.effects!.current.echo = patch(value: mixer.effects!.current.echo, key: key, newValue: value)!
                
            } else if path.contains(["pitch"]) {
                mixer.effects!.current.pitch = patch(value: mixer.effects!.current.pitch, key: key, newValue: value)!
                
            } else if path.contains(["gender"]) {
                mixer.effects!.current.gender = patch(value: mixer.effects!.current.gender, key: key, newValue: value)!
                
            } else if path.contains(["megaphone"]) {
                mixer.effects!.current.megaphone = patch(value: mixer.effects!.current.megaphone, key: key, newValue: value)!
                
            } else if path.contains(["robot"]) {
                mixer.effects!.current.robot = patch(value: mixer.effects!.current.robot, key: key, newValue: value)!
                
            } else if path.contains(["hard_tune"]) {
                mixer.effects!.current.hardTune = patch(value: mixer.effects!.current.hardTune, key: key, newValue: value)!
            }
        }
        
    } else if path.contains(["sampler"]) {
        if path.contains(["record_buffer"]) {
            mixer.sampler = patch(value: mixer.sampler, key: key, newValue: value)
        }
        
    } else {
        Logger().log("Mixer path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
