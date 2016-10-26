//
//  CMYKASliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class CMYKASliderGroupViewController: BaseViewController {
    
    @IBOutlet weak var cmykaSliderGroup: CMYKASliderGroup!

    @IBAction func cmykaSliderValueChanged(_ sender: CMYKASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func cmykaSliderTouchDown(_ sender: CMYKASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func cmykaSliderTouchUpInside(_ sender: CMYKASliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = cmykaSliderGroup.color
    }
    
    override func reset() {
        cmykaSliderGroup.color = resetColor
        updateBackgroundColor()
    }

}
