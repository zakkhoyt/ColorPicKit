//
//  HSBSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBSpectrumViewController: BaseViewController {


    @IBOutlet weak var hsbaSpectrum: HSBASpectum!
    
    @IBAction func hsbaSpectrumTouchDown(_ sender: HSBASpectum) {
        updateBackgroundColor()
    }
    
    @IBAction func hsbaSpectrumTouchUpInside(_ sender: HSBASpectum) {
        updateBackgroundColor()
    }
    
    @IBAction func hsbaSpectrumValueChanged(_ sender: HSBASpectum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hsbaSpectrum.color
    }
    
    override func reset() {
        hsbaSpectrum.position = CGPoint(x: hsbaSpectrum.bounds.midX, y: hsbaSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}
