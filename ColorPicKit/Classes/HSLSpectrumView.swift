//
//  HSLSpectrumView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/23/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//


import UIKit


class HSLSpectrumView: SpectrumView {
    
    override func rgbaFor(point: CGPoint) -> RGBA {
        let h = point.y / bounds.height
        let s = CGFloat(1.0)
        let l = (point.x / bounds.width / 2.0 + 0.5)
        let hsla = HSLA(hue: h, saturation: s, lightness: l)
        let rgba = hsla.rgba()
        return rgba
    }
}


