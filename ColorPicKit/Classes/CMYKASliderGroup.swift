//
//  CMYKASliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//
import UIKit

@IBDesignable public class CMYKASliderGroup: SliderGroup {
    
    
    public override var intrinsicContentSize: CGSize {
        get {
            if showAlphaSlider {
                let height = 4 * spacing + 5.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
            } else {
                let height = 3 * spacing + 4.0 * sliderHeight
                return CGSize(width: bounds.width, height: height)
            }
        }
    }

    
    
    fileprivate var cyanSlider: GradientSlider!
    fileprivate var magentaSlider: GradientSlider!
    fileprivate var yellowSlider: GradientSlider!
    fileprivate var blackSlider: GradientSlider!
    fileprivate var alphaSlider: GradientSlider!
    
    
    override func configureSliders() {
        let rgba = color.rgba()
        
        cyanSlider = GradientSlider()
        cyanSlider.roundedCorners = roundedCorners
        cyanSlider.borderColor = borderColor
        cyanSlider.borderWidth = borderWidth
        cyanSlider.barHeight = barHeight
        cyanSlider.knobSize = knobSize
        cyanSlider.color1 = UIColor.white
        cyanSlider.color2 = UIColor.cyan
        cyanSlider.value = rgba.red
        cyanSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        cyanSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        cyanSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(cyanSlider)
        sliders.append(cyanSlider)
        
        magentaSlider = GradientSlider()
        magentaSlider.roundedCorners = roundedCorners
        magentaSlider.borderColor = borderColor
        magentaSlider.borderWidth = borderWidth
        magentaSlider.barHeight = barHeight
        magentaSlider.knobSize = knobSize
        magentaSlider.color1 = UIColor.white
        magentaSlider.color2 = UIColor.magenta
        magentaSlider.value = rgba.green
        magentaSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        magentaSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        magentaSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(magentaSlider)
        sliders.append(magentaSlider)
        
        yellowSlider = GradientSlider()
        yellowSlider.roundedCorners = roundedCorners
        yellowSlider.borderColor = borderColor
        yellowSlider.borderWidth = borderWidth
        yellowSlider.barHeight = barHeight
        yellowSlider.knobSize = knobSize
        yellowSlider.color1 = UIColor.white
        yellowSlider.color2 = UIColor.yellow
        yellowSlider.value = rgba.blue
        yellowSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        yellowSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        yellowSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(yellowSlider)
        sliders.append(yellowSlider)
        
        blackSlider = GradientSlider()
        blackSlider.roundedCorners = roundedCorners
        blackSlider.borderColor = borderColor
        blackSlider.borderWidth = borderWidth
        blackSlider.color1 = UIColor.white
        blackSlider.color2 = UIColor.black
        blackSlider.value = rgba.blue
        blackSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        blackSlider.addTarget(self, action: #selector(sliderTouchDown), for: .touchDown)
        blackSlider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
        addSubview(blackSlider)
        sliders.append(blackSlider)
        
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
        
        guard let _ = cyanSlider,
            let _ = magentaSlider,
            let _ = yellowSlider,
            let _ = blackSlider,
            let _ = alphaSlider else {
                print("sliders not configured");
                return UIColor.clear
        }
        
        let cyan = cyanSlider.value
        let magenta = magentaSlider.value
        let yellow = yellowSlider.value
        let black = blackSlider.value
        let alpha = alphaSlider.value
        let cmyka = CMYKA(cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: alpha)
        let rgba = UIColor.cmykaToRGBA(cmyka: cmyka)
        return rgba.color()

    }
    
    override func slidersFrom(color: UIColor) {
        let cmyka = color.cmyka()
        cyanSlider.value = cmyka.cyan
        magentaSlider.value = cmyka.magenta
        yellowSlider.value = cmyka.yellow
        blackSlider.value = cmyka.black
        alphaSlider.value = cmyka.alpha
        updateSliderColors()
    }
    
    
    override func updateSliderColors() {
        
        if self.realtimeMix {
            
            var cyan1 = self.color.cmyka()
            cyan1.cyan = 0
            cyanSlider.color1 = cyan1.color()
            var cyan2 = self.color.cmyka()
            cyan2.cyan = 1.0
            cyanSlider.color2 = cyan2.color()
            
            var magenta1 = self.color.cmyka()
            magenta1.magenta = 0
            magentaSlider.color1 = magenta1.color()
            var magenta2 = self.color.cmyka()
            magenta2.magenta = 1.0
            magentaSlider.color2 = magenta2.color()
            
            var yellow1 = self.color.cmyka()
            yellow1.yellow = 0
            yellowSlider.color1 = yellow1.color()
            var yellow2 = self.color.cmyka()
            yellow2.yellow = 1.0
            yellowSlider.color2 = yellow2.color()

            var black1 = self.color.cmyka()
            black1.black = 0
            blackSlider.color1 = black1.color()
            var black2 = self.color.cmyka()
            black2.black = 1.0
            blackSlider.color2 = black2.color()


        }
        
    }
    
    
}
