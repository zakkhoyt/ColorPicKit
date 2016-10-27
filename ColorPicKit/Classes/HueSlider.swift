//
//  HueSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class HueSlider: Slider {

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
    
    private var _brightness: CGFloat = 1.0
    @IBInspectable public var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            if _brightness != newValue {
                _brightness = newValue
                hueView.brightness = newValue
            }
        }
    }

    fileprivate var hueView = HueView()
    
    
    override func configureBackgroundView() {
        hueView.borderColor = borderColor
        hueView.borderWidth = borderWidth
        hueView.roundedCorners = roundedCorners
        addSubview(hueView)
        self.backgroundView = hueView
    }

    
    override func colorFrom(value: CGFloat) -> UIColor {
        let hue = value
        let color = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        return color
    }

    
}
