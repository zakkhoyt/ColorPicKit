//
//  YUVSpectrumViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//



import UIKit

class YUVSpectrumViewController: BaseViewController {
    
    @IBOutlet weak var yuvaSpectrum: YUVASpectrum!
    
    
    @IBAction func yuvaSpectrumTouchDown(_ sender: YUVASpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvaSpectrumTouchUpInside(_ sender: YUVASpectrum) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvaSpectrumValueChanged(_ sender: YUVASpectrum) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = yuvaSpectrum.color
    }
    
    override func reset() {
        yuvaSpectrum.position = CGPoint(x: yuvaSpectrum.bounds.midX, y: yuvaSpectrum.bounds.midY)
        updateBackgroundColor()
    }
}

