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
extension Color: Codable {
    public func encode(to encoder: Encoder) throws {
        guard let cgColor = self.cgColor else {
            throw CodingError.wrongColor
        }
        var container = encoder.singleValueContainer()
        try container.encode(CodableColor(cgColor: cgColor))
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let codableColor = try container.decode(CodableColor.self)
        self = Color(cgColor: codableColor.cgColor)
    }
    
}
struct CodableColor: Codable {
    let cgColor: CGColor
    
    enum CodingKeys: String, CodingKey {
        case colorSpace
        case components
    }
    
    init(cgColor: CGColor) {
        self.cgColor = cgColor
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: CodingKeys.self)
        let colorSpace = try container
            .decode(String.self, forKey: .colorSpace)
        let components = try container
            .decode([CGFloat].self, forKey: .components)
        
        guard
            let cgColorSpace = CGColorSpace(name: colorSpace as CFString),
            let cgColor = CGColor(
                colorSpace: cgColorSpace, components: components
            )
        else {
            throw CodingError.wrongData
        }
        
        self.cgColor = cgColor
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard
            let colorSpace = cgColor.colorSpace?.name,
            let components = cgColor.components
        else {
            throw CodingError.wrongData
        }
              
        try container.encode(colorSpace as String, forKey: .colorSpace)
        try container.encode(components, forKey: .components)
    }
}

enum CodingError: Error {
    case wrongColor
    case wrongData
}

func encodeColor(color: Color) throws -> Data {
    guard let cgColor = color.cgColor else {
        throw CodingError.wrongColor
    }
    return try JSONEncoder()
        .encode(CodableColor(cgColor: cgColor))
}

func decodeColor(from data: Data) throws -> Color {
    let codableColor = try JSONDecoder()
        .decode(CodableColor.self, from: data)
    return Color(cgColor: codableColor.cgColor)
}
