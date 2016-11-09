//
//  ColorStringType.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 10/1/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public enum ColorStringType: Int {
    case baseOne
    case baseTen
    case baseSixteen
    
    
    
    public func string() -> String {
        switch self {
        case .baseSixteen:
            return "0x00-0xFF"
        case .baseTen:
            return "00-255"
        case .baseOne:
            return "0.0-1.0"
        }
    }
    
    func format() -> String {
        switch self {
        case .baseOne:
            return "%.02f"
        case .baseTen:
            return "%03d"

        case .baseSixteen:
            return "%02X"

        }
    }
    
    func factor() -> CGFloat {
        switch self {
        case .baseOne:
            return 1.0
        case .baseTen:
            return 255.0
        case .baseSixteen:
            return 255.0
        }
        
    }
    
    func formattedValue(value: CGFloat) -> Any {
        switch self {
        case .baseOne:
            return Double(value * self.factor())
        case .baseTen:
            return Int(value * self.factor())
        case .baseSixteen:
            return Int(value * self.factor())
        }
        
    }

}
