//
//  HSBASpectrum.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


@IBDesignable public class HSBASpectum: Spectrum {

    fileprivate var hsbaSpectrumView = HSBSpectrumView()
    override func configureSpectrum() {
        hsbaSpectrumView.borderWidth = borderWidth
        hsbaSpectrumView.borderColor = borderColor
        addSubview(hsbaSpectrumView)
        self.spectrumView = hsbaSpectrumView

    }
    
    override func colorAt(position: CGPoint) -> UIColor {
        let rgb = hsbaSpectrumView.rgbaFor(point: position)
        return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0)
    }
}
