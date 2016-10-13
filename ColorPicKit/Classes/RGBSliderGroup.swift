//
//  RGBSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class RGBSliderGroup: UIControl, SliderControlGroup, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                redSlider.roundedCorners = roundedCorners
                greenSlider.roundedCorners = roundedCorners
                blueSlider.roundedCorners = roundedCorners
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
                redSlider.borderColor = newValue
                greenSlider.borderColor = newValue
                blueSlider.borderColor = newValue
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
                redSlider.borderWidth = newValue
                greenSlider.borderWidth = newValue
                blueSlider.borderWidth = newValue
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
                redSlider.barHeight = newValue
                greenSlider.barHeight = newValue
                blueSlider.barHeight = newValue
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
                redSlider.knobSize = newValue
                greenSlider.knobSize = newValue
                blueSlider.knobSize = newValue
            }
        }
    }
    

    @IBInspectable public var color: UIColor {
        get {
            let red = redSlider.value
            let blue = blueSlider.value
            let green = greenSlider.value
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            return color
        }
        set {
            let rgb = newValue.rgb()
            redSlider.value = rgb.red
            greenSlider.value = rgb.green
            blueSlider.value = rgb.blue
        }
    }
    
    
    private let spacing: CGFloat = 20
    private let sliderHeight: CGFloat = 20

    
    private var redSlider = GradientSlider()
    private var greenSlider = GradientSlider()
    private var blueSlider = GradientSlider()
    
    
    
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
        
        let rgb = color.rgb()
        redSlider.roundedCorners = roundedCorners
        redSlider.borderColor = borderColor
        redSlider.borderWidth = borderWidth
        redSlider.barHeight = barHeight
        redSlider.knobSize = knobSize
        redSlider.color1 = UIColor.white
        redSlider.color2 = UIColor.red
        redSlider.value = rgb.red
        redSlider.addTarget(self, action: #selector(redSliderValueChanged), for: .valueChanged)
        redSlider.addTarget(self, action: #selector(redSliderTouchDown), for: .touchDown)
        redSlider.addTarget(self, action: #selector(redSliderTouchUpInside), for: .touchUpInside)
        addSubview(redSlider)

        greenSlider.roundedCorners = roundedCorners
        greenSlider.borderColor = borderColor
        greenSlider.borderWidth = borderWidth
        greenSlider.barHeight = barHeight
        greenSlider.knobSize = knobSize
        greenSlider.color1 = UIColor.white
        greenSlider.color2 = UIColor.green
        greenSlider.value = rgb.green
        greenSlider.addTarget(self, action: #selector(greenSliderValueChanged), for: .valueChanged)
        greenSlider.addTarget(self, action: #selector(greenSliderTouchDown), for: .touchDown)
        greenSlider.addTarget(self, action: #selector(greenSliderTouchUpInside), for: .touchUpInside)
        addSubview(greenSlider)

        
        blueSlider.roundedCorners = roundedCorners
        blueSlider.borderColor = borderColor
        blueSlider.borderWidth = borderWidth
        blueSlider.barHeight = barHeight
        blueSlider.knobSize = knobSize
        blueSlider.color1 = UIColor.white
        blueSlider.color2 = UIColor.blue
        blueSlider.value = rgb.blue
        blueSlider.addTarget(self, action: #selector(blueSliderValueChanged), for: .valueChanged)
        blueSlider.addTarget(self, action: #selector(blueSliderTouchDown), for: .touchDown)
        blueSlider.addTarget(self, action: #selector(blueSliderTouchUpInside), for: .touchUpInside)
        addSubview(blueSlider)

        
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(0 * sliderHeight + 1 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            redSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(1 * sliderHeight + 2 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            greenSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(2 * sliderHeight + 3 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            blueSlider.frame = frame
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
    
    // MARK: IBActions
    func redSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func redSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func redSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
    
    func greenSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func greenSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func greenSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
    
    func blueSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func blueSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func blueSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }

}
