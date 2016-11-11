//
//  GradientSliderView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class GradientSliderView: SliderView {
 
    
    private var _color1: UIColor = .clear
    var color1: UIColor  {
        get {
            return _color1
        }
        set {
            _color1 = newValue
            setNeedsDisplay()
        }
    }
    
    private var _color2: UIColor = .white
    var color2: UIColor {
        get {
            return _color2
        }
        set {
            _color2 = newValue
            setNeedsDisplay()
        }
    }

    
    override func drawBackground(context: CGContext) {
        let rgba1 = color1.rgba()
        let rgba2 = color2.rgba()
        let colors: [CGFloat] = [
            CGFloat(rgba1.red), CGFloat(rgba1.green), CGFloat(rgba1.blue), 1.0,
            CGFloat(rgba2.red), CGFloat(rgba2.green), CGFloat(rgba2.blue), 1.0,
            ]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2) else {
            print("No gradient")
            return
        }
        
        let rect = self.bounds
        //        context.saveGState()
        context.addRect(rect)
        context.clip()
        
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        //        context.restoreGState()
        context.addRect(rect)
        context.drawPath(using: .stroke)
    }
}
