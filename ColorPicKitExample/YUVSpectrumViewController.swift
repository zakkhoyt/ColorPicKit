//
//  YUVSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//



import UIKit

class YUVSpectrumViewController: BaseViewController {
    
    @IBOutlet weak var yuvSpectrum: YUVSpectrum!
    
    
    @IBAction func imagePixelPickerTouchDown(_ sender: YUVSpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerTouchUpInside(_ sender: YUVSpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerValueChanged(_ sender: YUVSpectrum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = yuvSpectrum.color
    }
    
    override func reset() {
        yuvSpectrum.position = CGPoint(x: yuvSpectrum.bounds.midX, y: yuvSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}

