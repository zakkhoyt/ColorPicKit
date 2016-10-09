//
//  CMYKSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



@IBDesignable public class CMYKSliderGroup: UIControl, SliderControlGroup, Colorable {
    
    // MARK: Variables
    
    private var _roundedCornders: Bool = true
    @IBInspectable var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                cyanSlider.roundedCorners = roundedCorners
                magentaSlider.roundedCorners = roundedCorners
                yellowSlider.roundedCorners = roundedCorners
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
                cyanSlider.borderColor = newValue
                magentaSlider.borderColor = newValue
                yellowSlider.borderColor = newValue
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
                cyanSlider.borderWidth = newValue
                magentaSlider.borderWidth = newValue
                yellowSlider.borderWidth = newValue
            }
            
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        get {
            let height = 5 * spacing + 4.0 * sliderHeight
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    
    var color: UIColor {
        get {
            let cyan = cyanSlider.value
            let magenta = magentaSlider.value
            let yellow = yellowSlider.value
            let black = blackSlider.value
            let cmyk = CMYK(cyan, magenta, yellow, black)
            let rgb = UIColor.cmykToRGB(cmyk: cmyk)
            let color = UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
            return color
        }
        set {
            let cmyk = newValue.cmyk()
            cyanSlider.value = cmyk.cyan
            magentaSlider.value = cmyk.magenta
            yellowSlider.value = cmyk.yellow
            blackSlider.value = cmyk.black
        }
    }
    
    
    private let spacing: CGFloat = 20
    private let sliderHeight: CGFloat = 20
    
    
    var sliders: [SliderControl] = [SliderControl]()
    private var cyanSlider = GradientSlider()
    private var magentaSlider = GradientSlider()
    private var yellowSlider = GradientSlider()
    private var blackSlider = GradientSlider()
    
    
    
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
        cyanSlider.roundedCorners = roundedCorners
        cyanSlider.borderColor = borderColor
        cyanSlider.borderWidth = borderWidth
        cyanSlider.color1 = UIColor.white
        cyanSlider.color2 = UIColor.cyan
        cyanSlider.value = rgb.red
        cyanSlider.addTarget(self, action: #selector(cyanSliderValueChanged), for: .valueChanged)
        cyanSlider.addTarget(self, action: #selector(cyanSliderTouchDown), for: .touchDown)
        cyanSlider.addTarget(self, action: #selector(cyanSliderTouchUpInside), for: .touchUpInside)
        addSubview(cyanSlider)
        
        magentaSlider.roundedCorners = roundedCorners
        magentaSlider.borderColor = borderColor
        magentaSlider.borderWidth = borderWidth
        magentaSlider.color1 = UIColor.white
        magentaSlider.color2 = UIColor.magenta
        magentaSlider.value = rgb.green
        magentaSlider.addTarget(self, action: #selector(magentaSliderValueChanged), for: .valueChanged)
        magentaSlider.addTarget(self, action: #selector(magentaSliderTouchDown), for: .touchDown)
        magentaSlider.addTarget(self, action: #selector(magentaSliderTouchUpInside), for: .touchUpInside)
        addSubview(magentaSlider)
        
        
        yellowSlider.roundedCorners = roundedCorners
        yellowSlider.borderColor = borderColor
        yellowSlider.borderWidth = borderWidth
        yellowSlider.color1 = UIColor.white
        yellowSlider.color2 = UIColor.yellow
        yellowSlider.value = rgb.blue
        yellowSlider.addTarget(self, action: #selector(yellowSliderValueChanged), for: .valueChanged)
        yellowSlider.addTarget(self, action: #selector(yellowSliderTouchDown), for: .touchDown)
        yellowSlider.addTarget(self, action: #selector(yellowSliderTouchUpInside), for: .touchUpInside)
        addSubview(yellowSlider)
        
        blackSlider.roundedCorners = roundedCorners
        blackSlider.borderColor = borderColor
        blackSlider.borderWidth = borderWidth
        blackSlider.color1 = UIColor.white
        blackSlider.color2 = UIColor.black
        blackSlider.value = rgb.blue
        blackSlider.addTarget(self, action: #selector(blackSliderValueChanged), for: .valueChanged)
        blackSlider.addTarget(self, action: #selector(blackSliderTouchDown), for: .touchDown)
        blackSlider.addTarget(self, action: #selector(blackSliderTouchUpInside), for: .touchUpInside)
        addSubview(blackSlider)

    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(0 * sliderHeight + 1 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            cyanSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(1 * sliderHeight + 2 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            magentaSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(2 * sliderHeight + 3 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            yellowSlider.frame = frame
        }
        
        do {
            let x = CGFloat(0)
            let y = CGFloat(3 * sliderHeight + 4 * spacing)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            blackSlider.frame = frame
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
    func cyanSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func cyanSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func cyanSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
    
    func magentaSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func magentaSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func magentaSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
    
    func yellowSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func yellowSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func yellowSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
    func blackSliderValueChanged(sender: GradientSlider) {
        valueChanged()
    }
    func blackSliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
    }
    
    func blackSliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
    }
    
}
