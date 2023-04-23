//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 20/04/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import os

public func handleStatusPatch(status: inout StatusClass, path: [String], value: JSON) {
    let key = path.last!
    
    if path.contains(["files", "mic_profiles"]) {
        status.files.micProfiles = patch(value: status.files.micProfiles, key: Int(key)!, newValue: value)!
        
    } else if path.contains(["files", "profiles"]) {
        status.files.profiles = patch(value: status.files.profiles, key: Int(key)!, newValue: value)!
        
    } else if path.contains(["files", "presets"]) {
        status.files.presets = patch(value: status.files.presets, key: Int(key)!, newValue: value)!
        
    } else if path.contains(["config"]) {
        status.config = patch(value: status.config, key: key, newValue: value)!
        
    } else {
        Logger().log("Status path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
