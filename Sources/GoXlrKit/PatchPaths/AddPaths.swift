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

public func handleAddPatch(status: inout StatusClass, path: [String], value: JSON) {
    let key = path.last!
    
    if path.contains(["files", "mic_profiles"]) {
        status.files.micProfiles = patch(value: status.files.micProfiles, add: value.stringValue, at: Int(key))
        
    } else if path.contains(["files", "presets"]) {
        status.files.presets = patch(value: status.files.presets, add: value.stringValue, at: Int(key))
        
    } else {
        Logger().log("Add patch path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
