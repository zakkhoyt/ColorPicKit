//
//  HSBWheelView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBWheelView: WheelView {

    override func rgbaFor(point: CGPoint) -> RGBA {
        let center = CGPoint(x: radius, y: radius)
        let angle = atan2(point.x - center.x, point.y - center.y) + CGFloat.pi
        let dist = pointDistance(point, CGPoint(x: center.x, y: center.y))
        var hue  = angle / (CGFloat.pi * 2.0)
        hue = min(hue, 1.0 - 0.0000001)
        hue = max(hue, 0.0)
        
        var sat = dist / radius
        
        sat = min(sat, 1.0)
        sat = max(sat, 0.0)
        let rgba = UIColor.hsbaToRGBA(hsba: HSBA(hue: hue, saturation: sat, brightness: brightness))
        return rgba
    }
}

