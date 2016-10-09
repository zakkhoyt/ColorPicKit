//
//  HueSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class HueSlider: UIControl, SliderControl, Colorable {
    
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            hueView.roundedCorners = newValue
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
            hueView.borderColor = newValue
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
            hueView.borderWidth = newValue
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
            _knobView = newValue
            updateKnob()
        }
    }
    
    private var _knobSize: CGSize = CGSize(width: 30, height: 30)
    @IBInspectable var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            _knobSize = newValue
            updateKnob()
        }
    }
    
    
    private var _value: CGFloat = 0.5
    @IBInspectable var value: CGFloat {
        get {
            return _value
        }
        set {
            _value = newValue
            updateKnob()
        }
    }
    
    private var _saturation: CGFloat = 1.0
    @IBInspectable open var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                hueView.saturation = newValue
            }
        }
    }
    
    private var _brightness: CGFloat = 1.0
    @IBInspectable open var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            if _brightness != newValue {
                _brightness = newValue
                hueView.brightness = newValue
            }
        }
    }
    
    var color: UIColor {
        get {
            let hue = value
            let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            return color
        }
    }
    
    private var hueView = HueView()
    
    
    // MARK: Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        
        hueView.borderColor = borderColor
        hueView.borderWidth = borderWidth
        hueView.roundedCorners = roundedCorners
        addSubview(hueView)
        
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        addSubview(knobView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        hueView.frame = self.bounds
        updateKnob()
    }
    
    
    // MARK: Touches
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        touchDown()
        
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        touchUpInside()
    }
    
    private func touchesHappened(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self){
            updateValueWith(point: point)
            updateKnob()
            valueChanged()
        }
    }
    
    func touchDown() {
        self.sendActions(for: .touchDown)
    }
    
    func touchUpInside() {
        self.sendActions(for: .touchUpInside)
    }
    
    func valueChanged() {
        self.sendActions(for: .valueChanged)
    }
    
    // MARK: Private methods
    private func updateValueWith(point: CGPoint) {
        var x = point.x
        if x < 0 {
            x = 0
        }
        if x > bounds.width {
            x = bounds.width
        }
        self.value = x / bounds.width
        
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
        knobView.borderColor = color
    }
    
    
}
