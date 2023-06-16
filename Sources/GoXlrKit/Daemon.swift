//
//  Daemon.swift
//  
//
//  Created by Adélaïde Sky on 27/12/2022.
//

import Foundation
import SwiftUI
import os

/**
 GoXlr-Daemon manager. Allows control over bundled daemon build.
 */
public struct Daemon {
    
    var daemonProcess = Process()
    public var daemonStatus: DaemonStatus = .stopped
    
    
    public enum daemonArguments: String, CaseIterable, Codable {
        case noHttp = "--http-disable"
        case enableCors = "--http-enable-cors"
        case httpPort = "--http-port"
        case logLevel = "--log-level"
        case noMenubarIcon = "--disable-tray"
        case startUI = "--start-ui"
        case bindAddress = "--http-bind-address"
    }
    public enum logLevels: String, CaseIterable, Codable {
        case off
        case error
        case warn
        case info
        case debug
        case trace
    }
    public enum DaemonStatus: String, CaseIterable, Codable {
        case stopped
        case launching
        case running
        case error
    }
    
    /**
     Starts the daemon binary located inside the Resources folder of the module.
     - Parameters:
        - args: An array of `daemonArguments` passed at launch of the daemon.
     - Note: If no goxlr-daemon file is found in the package, this function won't do anything.
     */
    public mutating func start(args: [daemonArguments]?) {
        
        let daemonPath = Bundle.main.url(forResource: "goxlr-daemon", withExtension: "")
        
        guard daemonPath != nil else {
            self.daemonStatus = .error
            fatalError("No daemon executable was found in the Resources of the app. Don't forget to add them !")
        }
        
        if GoXlr.shared.logLevel == .debug {
            Logger().debug("Launching daemon with parameters: \((args ?? []).debugDescription)")
        }
        
        daemonProcess.executableURL = daemonPath!
        if args != nil {
            daemonProcess.arguments = []
            for arg in args! {
                daemonProcess.arguments?.append(arg.rawValue)
            }
        }
        self.daemonStatus = .launching
        do {
            try daemonProcess.run()
        } catch {
            Logger().error("Failed to launch daemon: \(error)")
            self.daemonStatus = .error
            return
        }
        if GoXlr.shared.logLevel == .debug {
            Logger().debug("Daemon launched successfully.")
        }
        self.daemonStatus = .running
    }
    
    /**
     Stops the daemon **previously launched by the module**.
     - Note: This function can't stop a daemon not previously launched by the module.
     */
    public mutating func stop() {
        daemonProcess.interrupt()
        self.daemonStatus = .stopped
        daemonProcess = Process()
    }
    
    /**
     Stops the daemon **previously launched by the module** and launches it again.
     - Parameters:
        - args: An array of `daemonArguments` passed at launch of the daemon.
     - Note: This function can't restart a daemon not previously launched by the module.
     */
    public mutating func restart(args: [daemonArguments]?) {
        daemonProcess.interrupt()
        self.daemonStatus = .stopped
        daemonProcess = Process()
        self.start(args: args)
    }
}
