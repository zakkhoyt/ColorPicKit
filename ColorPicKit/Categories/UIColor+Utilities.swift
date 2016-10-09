//
//  UIColor+Utilities.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 9/24/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


public typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
public typealias CMYK = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)
public typealias HSB = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)


public extension UIColor {
    public convenience init(hexString:String) {
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    public func hexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"%06x", rgb).uppercased()
    }
    
    
    public func rgb() -> RGB {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue)
    }
    public func hsb() -> HSB {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue, saturation, brightness)
    }
    
    public func cmyk() -> CMYK {
        let rgb = self.rgb()
        return UIColor.rgbToCMYK(rgb: rgb)
    }
    
    // http://www.rapidtables.com/convert/color/rgb-to-cmyk.htm
    public class func rgbToCMYK(rgb: RGB) -> CMYK {
        // Let's use almostOne so we don't end up with NaN
        let almostOne = CGFloat(1.00000000000001)
        let black = 1 - max(rgb.red, rgb.green, rgb.blue)
        let cyan =  (1.0 - rgb.red - black) / (almostOne - black)
        let magenta =  (1.0 - rgb.green - black) / (almostOne - black)
        let yellow =  (1.0 - rgb.blue - black) / (almostOne - black)
        return (cyan, magenta, yellow, black)
    }
    
    public class func rgbToHSB(rgb: RGB) -> HSB {
        let color = UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
        let hsb = color.hsb()
        return hsb
    }
    
    
    public class func hsbToRGB(hsb: HSB) -> RGB {
        let color = UIColor(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: 1.0)
        return color.rgb()
    }
    
    // http://www.rapidtables.com/convert/color/cmyk-to-rgb.htm
    public class func cmykToRGB(cmyk: CMYK) -> RGB {
        let red = (1.0 - cmyk.cyan) * (1.0 - cmyk.black)
        let green = (1.0 - cmyk.magenta) * (1.0 - cmyk.black)
        let blue = (1.0 - cmyk.yellow) * (1.0 - cmyk.black)
        return (red, green, blue)
    }
    
    
    public class func hsbToCMYK(hsb: HSB) -> CMYK {
        let color = UIColor(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: 1.0)
        let cmyk = color.cmyk()
        return cmyk
    }
    
    public class func cmykToHSB(cmyk: CMYK) -> HSB {
        let rgb = UIColor.cmykToRGB(cmyk: cmyk)
        let color = UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
        let hsb = color.hsb()
        return hsb
    }
    
    
    public class func interpolateAt(percent: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor {
        
        let rgb1 = color1.rgb()
        let rgb2 = color2.rgb()
        
        
        let redDiff = rgb2.red - rgb1.red
        let red = rgb1.red  + redDiff * percent
        
        let greenDiff = rgb2.green - rgb1.green
        let green = rgb1.green  + greenDiff * percent
        
        let blueDiff = rgb2.blue - rgb1.blue
        let blue = rgb1.blue  + blueDiff * percent
        
        //print("red: \(red) green: \(green) blue: \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }


}
