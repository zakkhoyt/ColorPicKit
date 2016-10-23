//
//  YUVSpectrum.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


private let invalidPositionValue = CGFloat(-1.0)

@IBDesignable public class YUVSpectrum: UIControl, PositionableControl, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = false
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            if _roundedCornders == false {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 0
            } else {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 40.0
            }
        }
    }
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    private var _borderWidth: CGFloat = 0
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            self.layer.borderWidth = newValue
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
    
    private var _color: UIColor = .white
    /* @IBInspectable */ public var color: UIColor {
        get {
            let invertedPoint = CGPoint(x: position.x, y: bounds.height - position.y)
            let rgb = spectrumView.colorForPoint(invertedPoint)
            return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
        }
    }
    
    
    
    
    private var spectrumView: YUVSpectrumView = YUVSpectrumView()
    
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
        
        self.roundedCorners = _roundedCornders
        self.borderWidth = _borderWidth
        self.borderColor = _borderColor
        
        // SpectrumView
        spectrumView.borderWidth = borderWidth
        spectrumView.borderColor = borderColor
        addSubview(spectrumView)
        
        
        // KnobView
        updateKnobSize()
        addSubview(knobView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // Spectrum View
        spectrumView.frame = self.bounds
        
        
        // Position
        if position.x == invalidPositionValue || position.y == invalidPositionValue {
            position = CGPoint(x: spectrumView.frame.midX, y: spectrumView.frame.midY)
        }
        
        // KnobView
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
        let spectrumFrame = spectrumView.frame
        
        var mPoint = point
        if mPoint.x < spectrumFrame.origin.x {
            mPoint.x = spectrumFrame.origin.x
        }
        
        if mPoint.x > spectrumFrame.origin.x + spectrumFrame.size.width - 1.0 {
            mPoint.x = spectrumFrame.origin.x + spectrumFrame.size.width - 1.0
        }
        
        if mPoint.y < spectrumFrame.origin.y {
            mPoint.y = spectrumFrame.origin.y
        }
        
        if mPoint.y > spectrumFrame.origin.y + spectrumFrame.size.height - 1.0 {
            mPoint.y = spectrumFrame.origin.y + spectrumFrame.size.height - 1.0
        }
        //print("point: \(point) mPoint: \(mPoint)")
        _position = mPoint
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

