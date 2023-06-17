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
        
    } else if path.contains(["files", "profiles"]) {
        status.files.profiles = patch(value: status.files.profiles, add: value.stringValue, at: Int(key))
        
    } else if path.contains(["files", "presets"]) {
        status.files.presets = patch(value: status.files.presets, add: value.stringValue, at: Int(key))
        
    } else if path.contains(["mixers"]) {
        if path.contains("sampler") {
            if path.contains("banks") {
                if path.contains("A") {
                    if path.contains("TopLeft") {
                        print(status.mixers[path[1]]!.sampler!.banks.A.TopLeft.samples)
                        status.mixers[path[1]]!.sampler!.banks.A.TopLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.A.TopLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        print(status.mixers[path[1]]!.sampler!.banks.A.TopLeft.samples)
                        
                    } else if path.contains("TopRight") {
                        status.mixers[path[1]]!.sampler!.banks.A.TopRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.A.TopRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomLeft") {
                        status.mixers[path[1]]!.sampler!.banks.A.BottomLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.A.BottomLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomRight") {
                        status.mixers[path[1]]!.sampler!.banks.A.BottomRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.A.BottomRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                    }
                } else if path.contains("B") {
                    if path.contains("TopLeft") {
                        status.mixers[path[1]]!.sampler!.banks.B.TopLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.B.TopLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("TopRight") {
                        status.mixers[path[1]]!.sampler!.banks.B.TopRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.B.TopRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomLeft") {
                        status.mixers[path[1]]!.sampler!.banks.B.BottomLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.B.BottomLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomRight") {
                        status.mixers[path[1]]!.sampler!.banks.B.BottomRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.B.BottomRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                    }
                } else if path.contains("C") {
                    if path.contains("TopLeft") {
                        status.mixers[path[1]]!.sampler!.banks.C.TopLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.C.TopLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("TopRight") {
                        status.mixers[path[1]]!.sampler!.banks.C.TopRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.C.TopRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomLeft") {
                        status.mixers[path[1]]!.sampler!.banks.C.BottomLeft.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.C.BottomLeft.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                        
                    } else if path.contains("BottomRight") {
                        status.mixers[path[1]]!.sampler!.banks.C.BottomRight.samples = patch(value: status.mixers[path[1]]!.sampler!.banks.C.BottomRight.samples, add: try! JSONDecoder().decode(Sample.self, from: value.rawData()), at: Int(key))
                    }
                }
            }
            
        } else {
            status.mixers[key] = try! JSONDecoder().decode(Mixer.self, from: try value.rawData())
            if GoXlr.shared.device == "" {
                GoXlr.shared.device = key
            }
        }
        
    } else {
        if GoXlr.shared.logLevel == .info || GoXlr.shared.logLevel == .debug {
            Logger().info("Add patch path \(path.debugDescription) isn't implemented. Please add its requirements within the module.")
        }
        
    }
}
