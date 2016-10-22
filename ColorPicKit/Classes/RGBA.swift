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
    
    public func hsla() -> HSLA {
        return UIColor.rgbaToHSLA(rgba: self)   
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
    
    // http://www.easyrgb.com/index.php?X=MATH
    public class func rgbaToHSLA(rgba: RGBA) -> HSLA {

        
        let var_R = rgba.red
        let var_G = rgba.green
        let var_B = rgba.blue
        
        
        let var_Min = min(var_R, var_G, var_B)
        let var_Max = max(var_R, var_G, var_B)
        let del_Max = var_Max - var_Min

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let lightness: CGFloat = (var_Max + var_Min) / 2.0

        
        if del_Max == 0 {
            hue = 0
            saturation = 0
        } else {
            if lightness < 0.5 {
                saturation = del_Max / (var_Max + var_Min)
            } else {
                saturation = del_Max / (2.0 - var_Max - var_Min)
            }
            
            let del_R = (((var_Max - var_R ) / 6.0 ) + (del_Max / 2.0)) / del_Max
            let del_G =  (((var_Max - var_G) / 6.0) + (del_Max / 2.0)) / del_Max
            let del_B = (((var_Max - var_B) / 6.0) + (del_Max / 2.0)) / del_Max
            
            
            if var_R == var_Max {
                hue = del_B - del_G
            } else if var_G == var_Max {
                hue = (1.0 / 3.0) + del_R - del_B
            } else if var_B == var_Max {
                hue = (2.0 / 3.0) + del_G - del_R
            }
            
            if hue < 0 {
                hue += 1.0
            }
            
            if hue > 1.0 {
                hue -= 1.0
            }
        }
        
        return HSLA(hue: hue, saturation: saturation, lightness: lightness, alpha: rgba.alpha)
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









