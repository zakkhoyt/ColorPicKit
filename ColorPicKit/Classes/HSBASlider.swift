//
//  HSBASlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/28/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public class HSBASlider: Slider {

    private var _saturation: CGFloat = 1.0
    @IBInspectable public var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                hsbaView.saturation = newValue
                updateKnobColor()
            }
        }
    }
    
    private var _brightness: CGFloat = 1.0
    @IBInspectable public var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            if _brightness != newValue {
                _brightness = newValue
                hsbaView.brightness = newValue
                updateKnobColor()
            }
        }
    }
    
    fileprivate var hsbaView = HSBASliderView()
    
    
    override func configureBackgroundView() {
        hsbaView.borderColor = borderColor
        hsbaView.borderWidth = borderWidth
        hsbaView.roundedCorners = roundedCorners
        addSubview(hsbaView)
        self.sliderView = hsbaView
    }
    
    
    override func colorFrom(value: CGFloat) -> UIColor {
        let hue = value
        let color = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
        return color
    }


}
