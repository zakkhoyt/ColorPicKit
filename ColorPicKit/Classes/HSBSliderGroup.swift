//
//  HSBSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



@IBDesignable public class HSBSliderGroup: UIControl, SliderControlGroup, Colorable {
    
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
                brightnessSlider.roundedCorners = roundedCorners
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
                brightnessSlider.borderColor = newValue
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
                brightnessSlider.borderWidth = newValue
            }
            
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            let height = 4 * spacing + 3.0 * sliderHeight
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    
    @IBInspectable public var color: UIColor {
        get {
            let hue = hueSlider.value
            let saturation = saturationSlider.value
            let brightness = brightnessSlider.value
            let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
            return color
        }
        set {
            let hsb = newValue.hsb()
            hueSlider.value = hsb.hue
            saturationSlider.value = hsb.saturation
            brightnessSlider.value = hsb.brightness
            updateSliderColors()
        }
    }
    
    
    private let spacing: CGFloat = 20
    private let sliderHeight: CGFloat = 20
    
    
    var sliders: [SliderControl] = [SliderControl]()
    private var hueSlider = HueSlider()
    private var saturationSlider = GradientSlider()
    private var brightnessSlider = GradientSlider()
    
    
    
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
        
        let hsb = color.hsb()
        
        hueSlider.roundedCorners = roundedCorners
        hueSlider.borderColor = borderColor
        hueSlider.borderWidth = borderWidth
        hueSlider.value = hsb.hue
        hueSlider.addTarget(self, action: #selector(hueSliderValueChanged), for: .valueChanged)
        hueSlider.addTarget(self, action: #selector(hueSliderTouchDown), for: .touchDown)
        hueSlider.addTarget(self, action: #selector(hueSliderTouchUpInside), for: .touchUpInside)
        addSubview(hueSlider)
        
        saturationSlider.roundedCorners = roundedCorners
        saturationSlider.borderColor = borderColor
        saturationSlider.borderWidth = borderWidth
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsb.saturation
        saturationSlider.addTarget(self, action: #selector(saturationSliderValueChanged), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(saturationSliderTouchDown), for: .touchDown)
        saturationSlider.addTarget(self, action: #selector(saturationSliderTouchUpInside), for: .touchUpInside)
        addSubview(saturationSlider)
        
        
        brightnessSlider.roundedCorners = roundedCorners
        brightnessSlider.borderColor = borderColor
        brightnessSlider.borderWidth = borderWidth
        brightnessSlider.color1 = UIColor.white
        brightnessSlider.color2 = UIColor.black
        brightnessSlider.value = hsb.brightness
        brightnessSlider.addTarget(self, action: #selector(brightnessSliderValueChanged), for: .valueChanged)
        brightnessSlider.addTarget(self, action: #selector(brightnessSliderTouchDown), for: .touchDown)
        brightnessSlider.addTarget(self, action: #selector(brightnessSliderTouchUpInside), for: .touchUpInside)
        addSubview(brightnessSlider)
        
        
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
            brightnessSlider.frame = frame
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
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        saturationSlider.color2 = color
        brightnessSlider.color2 = color
        
        let saturation = saturationSlider.value
        hueSlider.saturation = saturation
        
        let brightness = brightnessSlider.value
        hueSlider.brightness = brightness
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
    
    
    func brightnessSliderValueChanged(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
    }
    func brightnessSliderTouchDown(sender: GradientSlider) {
        updateSliderColors()
        valueChanged()
        touchDown()
    }
    
    func brightnessSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
}
