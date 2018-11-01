//
//  SliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//


import UIKit

@IBDesignable public class SliderGroup: UIControl, SliderControlGroup, Colorable {
    
    // MARK: Variables

    fileprivate var _realtimeMix: Bool = false
    @IBInspectable public var realtimeMix: Bool {
        get {
            return _realtimeMix
        }
        set {
            _realtimeMix = newValue
            commonInit()
            updateSliderColors()
            
        }
    }
    
    fileprivate var _showAlphaSlider: Bool = true
    @IBInspectable public var showAlphaSlider: Bool {
        get {
            return _showAlphaSlider
        }
        set {
            _showAlphaSlider = newValue
            
            for slider in sliders {
                slider.removeFromSuperview()
            }
            sliders.removeAll()
            
            commonInit()
        }
    }
    
    @IBInspectable public var color: UIColor {
        get {
            return colorFromSliders()
        }
        set {
            slidersFrom(color: newValue)
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
                for slider in sliders {
                    slider.barHeight = newValue
                }
                
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
                for slider in sliders {
                    slider.knobSize = newValue
                }
            }
        }
    }
    
    private var _colorKnob: Bool = true
    @IBInspectable public var colorKnob: Bool {
        get {
            return _colorKnob
        }
        set {
            if _colorKnob != newValue {
                _colorKnob = newValue
                for slider in sliders {
                    slider.colorKnob = newValue
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
                for slider in sliders {
                    slider.borderColor = newValue
                }

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
                for slider in sliders {
                    slider.borderWidth = newValue
                }

            }
            
        }
    }
    
    private var _roundedCornders: Bool = true
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            if _roundedCornders != newValue {
                _roundedCornders = newValue
                
                for slider in sliders {
                    slider.roundedCorners = newValue
                }
            }
            
        }
    }

    
    func colorFromSliders() -> UIColor {
        assert(false, "child must implement");
        return UIColor.clear
    }
    
    func slidersFrom(color: UIColor) {
        assert(false, "child must implement");
    }
    
    
    let spacing: CGFloat = 4
    let sliderHeight: CGFloat = 40
    
    
    var sliders: [Slider] = [Slider]()

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
        
        for slider in sliders {
            slider.removeFromSuperview()
        }
        sliders.removeAll()

        configureSliders()
        
        for slider in sliders {
            slider.roundedCorners = roundedCorners
            slider.borderColor = borderColor
            slider.borderWidth = borderWidth
            slider.barHeight = barHeight
            slider.knobSize = knobSize
            slider.colorKnob = colorKnob
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            slider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
            slider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)

        }
    }
    
    func configureSliders() {
        assert(false, "child must implement");
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        
        for (index, slider) in sliders.enumerated() {
            let x = CGFloat(0)

            let y = (CGFloat(index) * spacing) + (CGFloat(index) * sliderHeight)
            let w = CGFloat(bounds.width)
            let h = CGFloat(sliderHeight)
            let frame = CGRect(x: x, y: y, width: w, height: h)
            slider.frame = frame
            
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
    
 
    @objc func sliderValueChanged(sender: GradientSlider) {
        valueChanged()
        updateSliderColors()
    }
    @objc func sliderTouchDown(sender: GradientSlider) {
        valueChanged()
        touchDown()
        updateSliderColors()
    }
    
    @objc func sliderTouchUpInside(sender: GradientSlider) {
        valueChanged()
        touchUpInside()
        updateSliderColors()
    }
    
    func updateSliderColors() {
        print("Child class CAN implement (not required)")
    }

    
}
