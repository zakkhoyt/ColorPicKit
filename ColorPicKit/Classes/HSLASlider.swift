//
//  HSLASlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/28/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSLASlider: Slider {
    private var _saturation: CGFloat = 0.5
    @IBInspectable public var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                hslaView.saturation = newValue
            }
        }
    }
    
    private var _lightness: CGFloat = 0.5
    public var lightness: CGFloat {
        get {
            return _lightness
        }
        set {
            if _lightness != newValue {
                _lightness = newValue
                hslaView.lightness = newValue
            }
        }
    }
    
    fileprivate var hslaView = HSLASliderView()
    
    
    override func configureBackgroundView() {
        hslaView.borderColor = borderColor
        hslaView.borderWidth = borderWidth
        hslaView.roundedCorners = roundedCorners
        addSubview(hslaView)
        self.sliderView = hslaView
    }
    
    
    override func colorFrom(value: CGFloat) -> UIColor {
        let hue = value
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        return color
    }


}
