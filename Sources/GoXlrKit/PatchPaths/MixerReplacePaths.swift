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
        
    } else if path.contains(["fader_status", "A"]) {
        mixer.faderStatus.a = patch(value: mixer.faderStatus.a as any Codable, key: key, newValue: value)!
        
    } else if path.contains(["fader_status", "B"]) {
        mixer.faderStatus.b = patch(value: mixer.faderStatus.b as any Codable, key: key, newValue: value)!
        
    } else if path.contains(["fader_status", "C"]) {
        mixer.faderStatus.c = patch(value: mixer.faderStatus.c as any Codable, key: key, newValue: value)!
        
    } else if path.contains(["fader_status", "D"]) {
        mixer.faderStatus.d = patch(value: mixer.faderStatus.d as any Codable, key: key, newValue: value)!
        
    } else if path.contains(["mic_profile_name"]) {
        mixer.micProfileName = value.stringValue
        
    } else if path.contains(["mic_status", "noise_gate"]) {
        mixer.micStatus.noiseGate = patch(value: mixer.micStatus.noiseGate, key: key, newValue: value)!
        
    } else {
        Logger().log("Mixer path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
