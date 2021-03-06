//
//  HSLSliderGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

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
    
    @IBAction func realtimeMixerSwitchValueChanged(_ sender: UISwitch) {
        hslaSliderGroup.realtimeMix = sender.isOn
    }
    
    private func updateBackgroundColor() {
        colorView.color = hslaSliderGroup.color
        colorView.hexLabel.text = hslaSliderGroup.color.hsla().stringFor(type: .baseOne)
    }
    
    override func reset() {
        hslaSliderGroup.color = resetColor
        updateBackgroundColor()
    }
    
}
