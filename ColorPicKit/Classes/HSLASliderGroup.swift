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
        hslaSlider.value = hsla.hue
        addSubview(hslaSlider)
        sliders.append(hslaSlider)
        
        saturationSlider = GradientSlider()
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsla.saturation
        addSubview(saturationSlider)
        sliders.append(saturationSlider)
        
        lightnessSlider = GradientSlider()
        lightnessSlider.color1 = UIColor.white
        lightnessSlider.color2 = UIColor.black
        lightnessSlider.value = hsla.lightness
        addSubview(lightnessSlider)
        sliders.append(lightnessSlider)
        
        if showAlphaSlider {
            alphaSlider = GradientSlider()
            alphaSlider.color1 = UIColor.clear
            alphaSlider.color2 = UIColor.white
            alphaSlider.value = hsla.alpha
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
        if self.realtimeMix {
            let hue = hslaSlider.value
            let saturation = saturationSlider.value
            let lightness = lightnessSlider.value
            
            // Hue
            hslaSlider.lightness = lightness
            hslaSlider.saturation = saturation
            
            // Saturation
            saturationSlider.color1 = HSLA(hue: hue, saturation: 0.0, lightness: lightness).color()
            saturationSlider.color2 = HSLA(hue: hue, saturation: 1.0, lightness: lightness).color()
            
            // Brightness
            lightnessSlider.color1 = HSLA(hue: hue, saturation: saturation, lightness: 0.0).color()
            lightnessSlider.color2 = HSLA(hue: hue, saturation: saturation, lightness: 1.0).color()
            
            hslaSlider.knobView.color = self.color
            saturationSlider.knobView.color = self.color
            lightnessSlider.knobView.color = self.color
            alphaSlider.knobView.color = self.color

        }
    }
    
}
