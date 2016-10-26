//
//  HSLSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



@IBDesignable public class HSLSliderGroup: UIControl, SliderControlGroup, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                hueSlider.roundedCorners = roundedCorners
                saturationSlider.roundedCorners = roundedCorners
                lightnessSlider.roundedCorners = roundedCorners
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
                hueSlider.borderColor = newValue
                saturationSlider.borderColor = newValue
                lightnessSlider.borderColor = newValue
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
                hueSlider.borderWidth = newValue
                saturationSlider.borderWidth = newValue
                lightnessSlider.borderWidth = newValue
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
                hueSlider.barHeight = newValue
                saturationSlider.barHeight = newValue
                lightnessSlider.barHeight = newValue
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
                hueSlider.knobSize = newValue
                saturationSlider.knobSize = newValue
                lightnessSlider.knobSize = newValue
            }
        }
    }
    
    
    @IBInspectable public var color: UIColor {
        get {
            let hue = hueSlider.value
            let saturation = saturationSlider.value
            let lightness = lightnessSlider.value
            let hsla = HSLA(hue: hue, saturation: saturation, lightness: lightness)
            return hsla.color()
        }
        set {
            let hsla = newValue.hsla()
            hueSlider.value = hsla.hue
            saturationSlider.value = hsla.saturation
            lightnessSlider.value = hsla.lightness
            updateSliderColors()
        }
    }
    
    
    private let spacing: CGFloat = 20
    private let sliderHeight: CGFloat = 20
    
    
    private var hueSlider = HueSlider()
    private var saturationSlider = GradientSlider()
    private var lightnessSlider = GradientSlider()
    
    
    
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
        
        let hsla = color.hsla()
        
        hueSlider.roundedCorners = roundedCorners
        hueSlider.borderColor = borderColor
        hueSlider.borderWidth = borderWidth
        hueSlider.barHeight = barHeight
        hueSlider.knobSize = knobSize
        hueSlider.value = hsla.hue
        hueSlider.addTarget(self, action: #selector(hueSliderValueChanged), for: .valueChanged)
        hueSlider.addTarget(self, action: #selector(hueSliderTouchDown), for: .touchDown)
        hueSlider.addTarget(self, action: #selector(hueSliderTouchUpInside), for: .touchUpInside)
        addSubview(hueSlider)
        
        saturationSlider.roundedCorners = roundedCorners
        saturationSlider.borderColor = borderColor
        saturationSlider.borderWidth = borderWidth
        saturationSlider.barHeight = barHeight
        saturationSlider.knobSize = knobSize
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsla.saturation
        saturationSlider.addTarget(self, action: #selector(saturationSliderValueChanged), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(saturationSliderTouchDown), for: .touchDown)
        saturationSlider.addTarget(self, action: #selector(saturationSliderTouchUpInside), for: .touchUpInside)
        addSubview(saturationSlider)
        
        
        lightnessSlider.roundedCorners = roundedCorners
        lightnessSlider.borderColor = borderColor
        lightnessSlider.borderWidth = borderWidth
        lightnessSlider.barHeight = barHeight
        lightnessSlider.knobSize = knobSize
        lightnessSlider.color1 = UIColor.white
        lightnessSlider.color2 = UIColor.black
        lightnessSlider.value = hsla.lightness
        lightnessSlider.addTarget(self, action: #selector(lightnessSliderValueChanged), for: .valueChanged)
        lightnessSlider.addTarget(self, action: #selector(lightnessSliderTouchDown), for: .touchDown)
        lightnessSlider.addTarget(self, action: #selector(lightnessSliderTouchUpInside), for: .touchUpInside)
        addSubview(lightnessSlider)
        
        
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(0 * sliderHeight + 1 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            hueSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(1 * sliderHeight + 2 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            saturationSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(2 * sliderHeight + 3 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            lightnessSlider.frame = frame
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
        let hue = hueSlider.value
        let saturation = saturationSlider.value
        let lightness = lightnessSlider.value
        
        let hsla = HSLA(hue: hue, saturation: saturation, lightness: lightness)
        let color = hsla.color()
        
        saturationSlider.color2 = color
        lightnessSlider.color2 = color
        
        hueSlider.saturation = saturation
        hueSlider.brightness = lightness
    }
    
    // MARK: IBActions
    func hueSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func hueSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func hueSliderTouchUpInside(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchUpInside()
    }
    
    
    func saturationSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func saturationSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func saturationSliderTouchUpInside(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchUpInside()
    }
    
    
    func lightnessSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func lightnessSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func lightnessSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
}
