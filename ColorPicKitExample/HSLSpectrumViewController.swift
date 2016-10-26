//
//  HSLSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/23/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSLSpectrumViewController: BaseViewController {
    
    
    @IBOutlet weak var hslaSpectrum: HSLASpectrum!
    
    @IBAction func hslaSpectrumTouchDown(_ sender: HSLASpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func hslaSpectrumTouchUpInside(_ sender: HSLASpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func hslaSpectrumValueChanged(_ sender: HSLASpectrum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hslaSpectrum.color
    }
    
    override func reset() {
        hslaSpectrum.position = CGPoint(x: hslaSpectrum.bounds.midX, y: hslaSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}
