//
//  HSLSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Foundation

class HSLSliderGroupViewController: BaseViewController {
    
    
    @IBOutlet weak var hslSliderGroup: HSLSliderGroup!
    
    
    @IBAction func hslSliderValueChanged(_ sender: HSLSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hslSliderTouchDown(_ sender: HSLSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hslSliderTouchUpInside(_ sender: HSLSliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hslSliderGroup.color
    }
    
    override func reset() {
        hslSliderGroup.color = resetColor
        updateBackgroundColor()
    }
    
}
