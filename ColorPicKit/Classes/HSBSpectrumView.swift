//
//  HSBSpectrumView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


class HSBSpectrumView: SpectrumView {
    override func rgbaFor(point: CGPoint) -> RGBA {
        
        let hue = point.y / bounds.height
        let normalizedX = (point.x / bounds.height) // 0...1
        
        var saturation = CGFloat(0)
        var brightness = CGFloat(1.0)
        if normalizedX < 0.5 {
            saturation = normalizedX * 2
            brightness = 1.0
        } else {
            let x = normalizedX - 0.5
            brightness = 1.0 - (x * 2.0)
            saturation = 1.0
        }
        
        let rgba = UIColor.hsbaToRGBA(hsba: HSBA(hue: hue, saturation: saturation, brightness: brightness))
        return rgba
    }
}
