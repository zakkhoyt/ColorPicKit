//
//  GradientSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class GradientSlider: UIControl, SliderControl, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            gradientView.roundedCorners = newValue
        }
    }
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            knobView.borderColor = newValue
            gradientView.borderColor = newValue
        }
    }

    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            knobView.borderWidth = newValue
            gradientView.borderWidth = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: 20)
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

    
    private var _barHeight: CGFloat = 10
    @IBInspectable public var barHeight: CGFloat {
        get {
            return _barHeight
        }
        set {
            if _barHeight != newValue {
                _barHeight = newValue
                layoutSubviews()
            }
        }
    }

    

    private var _value: CGFloat = 0.5
    
    @IBInspectable public var value: CGFloat {
        get {
            return _value
        }
        set {
            
            if _value != newValue {
                if newValue < 0 {
                    _value = 0
                } else if newValue > 1.0 {
                    _value = 1.0
                } else {
                    _value = newValue
                }
                updateKnob()
            }
        }
    }
    
    public var color: UIColor {
        get {
            return UIColor.interpolateAt(value: value, betweenColor1: color1, andColor2: color2)
        }
    }
 
    private var _color1: UIColor = .black
    @IBInspectable public var color1: UIColor  {
        get {
            return _color1
        }
        set {
            _color1 = newValue
            gradientView.color1 = newValue
            updateKnobColor()
        }
    }
    
    private var _color2: UIColor = .white
    @IBInspectable public var color2: UIColor {
        get {
            return _color2
        }
        set {
            _color2 = newValue
            gradientView.color2 = newValue
            updateKnobColor()
        }
    }
    
    
    private var gradientView: GradientView = GradientView()


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
        
        gradientView.borderColor = borderColor
        gradientView.borderWidth = borderWidth
        gradientView.roundedCorners = roundedCorners
        addSubview(gradientView)
        
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        addSubview(knobView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = frameForGradientView()
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
        knobView.color = UIColor.interpolateAt(value: value, betweenColor1: color1, andColor2: color2)
//        knobView.borderColor = UIColor.interpolateAt(value: value, betweenColor1: color1, andColor2: color2)
    }
    
    private func frameForGradientView() -> CGRect {
        let x: CGFloat = 0
        let y: CGFloat = (bounds.height - barHeight) / 2.0
        let w: CGFloat = bounds.width
        let h: CGFloat = barHeight
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    
}
