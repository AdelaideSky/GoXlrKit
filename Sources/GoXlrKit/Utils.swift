//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SwiftUI
import ServiceManagement

public struct GoXlrUtils {
    public func registerInitAgents() {
        Task {
            do {
                try SMAppService.daemon(plistName: "fr.adesky.goxlr.plist").register()
                try SMAppService.daemon(plistName: "fr.adesky.goxlr.mini.plist").register()
            } catch let error {
                print(error)
            }
        }
    }
    
    public func toggleLaunchOnConnectAgent(_ enabled: Bool) {
        if enabled {
            registerLaunchOnConnectAgent()
        } else {
            unregisterLaunchOnConnectAgent()
        }
    }
    
    func registerLaunchOnConnectAgent() {
        Task {
            do {
                try SMAppService.agent(plistName: "fr.adesky.goxlr.autolaunch.plist").register()
                try SMAppService.agent(plistName: "fr.adesky.goxlr.autolaunch.mini.plist").register()
            } catch let error {
                print(error)
            }
        }
    }
    
    func unregisterLaunchOnConnectAgent() {
        Task {
            do {
                try SMAppService.agent(plistName: "fr.adesky.goxlr.autolaunch.plist").unregister()
                try SMAppService.agent(plistName: "fr.adesky.goxlr.autolaunch.mini.plist").unregister()
            } catch let error {
                print(error)
            }
        }
    }
}
