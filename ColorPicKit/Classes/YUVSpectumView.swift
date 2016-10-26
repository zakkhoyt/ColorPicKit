//
//  YUVSpectrumView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//


import UIKit


class YUVSpectrumView: SpectrumView {
    override func rgbaFor(point: CGPoint) -> RGBA {
        let y: CGFloat = 0.5
        let u = point.x / bounds.width
        let v = point.y / bounds.height
        let yuva = YUVA(y: y, u: u, v: v)
        let rgba = yuva.rgba()
        return rgba
    }
}
