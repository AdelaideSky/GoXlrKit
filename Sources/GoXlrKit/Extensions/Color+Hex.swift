//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 09/06/2023.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
extension CGColor {
    func hex() -> String? {
        guard let components = self.components else {
            return nil
        }
        
        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        let blue = Int(components[2] * 255)
        
        let hex = String(format: "#%02X%02X%02X", red, green, blue)
        return hex
    }
}
extension Color: Codable {
    public func encode(to encoder: Encoder) throws {
        guard let cgColor = self.cgColor else {
            throw CodingError.wrongColor
        }
        var container = encoder.singleValueContainer()
        try container.encode(cgColor.hex())
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringHex = try container.decode(String.self)
        self = Color(hex: stringHex)
    }
    
}
enum CodingError: Error {
    case wrongColor
    case wrongData
}
