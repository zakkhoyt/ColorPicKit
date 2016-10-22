//
//  GradientView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class GradientView: UIView {
 
    
    private var _roundedCornders: Bool = false
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            setNeedsDisplay()
        }
    }
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            layer.borderColor = newValue.cgColor
            setNeedsDisplay()
        }
    }
    
    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            layer.borderWidth = newValue
            setNeedsDisplay()
        }
    }
    
    
    private var _color1: UIColor = .black
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
    }

    
    
    
    override public func draw(_ rect: CGRect) {
        
        backgroundColor = UIColor.clear
        
        // Round corners
        if roundedCorners {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = bounds.midY
        } else {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 0
        }
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        
        guard let context = UIGraphicsGetCurrentContext() else {
            print("No Context")
            return
        }
        
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
