//
//  HSLASpectrum.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

private let invalidPositionValue = CGFloat(-1.0)

@IBDesignable public class HSLASpectrum: Spectrum {
    
    fileprivate var hslaSpectrumView = HSLSpectrumView()
    override func configureSpectrum() {
        hslaSpectrumView.borderWidth = borderWidth
        hslaSpectrumView.borderColor = borderColor
        addSubview(hslaSpectrumView)
        self.spectrumView = hslaSpectrumView
        
    }
    
    override func colorAt(position: CGPoint) -> UIColor {
        let rgb = hslaSpectrumView.rgbaFor(point: position)
        return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
    }
}
