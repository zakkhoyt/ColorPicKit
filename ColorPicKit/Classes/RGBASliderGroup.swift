//
//  RGBASliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class RGBASliderGroup: SliderGroup {
    
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

    
    
    fileprivate var redSlider: GradientSlider!
    fileprivate var greenSlider: GradientSlider!
    fileprivate var blueSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        
        let rgba = color.rgba()
        
        redSlider = GradientSlider()
        redSlider.color1 = UIColor.white
        redSlider.color2 = UIColor.red
        redSlider.value = rgba.red
        addSubview(redSlider)
        sliders.append(redSlider)
        
        greenSlider = GradientSlider()
        greenSlider.color1 = UIColor.white
        greenSlider.color2 = UIColor.green
        greenSlider.value = rgba.green
        addSubview(greenSlider)
        sliders.append(greenSlider)
        
        blueSlider = GradientSlider()
        blueSlider.color1 = UIColor.white
        blueSlider.color2 = UIColor.blue
        blueSlider.value = rgba.blue
        addSubview(blueSlider)
        sliders.append(blueSlider)
        
        if showAlphaSlider {
            alphaSlider = GradientSlider()
            alphaSlider.color1 = UIColor.clear
            alphaSlider.color2 = UIColor.white
            alphaSlider.value = rgba.alpha
            addSubview(alphaSlider)
            sliders.append(alphaSlider)
        }
        
    }
    
    override func colorFromSliders() -> UIColor {
        
        guard let _ = redSlider,
            let _ = greenSlider,
            let _ = blueSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let red = redSlider.value
        let green = greenSlider.value
        let blue = blueSlider.value
        let alpha = alphaSlider.value
        let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
        return rgba.color()
    }
    
    override func slidersFrom(color: UIColor) {
        let rgba = color.rgba()
        redSlider.value = rgba.red
        greenSlider.value = rgba.green
        blueSlider.value = rgba.blue
        alphaSlider.value = rgba.alpha
        
        updateSliderColors()

    }
    
    override func updateSliderColors() {
        
        if self.realtimeMix {
            let rgba = self.color.rgba()
            
            redSlider.color1 = UIColor(red: 0, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
            redSlider.color2 = UIColor(red: 1.0, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
            
            greenSlider.color1 = UIColor(red: rgba.red, green: 0, blue: rgba.blue, alpha: rgba.alpha)
            greenSlider.color2 = UIColor(red: rgba.red, green: 1.0, blue: rgba.blue, alpha: rgba.alpha)
            
            blueSlider.color1 = UIColor(red: rgba.red, green: rgba.green, blue: 0.0, alpha: rgba.alpha)
            blueSlider.color2 = UIColor(red: rgba.red, green: rgba.green, blue: 1.0, alpha: rgba.alpha)
            

            redSlider.knobView.color = self.color
            greenSlider.knobView.color = self.color
            blueSlider.knobView.color = self.color
            alphaSlider.knobView.color = self.color

        }
        

        
    }
    
}


















