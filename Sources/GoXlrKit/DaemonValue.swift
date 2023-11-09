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
public struct DaemonValue<Parent: ObservableObject & DaemonCommandConvertible, Value: Equatable>: DynamicProperty {
    private let parentKeyPath: KeyPath<StatusClass, Parent>
    private let valueKeyPath: KeyPath<Parent, Value>
    private let fullKeyPath: KeyPath<StatusClass, Value>
    
    @ObservedObject private var updater = Updater()
    private var cancellable: AnyCancellable? = nil
    
    public init(_ parentKeyPath: KeyPath<StatusClass, Parent>, _ valueKeyPath: KeyPath<Parent, Value>) {
        self.parentKeyPath = parentKeyPath
        self.valueKeyPath = valueKeyPath
        self.fullKeyPath = parentKeyPath.appending(path: valueKeyPath)
        
        //TODO: MAKE IT SO IT DON'T UPDATE FOR THE WHOLE CLASS
        cancellable = GoXlr.shared.status!.data.status[keyPath: parentKeyPath].publisher(for: valueKeyPath).sink { [self] newValue in
            //Maybe check if value has really been updated and not just re-set ?
            updater.notifyUpdate()
        }
    }
    
    public var wrappedValue: Value {
        get {
            GoXlr.shared.status!.data.status[keyPath: fullKeyPath]
        }
        nonmutating set {
            if let command = GoXlr.shared.status!.data.status[keyPath: parentKeyPath].command(for: valueKeyPath, newValue: newValue) {
                GoXlr.shared.command(command)
            }
            
//            TODO: We'll probably need here to update the value directly, as it may result in UI lag. To do it, replace KeyPath by WritableKeyPath and uncomment this:
//            GoXlr.shared.mixer![keyPath: fullKeyPath] = newValue
            
            updater.notifyUpdate()
        }
    }
    
    public var projectedValue: Binding<Value> {
        return Binding(get: { wrappedValue }, set: { wrappedValue = $0})
    }
    
    class Updater: ObservableObject {
        func notifyUpdate() {
            objectWillChange.send()
        }
    }
}

@propertyWrapper
public struct DaemonStaticValue<Parent: ObservableObject, Value: Equatable>: DynamicProperty {
    private let parentKeyPath: KeyPath<StatusClass, Parent>
    private let valueKeyPath: KeyPath<Parent, Value>
    private let fullKeyPath: KeyPath<StatusClass, Value>
    
    @ObservedObject private var updater = Updater()
    private var cancellable: AnyCancellable? = nil
    
    public init(_ parentKeyPath: KeyPath<StatusClass, Parent>, _ valueKeyPath: KeyPath<Parent, Value>) {
        self.parentKeyPath = parentKeyPath
        self.valueKeyPath = valueKeyPath
        self.fullKeyPath = parentKeyPath.appending(path: valueKeyPath)
        
        //TODO: MAKE IT SO IT DON'T UPDATE FOR THE WHOLE CLASS
        cancellable = GoXlr.shared.status!.data.status[keyPath: parentKeyPath].publisher(for: valueKeyPath).sink { [self] newValue in
            //Maybe check if value has really been updated and not just re-set ?
            updater.notifyUpdate()
        }
    }
    
    public var wrappedValue: Value {
        get {
            GoXlr.shared.status!.data.status[keyPath: fullKeyPath]
        }
    }

    class Updater: ObservableObject {
        func notifyUpdate() {
            objectWillChange.send()
        }
    }
}

public protocol DaemonCommandConvertible: Codable {
    func command(for value: PartialKeyPath<Self>, newValue: any Any) -> DaemonCommand?
}
