//
//  HSLA.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public struct HSLA {
    var hue: CGFloat
    var saturation: CGFloat
    var lightness: CGFloat
    var alpha: CGFloat
    
    
    public init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
        self.hue = clip(hue)
        self.saturation = clip(saturation)
        self.lightness = clip(lightness)
        self.alpha = clip(alpha)
    }
    
    
    public init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        self.init(hue: hue, saturation: saturation, lightness: lightness, alpha: 1.0)
    }
    
    public func color() -> UIColor {
        let rgba = self.rgba()
        let color = UIColor(rgba: rgba)
        return color
    }
    
    public func description() -> String {
        return "hue: " + String(format: "%.2f", hue) +
            "saturation: " + String(format: "%.2f", saturation) +
            "lightness: " + String(format: "%.2f", lightness) +
            "alpha: " + String(format: "%.2f", alpha)
    }

    
    // MARK: Converstions
    
    public func rgba() -> RGBA {
        return UIColor.hslaToRGBA(hsla: self)
    }
    
    public func hsba() -> HSBA {
        let rgba = UIColor.hslaToRGBA(hsla: self)
        let hsba = UIColor.rgbaToHSBA(rgba: rgba)
        return hsba

    }
    
    public func cmyka() -> CMYKA {
        return UIColor.hslaToCMYKA(hsla: self)
    }
    
    public func yuva() -> YUVA {
        return UIColor.hslaToYUVA(hsla: self)
    }
    
    // MARK: Static functions
    
    public static func colorWith(hsla: HSLA) -> UIColor {
        return hsla.color()
    }
    
}

extension HSLA: ColorString {
    
    public func stringFor(type: ColorStringType) -> String {
        
        let format = type.format()
        let factor = type.factor()
        
        if type == .baseOne {
            let hue360 = String(format: "%.1f°", hue * 360.0)
            let hueString = String(format: format, (hue * factor))
            let saturationString = String(format: format, (saturation * factor))
            let lightnessString = String(format: format, (lightness * factor))
            let alphaString = String(format: format, (alpha * factor))
            let hsbaString = "HSLA: (\(hue360)) (\(hueString), \(saturationString), \(lightnessString), \(alphaString))"
            return hsbaString
        } else {
            let hue360 = String(format: "%.1f°", hue * 360.0)
            let hueString = String(format: format, Int(hue * factor))
            let saturationString = String(format: format, Int(saturation * factor))
            let lightnessString = String(format: format, Int(lightness * factor))
            let alphaString = String(format: format, Int(alpha * factor))
            let hsbaString = "HSLA: (\(hue360)) (\(hueString), \(saturationString), \(lightnessString), \(alphaString))"
            return hsbaString
        }
    }
}

public extension UIColor {
    
    // MARK: self to struct
    public func hsla(alpha: CGFloat = 1.0) -> HSLA {
        //return self.hsla()
        let rgba = self.rgba()
        let hsla = UIColor.rgbaToHSLA(rgba: rgba)
        return hsla
    }
    
    
    // MARK: constructors
    
    public convenience init(hsla: HSLA, alpha: CGFloat = 1.0) {
        let rgba = UIColor.hslaToRGBA(hsla: hsla)
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    
    public class func colorWith(hsla: HSLA) -> UIColor {
        return hsla.color()
    }
    
    /* Name collision with UIColor */
    public class func colorWith(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) -> UIColor {
        let hsla = HSLA(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        return hsla.color()
    }
    
    
    // MARK: conversions
    
    // http://www.easyrgb.com/index.php?X=MATH
    public class func hslaToRGBA(hsla: HSLA) -> RGBA {

        func hueToRGB( iv1: CGFloat, iv2: CGFloat, ivH: CGFloat ) -> CGFloat {
            
            let v1: CGFloat = iv1
            let v2: CGFloat = iv2
            var vH: CGFloat = ivH
            
            if ( vH < 0 ) { vH += 1 }
            if ( vH > 1 ) { vH -= 1 }
            if ( ( 6 * vH ) < 1 ) { return ( v1 + ( v2 - v1 ) * 6 * vH ) }
            if ( ( 2 * vH ) < 1 ) { return ( v2 ) }
            if ( ( 3 * vH ) < 2 ) { return ( v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6 ) }
            return ( v1 )
        }
        
        let hue = hsla.hue
        let saturation = hsla.saturation
        let lightness = hsla.lightness
        let alpha = hsla.alpha
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        if saturation == 0 {                       
            red = lightness * 1.0
            green = lightness * 1.0
            blue = lightness * 1.0
        } else {
            
            var var_2: CGFloat = 0
            
            if lightness < 0.5 {
                var_2 = lightness * ( 1 + saturation )
            } else {
                var_2 = ( lightness + saturation ) - ( saturation * lightness )
            }
            
            let var_1: CGFloat = 2 * lightness - var_2
            red = 1.0 * hueToRGB(iv1: var_1, iv2: var_2, ivH: hue + (1.0 / 3.0))
            green = 1.0 * hueToRGB(iv1: var_1, iv2: var_2, ivH: hue)
            blue = 1.0 * hueToRGB(iv1: var_1, iv2: var_2, ivH: hue - (1.0 / 3.0))
        }
        
        return RGBA(red: red, green: green, blue: blue, alpha: alpha)

    }
    
    public class func hslaToCMYKA(hsla: HSLA) -> CMYKA {
        let color = UIColor.hslaToRGBA(hsla: hsla)
        let cmyka = color.cmyka()
        return cmyka
    }
    
    public class func hslaToYUVA(hsla: HSLA) -> YUVA {
        let color = UIColor(hsla: hsla)
        let yuva = color.yuva()
        return yuva
    }
    
}

extension UIImage {
    public func hslaPixels() -> [HSLA] {
        var pixels = [HSLA]()
        for rgba in self.rgbaPixels() {
            let hsla = rgba.hsla()
            pixels.append(hsla)
        }
        return pixels
    }
}

