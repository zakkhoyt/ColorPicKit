//
//  HSBSliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBSliderGroupViewController: BaseViewController {

    @IBOutlet weak var hsbaSliderGroup: HSBASliderGroup!
    
    
    @IBAction func hsbaSliderGroupValueChanged(_ sender: HSBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hsbaSliderGroupTouchDown(_ sender: HSBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func hsbaSliderGroupTouchUpInside(_ sender: HSBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func realtimeMixerSwitchValueChanged(_ sender: UISwitch) {
        hsbaSliderGroup.realtimeMix = sender.isOn
    }
    
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hsbaSliderGroup.color
    }
    
    override func reset() {
        hsbaSliderGroup.color = resetColor
        updateBackgroundColor()
    }
}
