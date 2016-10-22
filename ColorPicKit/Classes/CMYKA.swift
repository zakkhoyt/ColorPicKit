//
//  CMYKA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public struct CMYKA {
    var cyan: CGFloat
    var magenta: CGFloat
    var yellow: CGFloat
    var black: CGFloat
    var alpha: CGFloat
    

    init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat) {
        self.cyan = cyan
        self.magenta = magenta
        self.yellow = yellow
        self.black = black
        self.alpha = alpha
    }
    
    init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
        self.cyan = cyan
        self.magenta = magenta
        self.yellow = yellow
        self.black = black
        self.alpha = 1.0
    }
    
    public func color() -> UIColor {
        let rgba = UIColor.cmykaToRGBA(cmyka: self)
        return rgba.color()
    }
    
    // MARK: Converstions
    public func rgba() -> RGBA {
        return UIColor.cmykaToRGBA(cmyka: self)
    }
    
    
    public func hsba() -> HSBA {
        return UIColor.cmykaToHSBA(cmyka: self)
    }
    
    // MARK: Static functions
    static func colorWith(cmyka: CMYKA) -> UIColor {
        return cmyka.color()
    }
    
    
}



extension UIColor {
    
    
    
    // MARK: UIColor to self
    public func cmyka() -> CMYKA {
        let rgba = self.rgba()
        return UIColor.rgbaToCMYKA(rgba: rgba)
    }
    
    
    
    // MARK: constructors
    
    public convenience init(cmyka: CMYKA, alpha: CGFloat = 1.0) {
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
    }
    
    public class func colorWith(cmyka: CMYKA) -> UIColor {
        return cmyka.color()
    }
    
    
    public class func colorWith(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat) -> UIColor {
        let cmyka = CMYKA(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha)
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        return UIColor.colorWith(rgba: rgba)
    }

    
    
    // http://www.rapidtables.com/convert/color/cmyk-to-rgb.htm
    public class func cmykaToRGBA(cmyka: CMYKA) -> RGBA {
        let red = (1.0 - cmyka.cyan) * (1.0 - cmyka.black)
        let green = (1.0 - cmyka.magenta) * (1.0 - cmyka.black)
        let blue = (1.0 - cmyka.yellow) * (1.0 - cmyka.black)
        return RGBA(red: red, green: green, blue: blue, alpha: cmyka.alpha)
    }
    
    
    public class func cmykaToHSBA(cmyka: CMYKA) -> HSBA {
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        let color = UIColor(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
        let hsba = color.hsba()
        return hsba
    }
}
