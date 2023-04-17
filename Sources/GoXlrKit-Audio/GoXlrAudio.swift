//
//  GoXlrAudio.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SwiftUI
import AVFAudio
import AVFoundation
import os

/**
 GoXlrAudio class. Here you can find
 */
public class GoXlrAudio {
    
    public static var shared: GoXlrAudio = {
        return GoXlrAudio()
    }()
    
    public let setUp: GoXlrAudioSetup
    
    @AppStorage("fr.adesky.GoXlrKit.Audio.managedAggregates") public var managedAggregates: Set<ManagedAggregate> = []
    
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
            Logger().error("Error creating the capture session.")
            }
        return captureSession
    }
}
