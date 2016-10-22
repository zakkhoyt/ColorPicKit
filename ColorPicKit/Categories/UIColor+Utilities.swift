//
//  UIColor+Utilities.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 9/24/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


///// Tuple where red, green, and blue range from 0.0 to 1.0
//public typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat)
//
///// Tuple where cyan, magenta, yellow,and black range from 0.0 to 1.0
//public typealias CMYKA = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)
//
///// Tuple where hue, saturation, and brightness range from 0.0 to 1.0
//public typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)


public extension UIColor {

    // MARK: Class factory
    
    
    /// Create a UIColor with a hex string
    ///
    /// - parameter hexString: RRGGBB or #RRGGBB where RR, GG, and BB range from "00" to "FF"
    /// - parameter alpha:     Alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public class func colorWith(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hexString: hexString, alpha: alpha)
    }
    
    
//    /// Create a wide UIColor
//    ///
//    /// - parameter rgbP3: An instance of RGBA tuple
//    /// - parameter alpha: Alpha value from 0.0 to 1.0
//    ///
//    /// - returns: UIColor instance
//    public class func colorWith(rgbP3: RGBA, alpha: CGFloat = 1.0) -> UIColor {
//        //return UIColor(rgb: rgbP3, alpha: alpha)
//        return UIColor(rgba: <#T##RGBA#>, alpha: <#T##CGFloat#>)
//    }
//    /// Create a UIColor
//    ///
//    /// - parameter rgb:   An instance of RGBA tuple
//    /// - parameter alpha: An alpha value from 0.0 to 1.0
//    ///
//    /// - returns: UIColor instance
//    public class func colorWith(rgba: RGBA, alpha: CGFloat = 1.0) -> UIColor {
//        return UIColor(rgba: rgba, alpha: alpha)
//    }
//
//    
//    /// Create a UIColor from Hue, Saturation, and Brightness
//    ///
//    /// - parameter hsb:   An instance of HSBA tuple
//    /// - parameter alpha: An alpha value from 0.0 to 1.0
//    ///
//    /// - returns: UIColor instance
//    public class func colorWith(hsba: HSBA, alpha: CGFloat = 1.0) -> UIColor {
//        return UIColor(hsba: hsba, alpha: alpha)
//    }
//
//    
//    /// Create a UIColor from Cyan, Magenta, Yellow, and Black
//    ///
//    /// - parameter cmyk:  An instance of CMYKA tuple
//    /// - parameter alpha: An alpha value from 0.0 to 1.0
//    ///
//    /// - returns: UIColor instance
//    public class func colorWith(cmyka: CMYKA, alpha: CGFloat = 1.0) -> UIColor {
//        return UIColor(cmyka: cmyka, alpha: alpha)
//    }
    
    // MARK: Init methods
    
    
    /// Create a UIColor with a hex string
    ///
    /// - parameter hexString: RRGGBB or #RRGGBB
    /// - parameter alpha:     An alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public convenience init(hexString:String, alpha: CGFloat = 1.0) {
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
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

//    public convenience init(rgbP3: RGBA, alpha: CGFloat = 1.0) {
//        self.init(red:rgbP3.red, green:rgbP3.green, blue:rgbP3.blue, alpha:alpha)
//    }
//
//    
//    public convenience init(rgb: RGBA, alpha: CGFloat = 1.0) {
//        self.init(red:rgb.red, green:rgb.green, blue:rgb.blue, alpha:alpha)
//    }
//
//    public convenience init(hsb: HSBA, alpha: CGFloat = 1.0) {
//        self.init(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: alpha)
//    }
//
//    public convenience init(cmyk: CMYKA, alpha: CGFloat = 1.0) {
//        let rgb = UIColor.cmykToRGBA(cmyk: cmyk)
//        self.init(red:rgb.red, green:rgb.green, blue:rgb.blue, alpha:alpha)
//    }

    // MARK: Helpers
    public func hexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"%06x", rgb).uppercased()
    }
    
    
//    public func rgb() -> RGBA {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//        
//        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//        return (red, green, blue)
//    }
//    public func hsb() -> HSBA {
//        var hue: CGFloat = 0
//        var saturation: CGFloat = 0
//        var brightness: CGFloat = 0
//        var alpha: CGFloat = 0
//        
//        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
//        return (hue, saturation, brightness)
//    }
//    
//    public func cmyk() -> CMYKA {
//        let rgb = self.rgb()
//        return UIColor.rgbToCMYKA(rgb: rgb)
//    }
//    
//    // MARK: Class helpers
//    
//    // http://www.rapidtables.com/convert/color/rgb-to-cmyk.htm
//    public class func rgbToCMYKA(rgb: RGBA) -> CMYKA {
//        // Let's use almostOne so we don't end up with NaN
//        let almostOne = CGFloat(1.00000000000001)
//        let black = 1 - max(rgb.red, rgb.green, rgb.blue)
//        let cyan =  (1.0 - rgb.red - black) / (almostOne - black)
//        let magenta =  (1.0 - rgb.green - black) / (almostOne - black)
//        let yellow =  (1.0 - rgb.blue - black) / (almostOne - black)
//        return (cyan, magenta, yellow, black)
//    }
//    
//    public class func rgbToHSBA(rgb: RGBA) -> HSBA {
//        let color = UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
//        let hsb = color.hsb()
//        return hsb
//    }
//    
//    
//    public class func hsbToRGBA(hsb: HSBA) -> RGBA {
//        let color = UIColor(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: 1.0)
//        return color.rgb()
//    }
//    
//    // http://www.rapidtables.com/convert/color/cmyk-to-rgb.htm
//    public class func cmykToRGBA(cmyk: CMYKA) -> RGBA {
//        let red = (1.0 - cmyk.cyan) * (1.0 - cmyk.black)
//        let green = (1.0 - cmyk.magenta) * (1.0 - cmyk.black)
//        let blue = (1.0 - cmyk.yellow) * (1.0 - cmyk.black)
//        return (red, green, blue)
//    }
//    
//    
//    public class func hsbToCMYKA(hsb: HSBA) -> CMYKA {
//        let color = UIColor(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: 1.0)
//        let cmyk = color.cmyk()
//        return cmyk
//    }
//    
//    public class func cmykToHSBA(cmyk: CMYKA) -> HSBA {
//        let rgb = UIColor.cmykToRGBA(cmyk: cmyk)
//        let color = UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
//        let hsb = color.hsb()
//        return hsb
//    }
    
    
    public class func interpolateAt(value: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor {
        
        let rgba1 = color1.rgba()
        let rgba2 = color2.rgba()
        
        let redDiff = rgba2.red - rgba1.red
        let red = rgba1.red  + redDiff * value
        
        let greenDiff = rgba2.green - rgba1.green
        let green = rgba1.green  + greenDiff * value
        
        let blueDiff = rgba2.blue - rgba1.blue
        let blue = rgba1.blue  + blueDiff * value
        
        //print("red: \(red) green: \(green) blue: \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }


}
