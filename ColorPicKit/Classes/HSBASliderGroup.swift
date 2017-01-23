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
            if showAlphaSlider {
                let height = 3 * spacing + 4.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
                
            } else {
                let height = 2 * spacing + 3.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
            }
        }
    }
    
    
    
    fileprivate var hsbaSlider: HSBASlider!
    fileprivate var saturationSlider: GradientSlider!
    fileprivate var brightnessSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        let hsba = color.hsba()
        
        hsbaSlider = HSBASlider()
        hsbaSlider.value = hsba.hue
        addSubview(hsbaSlider)
        sliders.append(hsbaSlider)
        
        saturationSlider = GradientSlider()
        saturationSlider.color1 = UIColor.black
        saturationSlider.color2 = UIColor.white
        saturationSlider.value = hsba.saturation
        addSubview(saturationSlider)
        sliders.append(saturationSlider)
        
        brightnessSlider = GradientSlider()
        brightnessSlider.color1 = UIColor.white
        brightnessSlider.color2 = UIColor.black
        brightnessSlider.value = hsba.brightness
        addSubview(brightnessSlider)
        sliders.append(brightnessSlider)
        
        if showAlphaSlider {
            alphaSlider = GradientSlider()
            alphaSlider.color1 = UIColor.clear
            alphaSlider.color2 = UIColor.white
            alphaSlider.value = hsba.alpha
            addSubview(alphaSlider)
            sliders.append(alphaSlider)
        }
    }
    
    override func colorFromSliders() -> UIColor {
        
        guard let _ = hsbaSlider,
            let _ = saturationSlider,
            let _ = brightnessSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let hue = hsbaSlider.value
        let saturation = saturationSlider.value
        let brightness = brightnessSlider.value
        let alpha = alphaSlider.value
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        return color
    }
    
    override func slidersFrom(color: UIColor) {
        let hsba = color.hsba()
        hsbaSlider.value = hsba.hue
        saturationSlider.value = hsba.saturation
        brightnessSlider.value = hsba.brightness
        alphaSlider.value = hsba.alpha
        updateSliderColors()
    }
    
    override func updateSliderColors() {
        if self.realtimeMix {
            let hue = hsbaSlider.value
            let saturation = saturationSlider.value
            let brightness = brightnessSlider.value
            
            // Hue
            hsbaSlider.brightness = brightness
            hsbaSlider.saturation = saturation
            
            //let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            // Saturation
            saturationSlider.color1 = UIColor(hue: hue, saturation: 0.0, brightness: brightness, alpha: 1.0)
            saturationSlider.color2 = UIColor(hue: hue, saturation: 1.0, brightness: brightness, alpha: 1.0)
            
            // Brightness
            brightnessSlider.color1 = UIColor(hue: hue, saturation: saturation, brightness: 0.0, alpha: 1.0)
            brightnessSlider.color2 = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
            
            hsbaSlider.knobView.color = self.color
            saturationSlider.knobView.color = self.color
            brightnessSlider.knobView.color = self.color
            alphaSlider.knobView.color = self.color

            
        }
    }
    
}
