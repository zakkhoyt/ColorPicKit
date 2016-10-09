//
//  HSBWheel.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


private let invalidPositionValue = CGFloat(-1.0)
@IBDesignable public class HSBWheel: UIControl, KnobbedControl, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                if _roundedCornders == false {
                    self.layer.masksToBounds = false
                    self.layer.cornerRadius = 0
                } else {
                    self.layer.masksToBounds = true
                    self.layer.cornerRadius = 8.0
                }
            }
        }
    }
    
    private var _borderColor: UIColor = .darkGray
    @IBInspectable var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            if _borderColor != newValue {
                _borderColor = newValue
                self.layer.borderColor = newValue.cgColor
            }
        }
    }
    
    private var _borderWidth: CGFloat = 1.0
    @IBInspectable var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            if _borderWidth != newValue {
                _borderWidth = newValue
                self.layer.borderWidth = newValue
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: bounds.width)
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
    
    private var _knobSize: CGSize = CGSize(width: 90, height: 90)
    @IBInspectable var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            _knobSize = newValue
            updateKnob()
        }
    }
    
    private var _color: UIColor = .white
    @IBInspectable var color: UIColor {
        get {
            let invertedPoint = CGPoint(x: position.x, y: bounds.height - position.y)
            let rgb = wheelView.colorForPoint(invertedPoint)
//            let rgb = wheelView.colorForPoint(position)
            return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
        }
        set {
            if _color != newValue {
                _color = newValue
                updateKnob()
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
                wheelView.brightness = newValue
                updateKnob()
            }
        }
    }
    
    
    private var _position: CGPoint = CGPoint(x: invalidPositionValue, y: invalidPositionValue)
    @IBInspectable var position: CGPoint {
        get {
            return _position
        }
        set {
            // We don't want to accept infinities or NaN
            if fabs(newValue.x) == CGFloat.infinity ||
                fabs(newValue.y) == CGFloat.infinity {
                return
            }
            if newValue.x == CGFloat.nan || newValue.y == CGFloat.nan {
                return
            }
            
            if _position != newValue {
                updatePositionFrom(point: newValue)
                updateKnob()
            }
        }
    }
    
    
    private var wheelView: HSBWheelView = HSBWheelView()
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
        
        // SpectrumView
        wheelView.borderWidth = borderWidth
        wheelView.borderColor = borderColor
        addSubview(wheelView)
        
        
        // KnobView
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        updateKnobSize()
        addSubview(knobView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Spectrum View
        wheelView.frame = self.bounds
        
        
        // Position
        if position.x == invalidPositionValue || position.y == invalidPositionValue {
            position = CGPoint(x: wheelView.frame.midX, y: wheelView.frame.midY)
        }
        
        // KnobView
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        updateKnob()
    }
    
    
    
    // MARK: Touches
    
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
            updatePositionFrom(point: point)
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
    
    private func updatePositionFrom(point: CGPoint) {
        
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        // Check if the touch is outside the wheel
        if wheelView.pointDistance(center, point) < wheelView.radius {
            _position = point
        } else {
            let vec = CGPoint(x: point.x - center.x, y: point.y - center.y)
            let extents = sqrt((vec.x * vec.x) + (vec.y * vec.y))
            
            let x = vec.x / extents;
            let y = vec.y /  extents;
            let vec2 = CGPoint(x: x, y: y)
            _position = CGPoint(x: center.x + vec2.x * wheelView.radius, y: center.y + vec2.y * wheelView.radius)
            
        }
    }
    
    
    private func updateKnob() {
        updateKnobSize()
        updateKnobPosition()
        updateKnobColor()
    }
    
    private func updateKnobSize() {
        let center = knobView.center
        knobView.bounds = CGRect(x: 0, y: 0, width: knobSize.width, height: knobSize.height)
        knobView.center = center
    }
    
    private func updateKnobPosition() {
        knobView.center = position
    }
    
    private func updateKnobColor() {
        knobView.color = color
    }
    
}

