//
//  HSBA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


public struct HSBA {
    public var hue: CGFloat
    public var saturation: CGFloat
    public var brightness: CGFloat
    public var alpha: CGFloat
    

    public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        self.hue = clip(hue)
        self.saturation = clip(saturation)
        self.brightness = clip(brightness)
        self.alpha = clip(alpha)
    }

    
    public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        self.init(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    public func description() -> String {
        return "hue: " + String(format: "%.2f", hue) +
            "saturation: " + String(format: "%.2f", saturation) +
            "brightness: " + String(format: "%.2f", brightness) +
            "alpha: " + String(format: "%.2f", alpha)
    }

    
    
    public func color() -> UIColor {
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        return color
    }
    
    // MARK: Converstions
    
    public func rgba() -> RGBA {
        return UIColor.hsbaToRGBA(hsba: self)
    }
    
    public func hsla() -> HSLA {
        let rgba = UIColor.hsbaToRGBA(hsba: self)
        let hsla = UIColor.rgbaToHSLA(rgba: rgba)
        return hsla
    }
    
    
    public func cmyka() -> CMYKA {
        return UIColor.hsbaToCMYKA(hsba: self)
    }
    
    public func yuva() -> YUVA {
        return UIColor.hsbaToYUVA(hsba: self)
    }
    
    // MARK: Static functions
    
    public static func colorWith(hsba: HSBA) -> UIColor {
        return hsba.color()
    }
    
}

extension HSBA: ColorString {
    
    public func stringFor(type: ColorStringType) -> String {
        
        let format = type.format()
        let factor = type.factor()
        
        if type == .baseOne {
            let hue360 = String(format: "%.1f°", hue * 360.0)
            let hueString = String(format: format, (hue * factor))
            let saturationString = String(format: format, (saturation * factor))
            let brightnessString = String(format: format, (brightness * factor))
            let alphaString = String(format: format, (alpha * factor))
            let hsbaString = "HSBA: (\(hue360)) (\(hueString), \(saturationString), \(brightnessString), \(alphaString))"
            return hsbaString
        } else {
            let hue360 = String(format: "%.1f°", hue * 360.0)
            let hueString = String(format: format, Int(hue * factor))
            let saturationString = String(format: format, Int(saturation * factor))
            let brightnessString = String(format: format, Int(brightness * factor))
            let alphaString = String(format: format, Int(alpha * factor))
            let hsbaString = "HSBA: (\(hue360)) (\(hueString), \(saturationString), \(brightnessString), \(alphaString))"
            return hsbaString
        }
    }
}


extension UIColor {
    
    // MARK: self to struct
    public func hsba(alpha: CGFloat = 1.0) -> HSBA {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return HSBA(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    
    // MARK: constructors
    
    public convenience init(hsba: HSBA, alpha: CGFloat = 1.0) {
        self.init(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness, alpha: hsba.alpha)
    }

    
    public class func colorWith(hsba: HSBA) -> UIColor {
        return hsba.color()
    }
    
    /* Name collision with UIColor */
//    public class func colorWith(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) -> UIColor {
//        let hsba = HSBA(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
//        return hsba.color()
//    }

    
    // MARK: conversions
    public class func hsbaToRGBA(hsba: HSBA) -> RGBA {
        let color = UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness, alpha: hsba.alpha)
        return color.rgba()
    }
    
    public class func hsbaToCMYKA(hsba: HSBA) -> CMYKA {
        let color = UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness, alpha: hsba.alpha)
        let cmyka = color.cmyka()
        return cmyka
    }
    
    public class func hsbaToYUVA(hsba: HSBA) -> YUVA {
        let color = UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: hsba.brightness, alpha: hsba.alpha)
        let yuva = color.yuva()
        return yuva
    }

}

extension UIImage {
    public func hsbaPixels() -> [HSBA] {
        var pixels = [HSBA]()
        for rgba in self.rgbaPixels() {
            let hsba = rgba.hsba()
            pixels.append(hsba)
        }
        return pixels
    }
}

