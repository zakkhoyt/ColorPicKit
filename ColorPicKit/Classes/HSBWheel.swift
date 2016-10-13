//
//  HSBWheel.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


private let invalidPositionValue = CGFloat(-1.0)
@IBDesignable public class HSBWheel: UIControl, PositionableControl, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
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
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            if _borderColor != newValue {
                _borderColor = newValue
                self.layer.borderColor = newValue.cgColor
                knobView.borderColor = newValue
            }
        }
    }
    
    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            if _borderWidth != newValue {
                _borderWidth = newValue
                self.layer.borderWidth = newValue
                knobView.borderWidth = newValue
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: bounds.width)
        }
    }
    
    private var _knobView: KnobView = KnobView()
    public var knobView: KnobView {
        get {
            return _knobView
        }
        set {
            _knobView = newValue
            updateKnob()
        }
    }
    
    private var _knobSize: CGSize = CGSize(width: 30, height: 30)
    @IBInspectable public var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            _knobSize = newValue
            updateKnob()
        }
    }
    
    private var _color: UIColor = .white
    @IBInspectable public var color: UIColor {
        get {
            let invertedPoint = CGPoint(x: position.x, y: bounds.height - position.y)
            let rgb = wheelView.colorForPoint(invertedPoint)
            return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
        }
        set {
            if _color != newValue {
                _color = newValue
                updateKnob()
            }

        }
    }
    
    private var _brightnessDate = Date(timeInterval: -1000, since: Date())
    private var _brightness: CGFloat = 1.0
    @IBInspectable public var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            // Throttle brightness changes as the cause the gradient to redraw
            let now = Date()
            if now.timeIntervalSince(_brightnessDate) > 0.1 {
                
                if _brightness != newValue {
                    _brightness = newValue
                    wheelView.brightness = newValue
                    updateKnob()
                }

                _brightnessDate = now
            }
        }
    }
    
    
    private var _position: CGPoint = CGPoint(x: invalidPositionValue, y: invalidPositionValue)
    @IBInspectable public var position: CGPoint {
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
    
    override public init(frame: CGRect) {
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
        let frame = CGRect(x: 0, y: 0, width: self.intrinsicContentSize.width, height: self.intrinsicContentSize.height)
        wheelView.frame = frame
//        wheelView.frame = self.bounds
        wheelView.setNeedsLayout()

        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        addSubview(knobView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Spectrum View
        wheelView.frame = self.bounds
        wheelView.setNeedsLayout()
        
        
        // Position
        if position.x == invalidPositionValue || position.y == invalidPositionValue {
            position = self.center
        }

        // KnobView
        self.updateKnob()
        
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
            if point == center {
                _position = point
                return
            }
            
            let vec = CGPoint(x: point.x - center.x, y: point.y - center.y)
            let extents = sqrt((vec.x * vec.x) + (vec.y * vec.y))
            
            let x = vec.x / extents;
            let y = vec.y /  extents;
            let vec2 = CGPoint(x: x, y: y)
            
            let newPosition = CGPoint(x: center.x + vec2.x * wheelView.radius, y: center.y + vec2.y * wheelView.radius)
            // We don't want to accept infinities or NaN
            if fabs(newPosition.x) == CGFloat.infinity ||
                fabs(newPosition.y) == CGFloat.infinity {
                print("Will not set position to infinity: \(newPosition)")
                return
            }
            if newPosition.x == CGFloat.nan || newPosition.y == CGFloat.nan {
                print("Will not set position to NaN: \(newPosition)")
                return
            }

            
            _position = newPosition
            
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

