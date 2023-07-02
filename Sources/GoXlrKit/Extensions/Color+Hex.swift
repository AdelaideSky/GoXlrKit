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
        var r: CGFloat = CGFloat(UInt8(hex[0...1], radix: 16) ?? .zero)
        var g: CGFloat = CGFloat(UInt8(hex[2...3], radix: 16) ?? .zero)
        var b: CGFloat = CGFloat(UInt8(hex[4...5], radix: 16) ?? .zero)

        self.init(red: r, green: g, blue: b, opacity: 1)
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

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}
