//
//  HSLASlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/28/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSLASlider: Slider {
    private var _saturation: CGFloat = 1.0
    @IBInspectable public var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                hueView.saturation = newValue
            }
        }
    }
    
    private var _lightness: CGFloat = 1.0
    public var lightness: CGFloat {
        get {
            return _lightness
        }
        set {
            if _lightness != newValue {
                _lightness = newValue
                hueView.lightness = newValue
            }
        }
    }
    
    fileprivate var hueView = HSLASliderView()
    
    
    override func configureBackgroundView() {
        hueView.borderColor = borderColor
        hueView.borderWidth = borderWidth
        hueView.roundedCorners = roundedCorners
        addSubview(hueView)
        self.sliderView = hueView
    }
    
    
    override func colorFrom(value: CGFloat) -> UIColor {
        let hue = value
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        return color
    }


}
