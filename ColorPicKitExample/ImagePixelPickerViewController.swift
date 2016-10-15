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
        colorView.backgroundColor = imagePixelPicker.color
    }

    override func reset() {
        imagePixelPicker.position = CGPoint(x: imagePixelPicker.bounds.midX, y: imagePixelPicker.bounds.midY)
        updateBackgroundColor()
        
//        // Get color of center pixel
//        guard let image = UIImage(named: "mars_earth") else {
//            return
//        }
//        let center = CGPoint(x: image.size.width / 2.0, y: image.size.height / 2.0)
//        let color = image.pixelColorAt(point: center)
        
        
    }

    
}
