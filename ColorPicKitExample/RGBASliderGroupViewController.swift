//
//  RGBASliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class RGBASliderGroupViewController: BaseViewController {
    
    
    @IBOutlet weak var rgbaSliderGroup: RGBASliderGroup!
    
    @IBAction func rgbaSliderGroupValueChanged(_ sender: RGBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func rgbaSliderGroupTouchDown(_ sender: RGBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func rgbaSliderGroupTouchUpInside(_ sender: RGBASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func realtimeMixerSwitchValueChanged(_ sender: UISwitch) {
        rgbaSliderGroup.realtimeMix = sender.isOn
    }

    
    private func updateBackgroundColor() {
        colorView.backgroundColor = rgbaSliderGroup.color
    }
    
    override func reset() {
        rgbaSliderGroup.color = resetColor
        updateBackgroundColor()
    }
    
}
