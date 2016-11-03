//
//  AlphaSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/31/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class AlphaSlider: Slider {
    
    private var _color: UIColor = .black
    @IBInspectable public var color1: UIColor  {
        get {
            return _color
        }
        set {
            _color = newValue
            gradientView.color1 = newValue
            updateKnobColor()
        }
    }
    
    
    fileprivate var gradientView = GradientSliderView()
    
    override func configureBackgroundView() {
        
        gradientView.borderColor = borderColor
        gradientView.borderWidth = borderWidth
        gradientView.roundedCorners = roundedCorners
        addSubview(gradientView)
        self.sliderView = gradientView
        
    }
    
    override func colorFrom(value: CGFloat) -> UIColor {
        return color.withAlphaComponent(value)
    }
    
}
