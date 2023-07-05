//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 09/06/2023.
//

import Foundation
import SwiftUI
import SkyKitC
import SkyKit_Design


extension Color: Codable {
    public func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()
        try container.encode(self.hex.uppercased())
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringHex = try container.decode(String.self)
        if let color = Color(hex: stringHex) {
            self = color
        } else { throw CodingError.wrongData }
       
    }
    
}
enum CodingError: Error {
    case wrongColor
    case wrongData
}
