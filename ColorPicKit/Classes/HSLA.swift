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
    
    
    init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.lightness = lightness
        self.alpha = alpha
    }
    
    
    init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.lightness = lightness
        self.alpha = 1.0
    }
    
    public func color() -> UIColor {
        let rgba = self.rgba()
        let color = UIColor(rgba: rgba)
        return color
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
    
    static func colorWith(hsla: HSLA) -> UIColor {
        return hsla.color()
    }
    
}

extension UIColor {
    
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
    //    public class func colorWith(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat) -> UIColor {
    //        let hsla = HSLA(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
    //        return hsla.color()
    //    }
    
    
    // MARK: conversions
    
    // http://www.easyrgb.com/index.php?X=MATH
    public class func hslaToRGBA(hsla: HSLA) -> RGBA {
        func hueToRGB(v1: CGFloat, v2: CGFloat, h: CGFloat) -> CGFloat {
            var vH = h
            
            if vH < 0 {
                vH += 1
            }
            if vH > 1  {
                vH -= 1
            }
            if ( 6 * vH ) < 1 {
                return ( v1 + ( v2 - v1 ) * 6 * vH )
            }
            if ( 2 * vH ) < 1 {
                return ( v2 )
            }
            if ( 3 * vH ) < 2 {
                return ( v1 + ( v2 - v1 ) * ( ( 2 / 3 ) - vH ) * 6 )
            }

            
            return v1
            
        }
        
        let hue = hsla.hue
        let saturation = hsla.saturation
        let lightness = hsla.lightness
        let alpha = hsla.alpha
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        
        
        if hsla.saturation == 0 {
            red = hsla.lightness
            green = hsla.lightness
            blue = hsla.lightness
        } else {
            
            var var_2: CGFloat = 0
            
            if hsla.lightness < 0.5 {
                var_2 = lightness * ( 1.0 + saturation )
            } else {
                var_2 = ( lightness + saturation ) - ( saturation * lightness )
            }
            let var_1 = 2.0 * lightness - var_2
            
            red = hueToRGB(v1: var_1, v2: var_2, h: hue + ( 1.0 / 3.0 ))
            green = hueToRGB(v1: var_1, v2: var_2, h: hue)
            blue = hueToRGB(v1: var_1, v2: var_2, h: hue - ( 1.0 / 3.0 ))
            
        }
        
        let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
        return rgba

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
