//
//  YUVASpectrum.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

private let invalidPositionValue = CGFloat(-1.0)

@IBDesignable public class YUVASpectrum: Spectrum {
    
    fileprivate var yuvaSpectrumView = YUVSpectrumView()
    override func configureSpectrum() {
        yuvaSpectrumView.borderWidth = borderWidth
        yuvaSpectrumView.borderColor = borderColor
        addSubview(yuvaSpectrumView)
        self.spectrumView = yuvaSpectrumView
        
    }
    
    override func colorAt(position: CGPoint) -> UIColor {
        let rgb = yuvaSpectrumView.rgbaFor(point: position)
        return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
    }
}
