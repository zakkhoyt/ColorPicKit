//
//  GradientSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class GradientSlider: UIControl, SliderControl, Colorable {
    
    private var _roundedCornders: Bool = false
    @IBInspectable var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            
        }
    }
    
    private var _borderColor: UIColor = .darkGray
    @IBInspectable var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            knobView.borderColor = newValue
        }
    }

    private var _borderWidth: CGFloat = 1.0
    @IBInspectable var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            knobView.borderWidth = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: 20)
        }
    }
    
    private var _knobView: KnobView = KnobView()
    var knobView: KnobView {
        get {
            return _knobView
        }
        set {
            
        }
    }

    private var _knobSize: CGSize = CGSize(width: 30, height: 30)
    var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            
        }
    }


    private var _value: CGFloat = 0.0
    var value: CGFloat {
        get {
            return _value
        }
        set {
            _value = newValue
        }
    }
    
    var color: UIColor {
        get {
            // TODO
            return UIColor.red
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
    

    
    func touchDown() {
        assert(false)
    }
    
    func touchUpInside() {
        assert(false)
    }
    
    func valueChanged() {
        assert(false)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor.clear
//        // Create gradient view
//        if gradientView == nil {
//            let frame = bounds
//            let gradientView = GradientSliderGradientView(frame: frame)
//            gradientView.color1 = color1
//            gradientView.color2 = color2
//            gradientView.borderColor = borderColor
//            gradientView.borderWidth = borderWidth
//            gradientView.roundedCorners = roundedCorners
//            addSubview(gradientView)
//            self.gradientView = gradientView
//        }
        
        
//        // Create knob view
//        if knobView == nil {
//            let width = bounds.height * 1.5
//            let frame = CGRect(x: 0, y: 0, width: width, height: width)
//            let knobView = ColorKnobView(frame: frame)
//            
//            let x = value * bounds.width
//            knobView.center = CGPoint(x: x, y:  bounds.midY)
//            knobView.borderWidth = borderWidth
//            addSubview(knobView)
//            self.knobView = knobView
//        }
        
        updateKnob()
        addSubview(knobView)
    }
    
    
    private func updateKnob() {
        updateKnobPosition()
        updateKnobColor()
    }
    
    private func updateKnobPosition() {
        let x = value * bounds.width
        knobView.bounds = CGRect(x: 0, y: 0, width: knobSize.width, height: knobSize.height)
        knobView.center = CGPoint(x: x, y:  bounds.midY)
    }
    
    private func updateKnobColor() {
        knobView.color = interpolateColor(percent: value)
    }
    
    override public func draw(_ rect: CGRect) {
        
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
        
        let rgb1 = color1.rgb()
        let rgb2 = color2.rgb()
        let colors: [CGFloat] = [
            CGFloat(rgb1.red), CGFloat(rgb1.green), CGFloat(rgb1.blue), 1.0,
            CGFloat(rgb2.red), CGFloat(rgb2.green), CGFloat(rgb2.blue), 1.0,
            ]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2) else {
            print("No gradient")
            return
        }
        
        let rect = self.bounds
        context.saveGState()
        context.addRect(rect)
        context.clip()
        
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        context.restoreGState()
        context.addRect(rect)
        context.drawPath(using: .stroke)
    }
 
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        self.sendActions(for: .touchDown)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        self.sendActions(for: .touchUpInside)
    }
    
    private func touchesHappened(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self){

            var x = max(0, point.x)
            x = min(bounds.width, point.x)
            self.value = x / bounds.width
        
            updateKnob()
            
//            let knobCenter = CGPoint(x: point.x, y: bounds.midY)
//            knobView.center = knobCenter
//            colorFromPoint(point: point)
        }
    }
    
    private func colorFromPoint(point: CGPoint) {
        let ratio = point.x / bounds.width
        let knobColor = interpolateColor(percent: ratio)
        knobView.borderColor = knobColor
        self.value = ratio
        self.sendActions(for: .valueChanged)
    }
    
    
    private func interpolateColor(percent: CGFloat) -> UIColor {
        
        let rgb1 = color1.rgb()
        let rgb2 = color2.rgb()
        
        
        let redDiff = rgb2.red - rgb1.red
        let red = rgb1.red  + redDiff * percent
        
        let greenDiff = rgb2.green - rgb1.green
        let green = rgb1.green  + greenDiff * percent
        
        let blueDiff = rgb2.blue - rgb1.blue
        let blue = rgb1.blue  + blueDiff * percent
        
        //print("red: \(red) green: \(green) blue: \(blue)")
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    
    
    
}
