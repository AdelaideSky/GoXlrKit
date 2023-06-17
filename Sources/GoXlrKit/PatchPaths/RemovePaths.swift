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
    
    if path.contains("files") {
        if path.contains("mic_profiles") {
            status.files.micProfiles = patch(value: status.files.micProfiles, removeAt: Int(key))
            
        } else if path.contains("profiles") {
            status.files.profiles = patch(value: status.files.profiles, removeAt: Int(key))
            
        } else if path.contains("presets") {
            status.files.presets = patch(value: status.files.presets, removeAt: Int(key))
            
        } else if path.contains("samples") {
            status.files.samples.removeValue(forKey: key)
            
        }
        
    } else if path.contains(["sampler"]) {
        if path.contains(["banks"]) {
            if path.contains(["A"]) {
                if path.contains(["TopLeft"]) {
                    removeSample(\.A.TopLeft, at: Int(key))
                    
                } else if path.contains(["TopRight"]) {
                    removeSample(\.A.TopRight, at: Int(key))
                    
                } else if path.contains(["BottomLeft"]) {
                    removeSample(\.A.BottomLeft, at: Int(key))
                    
                } else if path.contains(["BottomRight"]) {
                    removeSample(\.A.BottomRight, at: Int(key))
                    
                }
            } else if path.contains(["B"]) {
                if path.contains(["TopLeft"]) {
                    removeSample(\.B.TopLeft, at: Int(key))
                    
                } else if path.contains(["TopRight"]) {
                    removeSample(\.B.TopRight, at: Int(key))
                    
                } else if path.contains(["BottomLeft"]) {
                    removeSample(\.B.BottomLeft, at: Int(key))
                    
                } else if path.contains(["BottomRight"]) {
                    removeSample(\.B.BottomRight, at: Int(key))
                    
                }
            } else if path.contains(["C"]) {
                if path.contains(["TopLeft"]) {
                    removeSample(\.C.TopLeft, at: Int(key))
                    
                } else if path.contains(["TopRight"]) {
                    removeSample(\.C.TopRight, at: Int(key))
                    
                } else if path.contains(["BottomLeft"]) {
                    removeSample(\.C.BottomLeft, at: Int(key))
                    
                } else if path.contains(["BottomRight"]) {
                    removeSample(\.C.BottomRight, at: Int(key))
                    
                }
            }
        }

        
    } else {
        if GoXlr.shared.logLevel == .info || GoXlr.shared.logLevel == .debug {
            Logger().info("Remove patch path \(path.debugDescription) isn't implemented. Please add its requirements within the module.")
        }
    }
}

fileprivate func removeSample(_ button: WritableKeyPath<Banks, SamplerButton>, at: Int?) {
    if at == nil {
        Logger().error("Error removing sample: no offset. Please check the implementation of this path.")
    }
    var answer = GoXlr.shared.mixer!.sampler!.banks[keyPath: button]
    answer.samples.remove(at: at!)
    GoXlr.shared.mixer!.sampler!.banks[keyPath: button] = answer
}
