//
//  YUVASliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class YUVASliderGroup: SliderGroup {
    
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
    
    
    
    fileprivate var ySlider: GradientSlider!
    fileprivate var uSlider: GradientSlider!
    fileprivate var vSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        let rgba = color.rgba()
        
        ySlider = GradientSlider()
        ySlider.roundedCorners = roundedCorners
        ySlider.borderColor = borderColor
        ySlider.borderWidth = borderWidth
        ySlider.barHeight = barHeight
        ySlider.knobSize = knobSize
        ySlider.color1 = UIColor.black
        ySlider.color2 = UIColor.white
        ySlider.value = rgba.red
        ySlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        ySlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        ySlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(ySlider)
        sliders.append(ySlider)
        
        uSlider = GradientSlider()
        uSlider.roundedCorners = roundedCorners
        uSlider.borderColor = borderColor
        uSlider.borderWidth = borderWidth
        uSlider.barHeight = barHeight
        uSlider.knobSize = knobSize
        uSlider.color1 = UIColor.black
        uSlider.color2 = UIColor.blue
        uSlider.value = rgba.green
        uSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        uSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        uSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(uSlider)
        sliders.append(uSlider)
        
        vSlider = GradientSlider()
        
        vSlider.roundedCorners = roundedCorners
        vSlider.borderColor = borderColor
        vSlider.borderWidth = borderWidth
        vSlider.barHeight = barHeight
        vSlider.knobSize = knobSize
        vSlider.color1 = UIColor.white
        vSlider.color2 = UIColor.red
        vSlider.value = rgba.blue
        vSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        vSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        vSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(vSlider)
        sliders.append(vSlider)
        
        if showAlphaSlider {
            alphaSlider = GradientSlider()
            alphaSlider.roundedCorners = roundedCorners
            alphaSlider.borderColor = borderColor
            alphaSlider.borderWidth = borderWidth
            alphaSlider.barHeight = barHeight
            alphaSlider.knobSize = knobSize
            alphaSlider.color1 = UIColor.clear
            alphaSlider.color2 = UIColor.white
            alphaSlider.value = rgba.blue
            alphaSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            alphaSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
            alphaSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
            addSubview(alphaSlider)
            sliders.append(alphaSlider)
        }
    }
    
    override func colorFromSliders() -> UIColor {
        
        guard let _ = ySlider,
            let _ = uSlider,
            let _ = vSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let y = ySlider.value
        let u = uSlider.value
        let v = vSlider.value
        let alpha = alphaSlider.value
        let yuva = YUVA(y: y, u: u, v: v, alpha: alpha)
        let color = UIColor(yuva: yuva)
        return color
    }
    
    override func slidersFrom(color: UIColor) {
        let yuva = color.yuva()
        ySlider.value = yuva.y
        uSlider.value = yuva.u
        vSlider.value = yuva.v
        alphaSlider.value = yuva.alpha
        
        updateSliderColors()
    }
    
    
    override func updateSliderColors() {
        
        if self.realtimeMix {
            
            var y1 = self.color.yuva()
            y1.y = 0
            ySlider.color1 = y1.color()
            var y2 = self.color.yuva()
            y2.y = 1.0
            ySlider.color2 = y2.color()
            
            var u1 = self.color.yuva()
            u1.u = 0
            uSlider.color1 = u1.color()
            var u2 = self.color.yuva()
            u2.u = 1.0
            uSlider.color2 = u2.color()
            
            var v1 = self.color.yuva()
            v1.v = 0
            vSlider.color1 = v1.color()
            var v2 = self.color.yuva()
            v2.v = 1.0
            vSlider.color2 = v2.color()

            
//            alphaSlider.color1 = UIColor.clear
//            var alpha2 = self.color.yuva()
//            alpha2.alpha = 1.0
//            alphaSlider.color2 = alpha2.color()
   
        }
        
    }

    
}

