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
//        let newhex = (String(data: try! JSONEncoder().encode(Color.init(red: r, green: g, blue: b, opacity: a)), encoding: .utf8) ?? "").replacingOccurrences(of: "\"", with: "")
//        
//        guard newhex == hex else {
//            print("---")
//            print("ERROR:")
//            print("INPUT: \(hex)")
//            print("OUTPUT: \(newhex)")
//            print("RGB: \(r*255) \(g*255) \(b*255)")
//            self = .black
//            return
//        }
        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

extension Color: Codable {
    public func encode(to encoder: Encoder) throws {
        
        let components = self.getRGB()
        let rgb: Int = (Int)(components.0*255)<<16 | (Int)(components.1*255)<<8 | (Int)(components.2*255)<<0
        
        let hex = NSString(format:"%06x", rgb) as String
        
        var container = encoder.singleValueContainer()
        try container.encode(hex.uppercased())
        
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

extension Color {
    func getRGB() -> (CGFloat, CGFloat, CGFloat) {
        guard let nsColor = NSColor(self).usingColorSpace(.deviceRGB) else {
            return (0, 0, 0)
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        nsColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue)
    }
}
