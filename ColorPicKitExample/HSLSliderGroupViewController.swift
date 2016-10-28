//
//  HSLSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Foundation

class HSLSliderGroupViewController: BaseViewController {
    
    
    @IBOutlet weak var hslaSliderGroup: HSLASliderGroup!
    
    
    @IBAction func hslaSliderValueChanged(_ sender: HSLASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hslaSliderTouchDown(_ sender: HSLASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hslaSliderTouchUpInside(_ sender: HSLASliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hslaSliderGroup.color
    }
    
    override func reset() {
        hslaSliderGroup.color = resetColor
        updateBackgroundColor()
    }
    
}
