//
//  HSBASliderView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/28/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public class HSBASliderView: HueSliderView {

    private var _saturation: CGFloat = 1.0
    public var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                updateGradient()
                setNeedsDisplay()
            }
        }
    }
    
    
    private var _brightness: CGFloat = 1.0
    public var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            if _brightness != newValue {
                _brightness = newValue
                updateGradient()
                setNeedsDisplay()
            }
        }
    }
    
    
    // MARK: Public methods
    override func colorForPoint(_ point: CGPoint) -> RGBA {
        let hue = point.x / bounds.width
        let rgba = UIColor.hsbaToRGBA(hsba: HSBA(hue: hue, saturation: saturation, brightness:brightness))
        return rgba
    }
}
