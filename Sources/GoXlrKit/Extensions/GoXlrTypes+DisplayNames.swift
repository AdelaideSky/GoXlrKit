//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 18/04/2023.
//

import Foundation
import SwiftUI

extension ChannelName {
    var displayName: String {
        switch self {
        case .LineIn:
            return "Line-In"
        case .MicMonitor:
            return "Mic Monitor"
        case .LineOut:
            return "Line-Out"
        default:
            return self.rawValue
        }
    }
}

