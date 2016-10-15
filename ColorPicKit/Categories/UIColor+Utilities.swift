//
//  UIColor+Utilities.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 9/24/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


/// Tuple where red, green, and blue range from 0.0 to 1.0
public typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)

/// Tuple where cyan, magenta, yellow,and black range from 0.0 to 1.0
public typealias CMYK = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)

/// Tuple where hue, saturation, and brightness range from 0.0 to 1.0
public typealias HSB = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)


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
    
    
    /// Create a wide UIColor
    ///
    /// - parameter rgbP3: An instance of RGB tuple
    /// - parameter alpha: Alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public class func colorWith(rgbP3: RGB, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: rgbP3, alpha: alpha)
    }

    
    /// Create a UIColor
    ///
    /// - parameter rgb:   An instance of RGB tuple
    /// - parameter alpha: An alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public class func colorWith(rgb: RGB, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(rgb: rgb, alpha: alpha)
    }

    
    /// Create a UIColor from Hue, Saturation, and Brightness
    ///
    /// - parameter hsb:   An instance of HSB tuple
    /// - parameter alpha: An alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public class func colorWith(hsb: HSB, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(hsb: hsb, alpha: alpha)
    }

    
    /// Create a UIColor from Cyan, Magenta, Yellow, and Black
    ///
    /// - parameter cmyk:  An instance of CMYK tuple
    /// - parameter alpha: An alpha value from 0.0 to 1.0
    ///
    /// - returns: UIColor instance
    public class func colorWith(cmyk: CMYK, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(cmyk: cmyk, alpha: alpha)
    }
    
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

    public convenience init(rgbP3: RGB, alpha: CGFloat = 1.0) {
        self.init(red:rgbP3.red, green:rgbP3.green, blue:rgbP3.blue, alpha:alpha)
    }

    
    public convenience init(rgb: RGB, alpha: CGFloat = 1.0) {
        self.init(red:rgb.red, green:rgb.green, blue:rgb.blue, alpha:alpha)
    }

    public convenience init(hsb: HSB, alpha: CGFloat = 1.0) {
        self.init(hue: hsb.hue, saturation: hsb.saturation, brightness: hsb.brightness, alpha: alpha)
    }

    public convenience init(cmyk: CMYK, alpha: CGFloat = 1.0) {
        let rgb = UIColor.cmykToRGB(cmyk: cmyk)
        self.init(red:rgb.red, green:rgb.green, blue:rgb.blue, alpha:alpha)
    }

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
    
    // MARK: Class helpers
    
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
    
    
    public class func interpolateAt(value: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor {
        
        let rgb1 = color1.rgb()
        let rgb2 = color2.rgb()
        
        let redDiff = rgb2.red - rgb1.red
        let red = rgb1.red  + redDiff * value
        
        let greenDiff = rgb2.green - rgb1.green
        let green = rgb1.green  + greenDiff * value
        
        let blueDiff = rgb2.blue - rgb1.blue
        let blue = rgb1.blue  + blueDiff * value
        
        //print("red: \(red) green: \(green) blue: \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }


}
