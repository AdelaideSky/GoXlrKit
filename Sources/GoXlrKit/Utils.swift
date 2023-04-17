//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SwiftUI
import ServiceManagement

struct Utils {
    func registerInitAgents() {
        Task {
            do {
                try SMAppService.daemon(plistName: "com.adesky.goxlr.plist").register()
                try SMAppService.daemon(plistName: "com.adesky.goxlr.mini.plist").register()
            } catch let error {
                print(error)
            }
        }
    }
    func registerLaunchOnConnectAgent() {
        Task {
            do {
                try SMAppService.daemon(plistName: "com.adesky.goxlr.plist").register()
                try SMAppService.daemon(plistName: "com.adesky.goxlr.mini.plist").register()
            } catch let error {
                print(error)
            }
        }
    }
    func unregisterLaunchOnConnectAgent() {
        Task {
            do {
                try SMAppService.daemon(plistName: "com.adesky.goxlr.plist").unregister()
                try SMAppService.daemon(plistName: "com.adesky.goxlr.mini.plist").unregister()
            } catch let error {
                print(error)
            }
        }
    }
}
