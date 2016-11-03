//
//  HSLASliderView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/28/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public class HSLASliderView: HueSliderView {
    
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
    
    
    private var _lightness: CGFloat = 0.5
    public var lightness: CGFloat {
        get {
            return _lightness
        }
        set {
            if _lightness != newValue {
                _lightness = newValue
                updateGradient()
                setNeedsDisplay()
            }
        }
    }
    

    // MARK: Public methods
    override func colorForPoint(_ point: CGPoint) -> RGBA {
        let hue = point.x / bounds.width
        let rgba = UIColor.hslaToRGBA(hsla: HSLA(hue: hue, saturation: saturation, lightness: lightness))
        return rgba
    }
}

