//
//  CMYKSliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class CMYKSliderGroupViewController: BaseViewController {
    
    @IBOutlet weak var cmykSliderGroup: CMYKSliderGroup!

    @IBAction func grayscaleSliderValueChanged(_ sender: CMYKSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchDown(_ sender: CMYKSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchUpInside(_ sender: CMYKSliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = cmykSliderGroup.color
    }
    
    override func reset() {
        cmykSliderGroup.color = resetColor
        updateBackgroundColor()
    }

}
