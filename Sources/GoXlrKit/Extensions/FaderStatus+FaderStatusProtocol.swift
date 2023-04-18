//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 18/04/2023.
//

import Foundation
import SwiftUI

protocol FaderStatus: Codable {
    public var channel: ChannelName
    public var muteType: MuteFunction
    public var scribble: ScribbleA?
    public var muteState: MuteState
}

extension FaderStatusA: FaderStatus {}
extension FaderStatusB: FaderStatus {}
extension FaderStatusC: FaderStatus {}
extension FaderStatusD: FaderStatus {}
