//
//  GradientSlider.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class GradientSlider: Slider {
    
    private var _color1: UIColor = .black
    @IBInspectable public var color1: UIColor  {
        get {
            return _color1
        }
        set {
            _color1 = newValue
            gradientView.color1 = newValue
            updateKnobColor()
        }
    }
    
    private var _color2: UIColor = .white
    @IBInspectable public var color2: UIColor {
        get {
            return _color2
        }
        set {
            _color2 = newValue
            gradientView.color2 = newValue
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
        return UIColor.interpolateAt(value: value, betweenColor1: color1, andColor2: color2)
    }

}
