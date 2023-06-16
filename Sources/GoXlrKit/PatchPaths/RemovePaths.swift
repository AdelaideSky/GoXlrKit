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

public func handleRemovePatch(status: inout StatusClass, path: [String], value: JSON) {
    let key = path.last!
    
    if path.contains(["files", "mic_profiles"]) {
        status.files.micProfiles = patch(value: status.files.micProfiles, removeAt: Int(key))
        
    } else if path.contains(["files", "profiles"]) {
        status.files.profiles = patch(value: status.files.profiles, removeAt: Int(key))
        
    } else if path.contains(["files", "presets"]) {
        status.files.presets = patch(value: status.files.presets, removeAt: Int(key))
        
    } else {
        if GoXlr.shared.logLevel == .info || GoXlr.shared.logLevel == .debug {
            Logger().info("Remove patch path \(path.debugDescription) isn't implemented. Please add its requirements within the module.")
        }
    }
}
