//
//  YUVA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public struct YUVA {
    
    
    
    
    
    var y: CGFloat // intensity
    var u: CGFloat // blue
    var v: CGFloat // red
    var alpha: CGFloat // alpha

    
    init(y: CGFloat, u: CGFloat, v: CGFloat, alpha: CGFloat) {
        self.y = y
        self.u = u
        self.v = v
        self.alpha = alpha
    }
    
    init(y: CGFloat, u: CGFloat, v: CGFloat) {
        self.y = y
        self.u = u
        self.v = v
        self.alpha = 1.0
    }
    
    public func color() -> UIColor {
        let rgba = UIColor.yuvaToRGBA(yuva: self)
        return rgba.color()
    }

    
    // MARK: Converstions
    public func rgba() -> RGBA {
        return UIColor.yuvaToRGBA(yuva: self)
    }
    
    
    public func hsba() -> HSBA {
        let rgba = UIColor.yuvaToRGBA(yuva: self)
        let hsba = UIColor.rgbaToHSBA(rgba: rgba)
        return hsba
    }
    
    public func cmyka() -> CMYKA {
        let rgba = UIColor.yuvaToRGBA(yuva: self)
        let cmyka = UIColor.rgbaToCMYKA(rgba: rgba)
        return cmyka
    }

    
    // MARK: Static functions
    static func colorWith(yuva: YUVA) -> UIColor {
        return yuva.color()
    }

    
    

    
}


extension UIColor {
    
    // MARK: self to struct
    
    public func yuva(alpha: CGFloat = 1.0) -> YUVA {
        let rgba = self.rgba()
        let yuva = UIColor.rgbaToYUVA(rgba: rgba)
        return yuva
    }
    
    
    // MARK: constructors
    
    public convenience init(yuva: YUVA, alpha: CGFloat = 1.0) {
        let rgba = UIColor.yuvaToRGBA(yuva: yuva)
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    
    public class func colorWith(yuva: YUVA) -> UIColor {
        return yuva.color()
    }
    
    public class func colorWith(y: CGFloat, u: CGFloat, v: CGFloat, alpha: CGFloat) -> UIColor {
        let yuva = YUVA(y: y, u: u, v: v, alpha: alpha)
        let rgba = UIColor.yuvaToRGBA(yuva: yuva)
        return rgba.color()
    }
    
    // http://www.pcmag.com/encyclopedia/term/55166/yuv-rgb-conversion-formulas
    public class func yuvaToRGBA(yuva: YUVA) -> RGBA {
        let red = yuva.y + 1.140 * yuva.v
        let green = yuva.y - 0.395 * yuva.u - 0.581 * yuva.v
        let blue = yuva.y + 2.032 * yuva.u
        let rgba = RGBA(red: red, green: green, blue: blue, alpha: yuva.alpha)
        return rgba
    }
    
    public class func yuvaToHSBA(yuva: YUVA) -> HSBA {
        let rgba = UIColor.yuvaToRGBA(yuva: yuva)
        let hsba = UIColor.rgbaToHSBA(rgba: rgba)
        return hsba
    }
    
    public class func yuvaToCMYKA(yuva: YUVA) -> CMYKA {
        let rgba = UIColor.yuvaToRGBA(yuva: yuva)
        let cmyka = UIColor.rgbaToCMYKA(rgba: rgba)
        return cmyka
    }

    
}
