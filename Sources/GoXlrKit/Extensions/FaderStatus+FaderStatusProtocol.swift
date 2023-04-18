//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 18/04/2023.
//

import Foundation
import SwiftUI

protocol Scribble: Codable {
    var fileName: String { get set }
    var bottomText: String { get set }
    var leftText: String? { get set }
    var inverted: Bool { get set }
}
extension ScribbleA: Scribble {}
extension ScribbleB: Scribble {}
extension ScribbleC: Scribble {}
extension ScribbleD: Scribble {}

protocol FaderStatus: Codable {
    associatedtype ScribbleType: Scribble
    var channel: ChannelName { get set }
    var muteType: MuteFunction { get set }
    var scribble: ScribbleType? { get set }
    var muteState: MuteState { get set }
}

extension FaderStatusA: FaderStatus {}
extension FaderStatusB: FaderStatus {}
extension FaderStatusC: FaderStatus {}
extension FaderStatusD: FaderStatus {}
