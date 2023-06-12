//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 12/06/2023.
//

import Foundation

fileprivate func shell(_ command: String) -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
}

public struct Shortcuts {
    
    public init() {}
    
    public func get() -> [String] {
        return shell("shortcuts list").components(separatedBy: "\n")
    }
    public func run(_ shortcut: String) {
        _ = shell("shortcuts run \(shortcut)")
    }
}
