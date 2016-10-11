//
//  ImagePixelPickerViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ImagePixelPickerViewController: BaseViewController {

    @IBOutlet weak var imagePixelPicker: ImagePixelPicker!
    
    
    @IBAction func imagePixelPickerTouchDown(_ sender: ImagePixelPicker) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerTouchUpInside(_ sender: AnyObject) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerValueChanged(_ sender: AnyObject) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = imagePixelPicker.color
    }

    override func reset() {
        imagePixelPicker.position = CGPoint(x: imagePixelPicker.bounds.midX, y: imagePixelPicker.bounds.midY)
        updateBackgroundColor()
    }

    
}
