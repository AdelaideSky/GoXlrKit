//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 06/11/2023.
//

import Foundation
import SwiftUI
import Combine

@propertyWrapper
public struct Parameter<Value>: DynamicProperty {
    
    let subject: CurrentValueSubject<Value, Never>
    private var command: ((Value, Value)) -> (Command?) //newValue, oldValue
    
    public var wrappedValue: Value {
        get { subject.value }
        nonmutating set {
            subject.value = newValue
        }
    }
    
    init(wrappedValue initialValue: Value, _ command: @escaping ((Value, Value)) -> (Command?)) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = command
    }
    
    init(wrappedValue initialValue: Value, _ command: @escaping ((Value, Value)) -> (GoXLRCommand?)) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = command
    }
    init(wrappedValue initialValue: Value, _ command: @escaping (Value) -> (GoXLRCommand?)) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = { command($0.0) }
    }
    
    init(wrappedValue initialValue: Value, _ command: @escaping ((Value, Value)) -> (DaemonCommand?)) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = command
    }
    init(wrappedValue initialValue: Value, _ command: @escaping (Value) -> (DaemonCommand?)) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = { command($0.0) }
    }
    
    public func set(_ newValue: Value) {
        if let command = command((newValue, subject.value)) { sendCommand(command) }
        subject.value = newValue
    }
    
    func sendCommand(_ command: some Command) {
        if let command = command as? GoXLRCommand {
            GoXlr.shared.command(command)
        } else if let command = command as? DaemonCommand {
            GoXlr.shared.command(command)
        }
    }
    
    public mutating func setCommand(_ command: @escaping ((Value, Value)) -> (GoXLRCommand?)) {
        self.command = command
    }
    public mutating func setCommand(_ command: @escaping (Value) -> (GoXLRCommand?)) {
        self.command = { command($0.0) }
    }
    public var projectedValue: Self {
        return self
    }
}
extension Parameter {
    init(wrappedValue initialValue: Value) {
        self.subject = CurrentValueSubject<Value, Never>(initialValue)
        self.command = { _ in nil }
    }
}
extension Parameter where Value == Bool {
    init(_ input: InputDevice, _ output: OutputDevice) {
        self.subject = CurrentValueSubject<Value, Never>(false)
        self.command = { GoXLRCommand.SetRouter(input, output, $0.0) }
    }
}

@propertyWrapper
public struct Value<Value>: DynamicProperty {
    @ObservedObject private var updater = Updater()
    private let keyPath: KeyPath<GoXlr, Parameter<Value>>
    private var cancellable: AnyCancellable? = nil
    
    public var wrappedValue: Value {
        get { GoXlr.shared[keyPath: keyPath].wrappedValue }
        nonmutating set {
            GoXlr.shared[keyPath: keyPath].set(newValue)
            updater.notifyUpdate()
        }
    }
    
    public init(_ path: KeyPath<StatusClass, Parameter<Value>>) {
        self.keyPath = (\GoXlr.status!.data.status).appending(path: path)
        
        self.cancellable = GoXlr.shared.status!.data.status[keyPath: path]
            .subject
            .throttle(for: 0.03, scheduler: DispatchQueue.main, latest: true)
            .sink { [self] _ in
                self.updater.notifyUpdate()
            }
    }
    public init(_ path: KeyPath<Mixer, Parameter<Value>>) {
        self.keyPath = (\GoXlr.mixer!).appending(path: path)
        
        self.cancellable = GoXlr.shared[keyPath: keyPath]
            .subject
            .throttle(for: 0.03, scheduler: DispatchQueue.main, latest: true)
            .sink { [self] _ in
                self.updater.notifyUpdate()
            }
    }
    
    public var projectedValue: Binding<Value> {
        return .init(get: {
            GoXlr.shared[keyPath: keyPath].wrappedValue
        }, set: {
            GoXlr.shared[keyPath: keyPath].set($0)
        })
    }
    
    class Updater: ObservableObject {
        func notifyUpdate() {
            objectWillChange.send()
        }
    }
}
