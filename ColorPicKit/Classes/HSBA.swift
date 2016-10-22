//
//  HSBA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


public struct HSBA {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var alpha: CGFloat
    

    init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }

    
    init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = 1.0
    }
    
    public func color() -> UIColor {
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        return color
    }
    
    // MARK: Converstions
    
    public func rgba() -> RGBA {
        return UIColor.hsbaToRGBA(hsba: self)
    }
    
    
    public func cmyka() -> CMYKA {
        return UIColor.hsbaToCMYKA(hsba: self)
    }
    
    public func yuva() -> YUVA {
        return UIColor.hsbaToYUVA(hsba: self)
    }
    
    // MARK: Static functions
    
    static func colorWith(hsba: HSBA) -> UIColor {
        return hsba.color()
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
