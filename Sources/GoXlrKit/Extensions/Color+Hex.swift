//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 09/06/2023.
//

import Foundation
import SwiftUI

public extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self = .black
            return
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        }

        self.init(red: r, green: g, blue: b, opacity: a)
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
        
        let hex = String(format: "%02X%02X%02X", red, green, blue)
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
