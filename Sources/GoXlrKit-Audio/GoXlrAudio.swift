//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SwiftUI
import AVFAudio
import AVFoundation
import SimplyCoreAudio
import os

public struct ManagedAggregate: Hashable {
    var uid: String
    var name: String
    var type: Aggregate
    var deviceModel: GoXlrModel
    
    var device: AudioDevice? {
        return SimplyCoreAudio().allAggregateDevices.first(where: {$0.uid == self.uid})
    }
    func delete() {
        if let deviceID = self.device?.id {
            let status = SimplyCoreAudio().removeAggregateDevice(id: deviceID)
            Logger().debug("\(status)")
        }
    }
//    func rename(to: String) {
//        guard to != self.name else { return }
//        
//        if let device = self.device {
//            device.name = to
//        }
//    }
}

public class GoXlrAudio {
    
    public static var shared: GoXlrAudio = {
        return GoXlrAudio()
    }()
    
    public let setUp: GoXlrAudioSetup
    
    @Published public var managedAggregates: Set<ManagedAggregate> = []
    
    public init() {
        self.setUp = .init()
    }
}

extension GoXlrAudio {
    public var GoXlrCD: AVCaptureDevice? {
        let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInMicrophone], mediaType: .audio, position: .unspecified).devices
        for device in devices {
            if device.localizedName == "GoXLR" {
                return device
            }
            else if device.localizedName == "GoXLRMini" {
                return device
            }
        }
        
        return nil
    }
    
    public func createSession() -> AVCaptureSession {
            
        let captureSession = AVCaptureSession()
        let audioDevice = AVCaptureDevice.default(for: .audio)
        let audioOutput = AVCaptureAudioDataOutput()
        do {
            // Wrap the audio device in a capture device input.
            let audioInput = try AVCaptureDeviceInput(device: self.GoXlrCD!)
            // If the input can be added, add it to the session.
            if captureSession.canAddInput(audioInput) {
                captureSession.addInput(audioInput)
            }
            captureSession.addOutput(audioOutput)
        } catch {
            // Configuration failed. Handle error.
            print("Error creating the capture session.")
            }
        return captureSession
    }
}
