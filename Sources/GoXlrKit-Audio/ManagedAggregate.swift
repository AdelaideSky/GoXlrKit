//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 17/04/2023.
//

import Foundation
import SwiftUI
import SimplyCoreAudio
import os

/**
 A managed aggregate. Represent a aggregate created by the module's functions.
 */
public struct ManagedAggregate: Hashable, Codable, RawRepresentable, Identifiable {
    
    public var id: String
    public var name: String
    public var type: Aggregate
    public var deviceModel: GoXlrModel
    public var scope: GoXlrADScope
    
    public var device: AudioDevice? {
        return SimplyCoreAudio().allAggregateDevices.first(where: {$0.uid == self.id})
    }
    
    /**
     Deletes the aggregate.
     */
    public func delete() {
        if let deviceID = self.device?.id {
            let status = SimplyCoreAudio().removeAggregateDevice(id: deviceID)
            Logger().debug("\(status)")
        }
    }
    
    public init(_ uid: String, name: String, type: Aggregate, deviceModel: GoXlrModel, scope: GoXlrADScope) {
        self.id = uid
        self.name = name
        self.type = type
        self.deviceModel = deviceModel
        self.scope = scope
    }
    
    public init?(rawValue: String) {
        do {
            guard let data = rawValue.data(using: .utf8) else {
                return nil
            }
            let result = try JSONDecoder().decode(ManagedAggregate.self, from: data)
            self = result
        } catch let error {
            print(error)
            return nil
        }
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
    
    public enum GoXlrADScope: String, Codable {
        case input
        case output
    }
}

extension ManagedAggregate {
    enum CodingKeys: String, CodingKey {
        case id, name, type, deviceModel, scope
      }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(Aggregate.self, forKey: .type)
        deviceModel = try values.decode(GoXlrModel.self, forKey: .deviceModel)
        scope = try values.decode(GoXlrADScope.self, forKey: .scope)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(scope, forKey: .scope)
    }
}

extension Set<ManagedAggregate>: RawRepresentable {
    public init?(rawValue: String) {
        do {
            guard let data = rawValue.data(using: .utf8) else {
                return nil
            }
            let result = try JSONDecoder().decode(Set<ManagedAggregate>.self, from: data)
            self = result
        } catch let error {
            print(error)
            return nil
        }
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
