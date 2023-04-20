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

fileprivate func patch<type: Codable>(value: any Codable, key: String, newValue: JSON) -> type? {
    do {
        var json = try JSON(data: try JSONEncoder().encode(value))
        json[key] = newValue
        return try JSONDecoder().decode(type.self, from: try json.rawData())
    } catch let error {
        Logger().error("Error patching \(key): \(error) Please check the implementation of this path.")
        return nil
    }
}

fileprivate func patch<type: Codable>(value: any Codable, key: Int, newValue: JSON) -> type? {
    do {
        var json = try JSON(data: try JSONEncoder().encode(value))
        json[key] = newValue
        return try JSONDecoder().decode(type.self, from: try json.rawData())
    } catch let error {
        Logger().error("Error patching \(key): \(error) Please check the implementation of this path.")
        return nil
    }
}

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
        
    } else {
        Logger().log("Mixer path \(path) isn't implemented. Please add its requirements within the module.")
    }
}

public func handleStatusPatch(status: inout StatusClass, path: [String], value: JSON) {
    let key = path.last!
    
    if path.contains(["files", "mic_profiles"]) {
        status.files.micProfiles = patch(value: status.files.micProfiles, key: Int(key)!, newValue: value)!
    } else {
        Logger().log("Status path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
