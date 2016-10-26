//
//  HSLSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/23/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSLSpectrumViewController: BaseViewController {
    
    
    @IBOutlet weak var hslSpectrum: HSLSpectrum!
    
    @IBAction func imagePixelPickerTouchDown(_ sender: HSLSpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerTouchUpInside(_ sender: HSLSpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerValueChanged(_ sender: HSLSpectrum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hslSpectrum.color
    }
    
    override func reset() {
        hslSpectrum.position = CGPoint(x: hslSpectrum.bounds.midX, y: hslSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}
