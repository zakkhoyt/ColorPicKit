//
//  HSBASliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class HSBASliderGroup: SliderGroup {
    
    public override var intrinsicContentSize: CGSize {
        get {
            let height = 3 * spacing + 4.0 * sliderHeight
            return CGSize(width: bounds.width, height: height)
        }
    }
    
    
    
    fileprivate var hueSlider: HueSlider!
    fileprivate var saturationSlider: GradientSlider!
    fileprivate var brightnessSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        let hsba = color.hsba()
        
        hueSlider = HueSlider()
        hueSlider.roundedCorners = roundedCorners
        hueSlider.borderColor = borderColor
        hueSlider.borderWidth = borderWidth
        hueSlider.barHeight = barHeight
        hueSlider.knobSize = knobSize
        hueSlider.value = hsba.hue
        hueSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        hueSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        hueSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(hueSlider)
        sliders.append(hueSlider)
        
        saturationSlider = GradientSlider()
        saturationSlider.roundedCorners = roundedCorners
        saturationSlider.borderColor = borderColor
        saturationSlider.borderWidth = borderWidth
        saturationSlider.barHeight = barHeight
        saturationSlider.knobSize = knobSize
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsba.saturation
        saturationSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        saturationSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(saturationSlider)
        sliders.append(saturationSlider)
        
        brightnessSlider = GradientSlider()
        
        brightnessSlider.roundedCorners = roundedCorners
        brightnessSlider.borderColor = borderColor
        brightnessSlider.borderWidth = borderWidth
        brightnessSlider.barHeight = barHeight
        brightnessSlider.knobSize = knobSize
        brightnessSlider.color1 = UIColor.white
        brightnessSlider.color2 = UIColor.black
        brightnessSlider.value = hsba.brightness
        brightnessSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        brightnessSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        brightnessSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(brightnessSlider)
        sliders.append(brightnessSlider)
        
        
        alphaSlider = GradientSlider()
        alphaSlider.roundedCorners = roundedCorners
        alphaSlider.borderColor = borderColor
        alphaSlider.borderWidth = borderWidth
        alphaSlider.barHeight = barHeight
        alphaSlider.knobSize = knobSize
        alphaSlider.color1 = UIColor.clear
        alphaSlider.color2 = UIColor.white
        alphaSlider.value = hsba.alpha
        alphaSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        alphaSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        alphaSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(alphaSlider)
        sliders.append(alphaSlider)
        
    }
    
    override func colorFromSliders() -> UIColor {
        
        guard let _ = hueSlider,
            let _ = saturationSlider,
            let _ = brightnessSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let hue = hueSlider.value
        let saturation = saturationSlider.value
        let brightness = brightnessSlider.value
        let alpha = alphaSlider.value
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        return color
    }
    
    override func slidersFrom(color: UIColor) {
        let hsba = color.hsba()
        hueSlider.value = hsba.hue
        saturationSlider.value = hsba.saturation
        brightnessSlider.value = hsba.brightness
        alphaSlider.value = hsba.alpha
        updateSliderColors()
    }
    
    override func updateSliderColors() {
        let hue = hueSlider.value
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
        saturationSlider.color2 = color
        brightnessSlider.color2 = color
        
        let saturation = saturationSlider.value
        hueSlider.saturation = saturation
        
        let brightness = brightnessSlider.value
        hueSlider.brightness = brightness
    }
    
}
