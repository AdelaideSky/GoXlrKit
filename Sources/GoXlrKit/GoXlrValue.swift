//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 31/10/2023.
//

import Foundation
import Combine
import SwiftUI
//import SwiftSyntax
//import SwiftSyntaxMacros

//@freestanding(expression)
//public macro GoXLRValue<Parent: ObservableObject & GoXLRCommandConvertible, Value: Equatable>(_ parentKeyPath: KeyPath<Mixer, Parent>, _ valueKeyPath: KeyPath<Parent, Value>) -> GoXLRValue<Parent, Value> = #externalMacro(module: "GoXlrKit", type: "GoXLRValueMacro")
//
//public struct GoXLRValueMacro: ExpressionMacro {
//    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
//                                 in context: some SwiftSyntaxMacros.MacroExpansionContext
//    ) throws -> SwiftSyntax.ExprSyntax {
//        let firstArgument = "\\.\(node.argumentList.first!.expression.as(KeyPathExprSyntax.self)?.components.compactMap({ $0.as(KeyPathComponentSyntax.self)?.component.as(KeyPathPropertyComponentSyntax.self)?.declName.baseName.text}).joined(separator: ".") ?? "")"
//        let secondArgPath = "\(node.argumentList.last!.expression.as(KeyPathExprSyntax.self)?.components.compactMap({ $0.as(KeyPathComponentSyntax.self)?.component.as(KeyPathPropertyComponentSyntax.self)?.declName.baseName.text}).joined(separator: ".") ?? "")"
//        let secondArgument = "\\.\(secondArgPath)"
//        let thirdArgument = "\\.$\(secondArgPath)"
//        return "@GoXLRValue(\(raw: firstArgument), \(raw: secondArgument), \(raw: thirdArgument))"
//    }
//    
//}

@propertyWrapper
public struct GoXLRValue<Parent: ObservableObject & GoXLRCommandConvertible, Value: Equatable>: DynamicProperty {
    private let parentKeyPath: KeyPath<Mixer, Parent>
    private let valueKeyPath: KeyPath<Parent, Value>
    private let fullKeyPath: KeyPath<Mixer, Value>
    
    @ObservedObject private var updater = Updater()
    private var cancellable: AnyCancellable? = nil
    
    public init(_ parentKeyPath: KeyPath<Mixer, Parent>, _ valueKeyPath: KeyPath<Parent, Value>) {
        self.parentKeyPath = parentKeyPath
        self.valueKeyPath = valueKeyPath
        self.fullKeyPath = parentKeyPath.appending(path: valueKeyPath)
        
        //TODO: MAKE IT SO IT DON'T UPDATE FOR THE WHOLE CLASS
        cancellable = GoXlr.shared.mixer![keyPath: parentKeyPath].publisher(for: valueKeyPath).sink { [self] newValue in
            //Maybe check if value has really been updated and not just re-set ?
            updater.notifyUpdate()
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

@propertyWrapper
public struct GoXLRStaticValue<Parent: ObservableObject, Value: Equatable>: DynamicProperty {
    private let parentKeyPath: KeyPath<Mixer, Parent>
    private let valueKeyPath: KeyPath<Parent, Value>
    private let fullKeyPath: KeyPath<Mixer, Value>
    
    @ObservedObject private var updater = Updater()
    private var cancellable: AnyCancellable? = nil
    
    public init(_ parentKeyPath: KeyPath<Mixer, Parent>, _ valueKeyPath: KeyPath<Parent, Value>) {
        self.parentKeyPath = parentKeyPath
        self.valueKeyPath = valueKeyPath
        self.fullKeyPath = parentKeyPath.appending(path: valueKeyPath)
        
        //TODO: MAKE IT SO IT DON'T UPDATE FOR THE WHOLE CLASS
        cancellable = GoXlr.shared.mixer![keyPath: parentKeyPath].publisher(for: valueKeyPath).sink { [self] _ in
            //Maybe check if value has really been updated and not just re-set ?
            updater.notifyUpdate()
        }
    }
    
    public var wrappedValue: Value {
        get {
            GoXlr.shared.mixer![keyPath: fullKeyPath]
        }
    }
    
    class Updater: ObservableObject {
        func notifyUpdate() {
            objectWillChange.send()
        }
    }
}

public extension ObservableObject {
    func publisher<Value>(for keyPath: KeyPath<Self, Value>) -> AnyPublisher<Value, Never> {
        return self.objectWillChange
            .map { _ in self[keyPath: keyPath] }
            .eraseToAnyPublisher()
    }
}

public protocol GoXLRCommandConvertible: Codable {
    func command(for value: PartialKeyPath<Self>, newValue: any Any) -> GoXLRCommand?
}
