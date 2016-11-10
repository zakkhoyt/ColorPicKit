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



    // MARK: Helpers
    public func hexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"%06X", rgb).uppercased()
    }
    
 
    
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
