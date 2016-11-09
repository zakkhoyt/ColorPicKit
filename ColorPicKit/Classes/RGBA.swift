//
//  RGBA.swift
//  Throw
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



public struct RGBA {
    

    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    public var alpha: CGFloat
    
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = clip(red)
        self.green = clip(green)
        self.blue = clip(blue)
        self.alpha = clip(alpha)
    }
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    public func description() -> String {
        return "red: " + String(format: "%.2f", red) +
        "green: " + String(format: "%.2f", green) +
        "blue: " + String(format: "%.2f", blue) +
        "alpha: " + String(format: "%.2f", alpha)
    }

    
    public func color() -> UIColor {
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
    
    public static func colorWith(rgba: RGBA) -> UIColor {
        return rgba.color()
    }
    
}

extension RGBA: ColorString {
    
    public func stringFor(type: ColorStringType) -> String {
        
        let format = type.format()
        let factor = type.factor()
        
        if type == .baseOne {
            let redString = String(format: format, (red * factor))
            let greenString = String(format: format, (green * factor))
            let blueString = String(format: format, (blue * factor))
            let alphaString = String(format: format, (alpha * factor))
            let rgbString = "RGBA: (\(redString), \(greenString), \(blueString), \(alphaString))"
            return rgbString
        } else {
            let redString = String(format: format, Int(red * factor))
            let greenString = String(format: format, Int(green * factor))
            let blueString = String(format: format, Int(blue * factor))
            let alphaString = String(format: format, Int(alpha * factor))
            let rgbString = "RGBA: (\(redString), \(greenString), \(blueString), \(alphaString))"
            return rgbString
        }
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
    

    public class func rgbaToHSLA(rgba: RGBA) -> HSLA {


        // http://www.easyrgb.com/index.php?X=MATH
        // http://stackoverflow.com/questions/2353211/hsl-to-rgb-color-conversion
        
        let red = rgba.red
        let green = rgba.green
        let blue = rgba.blue
        let alpha = rgba.alpha
        
        let rgbMin = min( red, green, blue )
        let rgbMax = max( red, green, blue )
        let delta = rgbMax - rgbMin
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let lightness: CGFloat = ( rgbMax + rgbMin ) / 2
        
        
        if delta == 0 {
            hue = 0
            saturation = 0
        } else {
            if lightness < 0.5 {
                saturation = delta / ( rgbMax + rgbMin )
            } else {
                saturation = delta / ( 2.0 - rgbMax - rgbMin )
            }
            
            let del_R = ( ( ( rgbMax - red ) / 6 ) + ( delta / 2 ) ) / delta
            let del_G = ( ( ( rgbMax - green ) / 6 ) + ( delta / 2 ) ) / delta
            let del_B = ( ( ( rgbMax - blue ) / 6 ) + ( delta / 2 ) ) / delta
            
            if red == rgbMax {
                hue = del_B - del_G
            } else if green == rgbMax {
                hue = ( 1 / 3 ) + del_R - del_B
            } else if blue == rgbMax {
                hue = ( 2 / 3 ) + del_G - del_R
            }
            
            if hue < 0 {
                hue += 1
            }
            if hue > 1 {
                hue -= 1
            }
        }
        return HSLA(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
    }
    
    
    public class func rgbaToYUVA(rgba: RGBA) -> YUVA {
        // http://www.pcmag.com/encyclopedia/term/55166/yuv-rgb-conversion-formulas
        // http://www.equasys.de/colorconversion.html
        
//        // Multiply matrices
//        let y = rgba.red * 0.299 + rgba.green * 0.587 + rgba.blue * 0.114
//        let u = rgba.red * -0.147 + rgba.green * -0.289 + rgba.blue * 0.436 + 0.5
//        let v = rgba.red * 0.615 + rgba.green * -0.515 + rgba.blue * -0.100 + 0.5
//        let yuva = YUVA(y: y, u: u, v: v, alpha: rgba.alpha)
//        return yuva
        
        //        // https://en.wikipedia.org/wiki/YCbCr
        //        // YPbPr
        //        // Multiply matrices
        //        let y = rgba.red * 0.299 +      rgba.green * 0.587 +        rgba.blue * 0.114      // 0.0 ... 1.0
        //        let u = rgba.red * -0.168736 +  rgba.green * -0.331264 +    rgba.blue * 0.5        // 0.0 ... 1.0
        //        var v = rgba.red * 0.5 +        rgba.green * -0.418688 +    rgba.blue * -0.081312  // -0.5 ... 0.5
        //        v = v + 0.5
        //        let yuva = YUVA(y: y, u: u, v: v, alpha: rgba.alpha)
        //        return yuva

        
        // https://en.wikipedia.org/wiki/YCbCr
        // YPbPr
        // Multiply matrices
        let y = rgba.red * 0.299 +      rgba.green * 0.587 +        rgba.blue * 0.114                 // 0.0 ... 1.0
        let u = (rgba.red * -0.168736 +  rgba.green * -0.331264 +    rgba.blue * 0.5) + 0.5         // 0.0 ... 1.0
        let v = (rgba.red * 0.5 +        rgba.green * -0.418688 +    rgba.blue * -0.081312) + 0.5   // -0.5 ... 0.5
        let yuva = YUVA(y: y, u: u, v: v, alpha: rgba.alpha)
        return yuva


        
    }
    
}

extension UIImage {
    public func rgbaPixels() -> [RGBA] {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let length = CFDataGetLength(pixelData)
        let bytesPerRow = Int(length / Int(size.height))
        
        var pixels = [RGBA]()
        for y in 0 ..< Int(size.width) {
            for x in 0 ..< Int(size.height) {
                let index = y * bytesPerRow + x * 4
                
                if index < 0 {
                    print("Error: index out of bounds")
                    break
                } else if index > Int(Int(size.width) * Int(size.height) * 4) {
                    print("Error: index out of bounds")
                    break
                }
                
                //        print("w:\(Int(size.width)) h:\(Int(size.height))")
                //        print("x:\(Int(point.x)) y:\(Int(point.y)) index:\(index)")
                let blue = CGFloat(data[index]) / CGFloat(255.0)
                let green = CGFloat(data[index+1]) / CGFloat(255.0)
                let red = CGFloat(data[index+2]) / CGFloat(255.0)
                let alpha = CGFloat(data[index+3]) / CGFloat(255.0)
                
                let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
                pixels.append(rgba)
            }
        }
        
        return pixels
    }
}







