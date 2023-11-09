//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 07/11/2023.
//

import SwiftUI
import Combine

@propertyWrapper
public struct GoXLRDynamicValue<Parent: ObservableObject & GoXLRCommandConvertible, Value: Equatable, Selection: Hashable>: DynamicProperty {
    private var parentKeyPath: KeyPath<Mixer, Parent> {
        paths[selection]!.0
    }
    private var valueKeyPath: KeyPath<Parent, Value> {
        paths[selection]!.1
    }
    private var fullKeyPath: KeyPath<Mixer, Value> {
        parentKeyPath.appending(path: valueKeyPath)
    }
    
    private let paths: [Selection:(KeyPath<Mixer, Parent>, KeyPath<Parent, Value>)]
    @Binding var selection: Selection
    
    @ObservedObject private var updater = Updater()
    private var cancellable: AnyCancellable? = nil
    
    public init(_ paths: [Selection:(KeyPath<Mixer, Parent>, KeyPath<Parent, Value>)], selection: Binding<Selection>) {
        self._selection = selection
        self.paths = paths
        
        //TODO: MAKE IT SO IT DON'T UPDATE FOR THE WHOLE CLASS
        for path in paths.values {
            cancellable = GoXlr.shared.mixer![keyPath: path.0].publisher(for: path.1).sink { [self] newValue in
                //Maybe check if value has really been updated and not just re-set ?
                guard path.1 == valueKeyPath else { return }
                updater.notifyUpdate()
            }
        }
    }
    
    public var wrappedValue: Value {
        get {
            GoXlr.shared.mixer![keyPath: fullKeyPath]
        }
        nonmutating set {
            guard liveUD else { return }
            
            if let command = GoXlr.shared.mixer?[keyPath: parentKeyPath].command(for: valueKeyPath, newValue: newValue) {
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
