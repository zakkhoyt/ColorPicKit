//
//  VideoPixelPickerViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/13/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class VideoPixelPickerViewController: BaseViewController {

    
    @IBOutlet weak var videoPixelPicker: VideoPixelPicker!
    
    
    @IBAction func videoPixelPickerTouchDown(_ sender: VideoPixelPicker) {
        updateBackgroundColor()
    }
    
    @IBAction func videoPixelPickerTouchUpInside(_ sender: VideoPixelPicker) {
        updateBackgroundColor()
    }
    
    @IBAction func videoPixelPickerValueChanged(_ sender: VideoPixelPicker) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = videoPixelPicker.color
    }
    
    override func reset() {
        videoPixelPicker.position = CGPoint(x: videoPixelPicker.bounds.midX, y: videoPixelPicker.bounds.midY)
        updateBackgroundColor()
        
    }


}
