//
//  RGBSliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class RGBSliderGroupViewController: BaseViewController {

    
    @IBOutlet weak var rgbSliderGroup: RGBSliderGroup!
    
    @IBAction func grayscaleSliderValueChanged(_ sender: RGBSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchDown(_ sender: RGBSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchUpInside(_ sender: RGBSliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = rgbSliderGroup.color
    }
    
    override func reset() {
        rgbSliderGroup.color = resetColor
        updateBackgroundColor()
    }

}
