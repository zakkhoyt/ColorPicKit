//
//  HSBSliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBSliderGroupViewController: BaseViewController {

    @IBOutlet weak var hsbSliderGroup: HSBSliderGroup!
    
    
    @IBAction func grayscaleSliderValueChanged(_ sender: HSBSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchDown(_ sender: HSBSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchUpInside(_ sender: HSBSliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hsbSliderGroup.color
    }
    
    override func reset() {
        hsbSliderGroup.color = resetColor
        updateBackgroundColor()
    }
}
