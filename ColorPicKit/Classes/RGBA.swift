//
//  RGBA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


public struct RGBA {
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
    
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = 1.0
    }
    
    func color() -> UIColor {
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    
    // MARK: Converstions
    
    
    public func hsba() -> HSBA {
        return UIColor.rgbaToHSBA(rgba: self)
    }
    
    public func cmyka() -> CMYKA {
        return UIColor.rgbaToCMYKA(rgba: self)
    }
    
    public func yuva() -> YUVA {
        return UIColor.rgbaToYUVA(rgba: self)
    }
    
    
    // MARK: Static functions
    
    static func colorWith(rgba: RGBA) -> UIColor {
        return rgba.color()
    }
    
}

extension UIColor {
    
    // MARK: UIColor to self
    public func rgba(alpha: CGFloat = 1.0) -> RGBA {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return RGBA(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // MARK: constructors
    
    public convenience init(rgba: RGBA, alpha: CGFloat = 1.0) {
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }

    public class func colorWith(rgba: RGBA) -> UIColor {
        return rgba.color()
    }
    
    /* Name collision with UIColor */
//    public class func colorWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
//        let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
//        return UIColor.colorWith(rgba: rgba)
//    }
    
    
    // MARK: conversions
    
    // http://www.rapidtables.com/convert/color/rgb-to-cmyk.htm
    public class func rgbaToCMYKA(rgba: RGBA) -> CMYKA {
        // Let's use almostOne so we don't end up with NaN
        let almostOne = CGFloat(1.00000000000001)
        let black = 1 - max(rgba.red, rgba.green, rgba.blue)
        let cyan =  (1.0 - rgba.red - black) / (almostOne - black)
        let magenta =  (1.0 - rgba.green - black) / (almostOne - black)
        let yellow =  (1.0 - rgba.blue - black) / (almostOne - black)
        return CMYKA(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: rgba.alpha)
    }
    
    public class func rgbaToHSBA(rgba: RGBA) -> HSBA {
        let color = UIColor(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: 1.0)
        let hsba = color.hsba()
        return hsba
    }
    
    // http://www.pcmag.com/encyclopedia/term/55166/yuv-rgb-conversion-formulas
    public class func rgbaToYUVA(rgba: RGBA) -> YUVA {
        let y = 0.299 * rgba.red + 0.587 * rgba.green + 0.114 * rgba.blue
        let u = 0.492 * (rgba.blue - y)
        let v = 0.877 * (rgba.red - y)
        let yuva = YUVA(y: y, u: u, v: v, alpha: rgba.alpha)
        return yuva
    }
    
}









