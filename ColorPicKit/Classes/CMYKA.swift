//
//  CMYKA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public struct CMYKA {
    public var cyan: CGFloat
    public var magenta: CGFloat
    public var yellow: CGFloat
    public var black: CGFloat
    public var alpha: CGFloat
    

    public init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat) {
        self.cyan = clip(cyan)
        self.magenta = clip(magenta)
        self.yellow = clip(yellow)
        self.black = clip(black)
        self.alpha = clip(alpha)
    }
    
    public init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
        self.init(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: 1.0)
    }
    
    public func description() -> String {
        return "cyan: " + String(format: "%.2f", cyan) +
            "magenta: " + String(format: "%.2f", magenta) +
            "yellow: " + String(format: "%.2f", yellow) +
            "black: " + String(format: "%.2f", black) +
            "alpha: " + String(format: "%.2f", alpha)
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
    
    public func hsla() -> HSLA {
        let rgba = UIColor.cmykaToRGBA(cmyka: self)
        let hsla = UIColor.rgbaToHSLA(rgba: rgba)
        return hsla
    }
    
    // MARK: Static functions
    public static func colorWith(cmyka: CMYKA) -> UIColor {
        return cmyka.color()
    }
    
    
}


extension CMYKA: ColorString {
    
    public func stringFor(type: ColorStringType) -> String {
        
        let format = type.format()
        let factor = type.factor()
        
        if type == .baseOne {
            let cyanString = String(format: format, (cyan * factor))
            let magentaString = String(format: format, (magenta * factor))
            let yellowString = String(format: format, (yellow * factor))
            let blackString = String(format: format, (black * factor))
            let alphaString = String(format: format, (alpha * factor))
            let cmykaString = "CMYKA: (\(cyanString), \(magentaString), \(yellowString), \(blackString), \(alphaString))"
            return cmykaString
        } else {
            let cyanString = String(format: format, Int(cyan * factor))
            let magentaString = String(format: format, Int(magenta * factor))
            let yellowString = String(format: format, Int(yellow * factor))
            let blackString = String(format: format, Int(black * factor))
            let alphaString = String(format: format, Int(alpha * factor))
            let cmykaString = "CMYKA: (\(cyanString), \(magentaString), \(yellowString), \(blackString), \(alphaString))"
            return cmykaString
        }
    }
}

public extension UIColor {
    
    
    
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
    
    public class func cmykaToHSLA(cmyka: CMYKA) -> HSLA {
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        let hsla = UIColor.rgbaToHSLA(rgba: rgba)
        return hsla
    }
    
    public class func cmykaToYUVA(cmyka: CMYKA) -> YUVA {
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        let yuva = UIColor.rgbaToYUVA(rgba: rgba)
        return yuva
    }
}

extension UIImage {
    public func cmykaPixels() -> [CMYKA] {
        var pixels = [CMYKA]()
        for rgba in self.rgbaPixels() {
            let cmyka = rgba.cmyka()
            pixels.append(cmyka)
        }
        return pixels
    }
}

