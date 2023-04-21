//
//  File.swift
//  
//
//  Created by Adélaïde Sky on 21/04/2023.
//

import Foundation

extension Array where Element: (Comparable & SignedNumeric) {

    func nearest(to value: Element) -> (offset: Int, element: Element)? {
        self.enumerated().min(by: {
            abs($0.element - value) < abs($1.element - value)
        })
    }
}

extension Int {
    public func GetCompRatio() -> CompressorRatio {
        return CompressorRatio.allCases[self]
    }
    public func GetClosestGateTime() -> GateTimes {
        let listimes = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
        let nearest = listimes.nearest(to: self)!.offset
        return GateTimes(rawValue: nearest)!
        
    }
    public func GetIntGateTime() -> Int {
        let listimes = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
        return listimes[self]
    }
    
    public func GetClosestAtkCompTime () -> CompressorAttackTime {
        let listimes = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 30, 35, 40]
        let nearest = listimes.nearest(to: self)!.element as Int
        return CompressorAttackTime(rawValue: "Comp\(nearest)ms")!
    }
    public func GetIntCompAtkTime() -> Int {
        let listimes = [0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 16, 18, 20, 23, 26, 30, 35, 40]
        return listimes[self]
    }
    public func GetClosestRelCompTime () -> CompressorReleaseTime {
        let listimes = [0, 15, 25, 35, 45, 55, 65, 75, 85, 95, 100, 115, 140, 170, 230, 340, 680, 1000, 1500, 2000, 3000]
        let nearest = listimes.nearest(to: self)!.element as Int
        return CompressorReleaseTime(rawValue: "Comp\(nearest)ms")!
    }
    public func GetIntCompRelTime() -> Int {
        let listimes = [0, 15, 25, 35, 45, 55, 65, 75, 85, 95, 100, 115, 140, 170, 230, 340, 680, 1000, 1500, 2000, 3000]
        return listimes[self]
    }
}

extension GateTimes {
    public var float: Float {
        let listimes = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 250, 300, 350, 400, 450, 500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000]
        return Float(listimes[self.rawValue])
    }
}
