//
//  YUVSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class YUVSliderGroup: UIControl, SliderControlGroup, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                ySlider.roundedCorners = roundedCorners
                uSlider.roundedCorners = roundedCorners
                vSlider.roundedCorners = roundedCorners
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
                ySlider.borderColor = newValue
                uSlider.borderColor = newValue
                vSlider.borderColor = newValue
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
                ySlider.borderWidth = newValue
                uSlider.borderWidth = newValue
                vSlider.borderWidth = newValue
            }
            
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            let height = 4 * spacing + 3.0 * sliderHeight
            return CGSize(width: bounds.width, height: height)
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
                ySlider.barHeight = newValue
                uSlider.barHeight = newValue
                vSlider.barHeight = newValue
            }
        }
    }
    
    private var _knobSize: CGSize = CGSize(width: 30, height: 30)
    @IBInspectable public var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            if _knobSize != newValue {
                _knobSize = newValue
                ySlider.knobSize = newValue
                uSlider.knobSize = newValue
                vSlider.knobSize = newValue
            }
        }
    }
    
    
    @IBInspectable public var color: UIColor {
        get {
            let y = ySlider.value
            let u = uSlider.value
            let v = vSlider.value
            let yuva = YUVA(y: y, u: u, v: v)
            let color = UIColor(yuva: yuva)
            return color
        }
        set {
            let yuva = newValue.yuva()
            ySlider.value = yuva.y
            uSlider.value = yuva.u
            vSlider.value = yuva.v
            updateSliderColors()
        }
    }
    
    
    private let spacing: CGFloat = 20
    private let sliderHeight: CGFloat = 20
    
    
    private var ySlider = GradientSlider()
    private var uSlider = GradientSlider()
    private var vSlider = GradientSlider()
    
    
    
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
        
        let hsba = color.hsba()
        
        ySlider.roundedCorners = roundedCorners
        ySlider.borderColor = borderColor
        ySlider.borderWidth = borderWidth
        ySlider.barHeight = barHeight
        ySlider.knobSize = knobSize
        ySlider.color1 = UIColor.black
        ySlider.color2 = UIColor.white
        ySlider.value = hsba.saturation
        ySlider.addTarget(self, action: #selector(ySliderValueChanged), for: .valueChanged)
        ySlider.addTarget(self, action: #selector(ySliderTouchDown), for: .touchDown)
        ySlider.addTarget(self, action: #selector(ySliderTouchUpInside), for: .touchUpInside)
        addSubview(ySlider)
        
        uSlider.roundedCorners = roundedCorners
        uSlider.borderColor = borderColor
        uSlider.borderWidth = borderWidth
        uSlider.barHeight = barHeight
        uSlider.knobSize = knobSize
        uSlider.color1 = UIColor.black
        uSlider.color2 = UIColor.blue
        uSlider.value = hsba.saturation
        uSlider.addTarget(self, action: #selector(uSliderValueChanged), for: .valueChanged)
        uSlider.addTarget(self, action: #selector(uSliderTouchDown), for: .touchDown)
        uSlider.addTarget(self, action: #selector(uSliderTouchUpInside), for: .touchUpInside)
        addSubview(uSlider)
        
        
        vSlider.roundedCorners = roundedCorners
        vSlider.borderColor = borderColor
        vSlider.borderWidth = borderWidth
        vSlider.barHeight = barHeight
        vSlider.knobSize = knobSize
        vSlider.color1 = UIColor.white
        vSlider.color2 = UIColor.red
        vSlider.value = hsba.brightness
        vSlider.addTarget(self, action: #selector(vSliderValueChanged), for: .valueChanged)
        vSlider.addTarget(self, action: #selector(vSliderTouchDown), for: .touchDown)
        vSlider.addTarget(self, action: #selector(vSliderTouchUpInside), for: .touchUpInside)
        addSubview(vSlider)
        
        
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(0 * sliderHeight + 1 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            ySlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(1 * sliderHeight + 2 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            uSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(2 * sliderHeight + 3 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            vSlider.frame = frame
        }
        
    }
    
    // MARK: Private methods
    func touchDown() {
        self.sendActions(for: .touchDown)
    }
    
    func touchUpInside() {
        self.sendActions(for: .touchUpInside)
    }
    
    func valueChanged() {
        self.sendActions(for: .valueChanged)
    }
    
    
    private func updateSliderColors() {
//        let hue = ySlider.value
//        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
//        
//        ySlider.
//        uSlider.color2 = color
//        vSlider.color2 = color
//        
//        let saturation = uSlider.value
//        ySlider.saturation = saturation
//        
//        let brightness = vSlider.value
//        ySlider.brightness = brightness
    }
    
    // MARK: IBActions
    func ySliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func ySliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func ySliderTouchUpInside(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchUpInside()
    }
    
    
    func uSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func uSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func uSliderTouchUpInside(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchUpInside()
    }
    
    
    func vSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func vSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func vSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
}

