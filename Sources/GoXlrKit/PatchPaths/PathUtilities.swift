//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 20/04/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import os

internal func patch<type: Codable>(value: any Codable, key: String, newValue: JSON) -> type? {
    do {
        var json = try JSON(data: try JSONEncoder().encode(value))
        json[key] = newValue
        return try JSONDecoder().decode(type.self, from: try json.rawData())
    } catch let error {
        Logger().error("Error patching \(key): \(error) Please check the implementation of this path.")
        return nil
    }
}

internal func patch<type: Codable>(value: any Codable, key: String, index: Int, newValue: JSON) -> type? {
    do {
        var json = try JSON(data: try JSONEncoder().encode(value))
        json[index][key] = newValue
        return try JSONDecoder().decode(type.self, from: try json.rawData())
    } catch let error {
        Logger().error("Error patching \(key): \(error) Please check the implementation of this path.")
        return nil
    }
}

internal func patch<type: Codable>(value: any Codable, key: Int, newValue: JSON) -> type? {
    do {
        var json = try JSON(data: try JSONEncoder().encode(value))
        json[key] = newValue
        return try JSONDecoder().decode(type.self, from: try json.rawData())
    } catch let error {
        Logger().error("Error patching \(key): \(error) Please check the implementation of this path.")
        return nil
    }
}

internal func patch<type>(value: Array<type>, add: type, at: Int?) -> Array<type> {
    if at == nil {
        Logger().error("Error adding item to \(value.debugDescription): no offset. Please check the implementation of this path.")
    }
    var answer = value
    answer.insert(add, at: at ?? 0)
    return answer
}
internal func patch<type, secondtype>(value: type, add: secondtype, path: WritableKeyPath<type, Array<secondtype>>, at: Int?) -> type {
    if at == nil {
        Logger().error("Error adding item to: no offset. Please check the implementation of this path.")
    }
    var answer = value
    answer[keyPath: path].insert(add, at: at ?? 0)
    return answer
}

internal func patch<type: Equatable>(value: Array<type>, removeAt: Int?) -> Array<type> {
    if removeAt == nil {
        Logger().error("Error removing item to \(value.debugDescription): no offset. Please check the implementation of this path.")
    }
    var answer = value
    answer.remove(at: removeAt ?? 0)
    return answer
}
