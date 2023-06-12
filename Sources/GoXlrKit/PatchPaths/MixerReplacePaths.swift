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
    
    if path.contains(["levels"]) {
        
        if path.contains(["volumes"]) {
            mixer.levels.volumes = patch(value: mixer.levels.volumes as any Codable, key: key, newValue: value)!
            
        } else {
            mixer.levels = patch(value: mixer.levels as any Codable, key: key, newValue: value)!
        }
        
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
            mixer.effects?.presetNames = patch(value: mixer.effects!.presetNames, key: key, newValue: value)!
            
        } else if path.contains(["active_preset"]) {
            mixer.effects?.activePreset = .init(rawValue: value.stringValue)!
            
        } else if path.contains(["is_enabled"]) {
            mixer.effects?.isEnabled = value.boolValue
            
        } else if path.contains(["current"]) {
//            print(mixer.effects)
            
            if path.contains(["reverb"]) {
                mixer.effects?.current.reverb = patch(value: mixer.effects!.current.reverb, key: key, newValue: value)!
                
            } else if path.contains(["echo"]) {
                mixer.effects?.current.echo = patch(value: mixer.effects!.current.echo, key: key, newValue: value)!
                
            } else if path.contains(["pitch"]) {
                mixer.effects?.current.pitch = patch(value: mixer.effects!.current.pitch, key: key, newValue: value)!
                
            } else if path.contains(["gender"]) {
                mixer.effects?.current.gender = patch(value: mixer.effects!.current.gender, key: key, newValue: value)!
                
            } else if path.contains(["megaphone"]) {
                mixer.effects?.current.megaphone = patch(value: mixer.effects!.current.megaphone, key: key, newValue: value)!
                
            } else if path.contains(["robot"]) {
                mixer.effects?.current.robot = patch(value: mixer.effects!.current.robot, key: key, newValue: value)!
                
            } else if path.contains(["hard_tune"]) {
                mixer.effects?.current.hardTune = patch(value: mixer.effects!.current.hardTune, key: key, newValue: value)!
            }
        }
    } else if path.contains(["router"]) {
        
        if path.contains(["Microphone"]) {
            mixer.router.microphone = patch(value: mixer.router.microphone, key: key, newValue: value)!
            
        } else if path.contains(["Chat"]) {
            mixer.router.chat = patch(value: mixer.router.chat, key: key, newValue: value)!
            
        } else if path.contains(["Music"]) {
            mixer.router.music = patch(value: mixer.router.music, key: key, newValue: value)!
            
        } else if path.contains(["Game"]) {
            mixer.router.game = patch(value: mixer.router.game, key: key, newValue: value)!
            
        } else if path.contains(["Console"]) {
            mixer.router.console = patch(value: mixer.router.console, key: key, newValue: value)!
            
        } else if path.contains(["LineIn"]) {
            mixer.router.lineIn = patch(value: mixer.router.lineIn, key: key, newValue: value)!
            
        } else if path.contains(["System"]) {
            mixer.router.system = patch(value: mixer.router.system, key: key, newValue: value)!
            
        } else if path.contains(["Samples"]) {
            mixer.router.samples = patch(value: mixer.router.samples, key: key, newValue: value)!
            
        }
        
    } else if path.contains(["sampler"]) {
        if path.contains(["record_buffer"]) {
            mixer.sampler = patch(value: mixer.sampler, key: key, newValue: value)
        }
        
    } else if path.contains(["lighting"]) {
        if path.contains(["faders"]) {
            if path.contains(["A"]) {
                if path.contains(["colours"]) {
                    mixer.lighting.faders.a.colours = patch(value: mixer.lighting.faders.a.colours, key: key, newValue: value)!
                    
                }
            } else if path.contains(["B"]) {
                if path.contains(["colours"]) {
                    mixer.lighting.faders.b.colours = patch(value: mixer.lighting.faders.b.colours, key: key, newValue: value)!
                    
                }
            } else if path.contains(["C"]) {
                if path.contains(["colours"]) {
                    mixer.lighting.faders.c.colours = patch(value: mixer.lighting.faders.c.colours, key: key, newValue: value)!
                    
                }
            } else if path.contains(["D"]) {
                if path.contains(["colours"]) {
                    mixer.lighting.faders.d.colours = patch(value: mixer.lighting.faders.d.colours, key: key, newValue: value)!
                    
                }
            }
        } else if path.contains(["simple"]) {
            if path.contains(["Scribble1"]) {
                mixer.lighting.simple.scribble1 = patch(value: mixer.lighting.simple.scribble1, key: key, newValue: value)
                
            } else if path.contains(["Scribble2"]) {
                mixer.lighting.simple.scribble2 = patch(value: mixer.lighting.simple.scribble2, key: key, newValue: value)
                
            } else if path.contains(["Scribble3"]) {
                mixer.lighting.simple.scribble3 = patch(value: mixer.lighting.simple.scribble3, key: key, newValue: value)
                
            } else if path.contains(["Scribble4"]) {
                mixer.lighting.simple.scribble4 = patch(value: mixer.lighting.simple.scribble4, key: key, newValue: value)
                
            } else if path.contains(["Accent"]) {
                mixer.lighting.simple.accent = patch(value: mixer.lighting.simple.accent, key: key, newValue: value)!
                
            }
        } else if path.contains(["buttons"]) {
            if path.contains(["colours"]) {
                mixer.lighting.buttons[path[2]]!.colours = patch(value: mixer.lighting.buttons[path[2]]!.colours, key: key, newValue: value)!
                
            }
            
        } else if path.contains(["encoders"]) {
            if path.contains(["Reverb"]) {
                mixer.lighting.encoders!.reverb = patch(value: mixer.lighting.encoders!.reverb, key: key, newValue: value)!
                
            } else if path.contains(["Pitch"]) {
                mixer.lighting.encoders!.pitch = patch(value: mixer.lighting.encoders!.pitch, key: key, newValue: value)!
                
            } else if path.contains(["Echo"]) {
                mixer.lighting.encoders!.echo = patch(value: mixer.lighting.encoders!.echo, key: key, newValue: value)!
                
            } else if path.contains(["Gender"]) {
                mixer.lighting.encoders!.gender = patch(value: mixer.lighting.encoders!.gender, key: key, newValue: value)!
                
            }
        } else if path.contains(["sampler"]) {
            if path.contains(["SamplerSelectA"]) {
                mixer.lighting.sampler!.samplerSelectA!.colours = patch(value: mixer.lighting.sampler!.samplerSelectA!.colours, key: key, newValue: value)!
                
            } else if path.contains(["SamplerSelectB"]) {
                mixer.lighting.sampler!.samplerSelectB!.colours = patch(value: mixer.lighting.sampler!.samplerSelectB!.colours, key: key, newValue: value)!
                
            } else if path.contains(["SamplerSelectC"]) {
                mixer.lighting.sampler!.samplerSelectC!.colours = patch(value: mixer.lighting.sampler!.samplerSelectC!.colours, key: key, newValue: value)!
                
            }
        }
        
    } else {
        Logger().log("Mixer path \(path) isn't implemented. Please add its requirements within the module.")
    }
}
