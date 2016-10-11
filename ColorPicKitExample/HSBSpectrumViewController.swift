//
//  HSBSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBSpectrumViewController: BaseViewController {


    @IBOutlet weak var hsbSpectrum: HSBSpectum!
    
    @IBAction func imagePixelPickerTouchDown(_ sender: HSBSpectum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerTouchUpInside(_ sender: HSBSpectum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerValueChanged(_ sender: HSBSpectum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = hsbSpectrum.color
    }
    
    override func reset() {
        hsbSpectrum.position = CGPoint(x: hsbSpectrum.bounds.midX, y: hsbSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}
