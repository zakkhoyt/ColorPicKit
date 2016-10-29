//
//  HSLASliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class HSLASliderGroup: SliderGroup {
    
    public override var intrinsicContentSize: CGSize {
        get {
            if showAlphaSlider {
                let height = 3 * spacing + 4.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
            } else {
                let height = 2 * spacing + 3.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
            }
        }
    }
    
    
    
    fileprivate var hslaSlider: HSLASlider!
    fileprivate var saturationSlider: GradientSlider!
    fileprivate var lightnessSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        let hsla = color.hsla()
        
        hslaSlider = HSLASlider()
        hslaSlider.roundedCorners = roundedCorners
        hslaSlider.borderColor = borderColor
        hslaSlider.borderWidth = borderWidth
        hslaSlider.barHeight = barHeight
        hslaSlider.knobSize = knobSize
        hslaSlider.value = hsla.hue
        hslaSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        hslaSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        hslaSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(hslaSlider)
        sliders.append(hslaSlider)
        
        saturationSlider = GradientSlider()
        saturationSlider.roundedCorners = roundedCorners
        saturationSlider.borderColor = borderColor
        saturationSlider.borderWidth = borderWidth
        saturationSlider.barHeight = barHeight
        saturationSlider.knobSize = knobSize
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsla.saturation
        saturationSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        saturationSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(saturationSlider)
        sliders.append(saturationSlider)
        
        lightnessSlider = GradientSlider()
        
        lightnessSlider.roundedCorners = roundedCorners
        lightnessSlider.borderColor = borderColor
        lightnessSlider.borderWidth = borderWidth
        lightnessSlider.barHeight = barHeight
        lightnessSlider.knobSize = knobSize
        lightnessSlider.color1 = UIColor.white
        lightnessSlider.color2 = UIColor.black
        lightnessSlider.value = hsla.lightness
        lightnessSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        lightnessSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        lightnessSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(lightnessSlider)
        sliders.append(lightnessSlider)
        
        if showAlphaSlider {
            alphaSlider = GradientSlider()
            alphaSlider.roundedCorners = roundedCorners
            alphaSlider.borderColor = borderColor
            alphaSlider.borderWidth = borderWidth
            alphaSlider.barHeight = barHeight
            alphaSlider.knobSize = knobSize
            alphaSlider.color1 = UIColor.clear
            alphaSlider.color2 = UIColor.white
            alphaSlider.value = hsla.alpha
            alphaSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            alphaSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
            alphaSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
            addSubview(alphaSlider)
            sliders.append(alphaSlider)
        }
        
    }
    
    override func colorFromSliders() -> UIColor {
        
        guard let _ = hslaSlider,
            let _ = saturationSlider,
            let _ = lightnessSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let hue = hslaSlider.value
        let saturation = saturationSlider.value
        let lightness = lightnessSlider.value
        let alpha = alphaSlider.value
        let hsla = HSLA(hue: hue, saturation: saturation, lightness: lightness, alpha: alpha)
        return hsla.color()
    }
    
    override func slidersFrom(color: UIColor) {
        let hsla = color.hsla()
        hslaSlider.value = hsla.hue
        saturationSlider.value = hsla.saturation
        lightnessSlider.value = hsla.lightness
        alphaSlider.value = hsla.alpha
        updateSliderColors()
    }
    
    override func updateSliderColors() {
        let hue = hslaSlider.value
        //let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        let hsla = HSLA(hue: hue, saturation: 1.0, lightness: 1.0)
        let color = hsla.color()
        
        saturationSlider.color2 = color
        lightnessSlider.color2 = color
        
        let saturation = saturationSlider.value
        hslaSlider.saturation = saturation
        
        let lightness = lightnessSlider.value
        hslaSlider.lightness = lightness
    }
    
}
