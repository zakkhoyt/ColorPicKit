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
    
    @IBAction func realtimeMixerSwitchValueChanged(_ sender: UISwitch) {
        cmykaSliderGroup.realtimeMix = sender.isOn
    }
    
    private func updateBackgroundColor() {
        colorView.color = cmykaSliderGroup.color
        colorView.hexLabel.text = cmykaSliderGroup.color.cmyka().stringFor(type: .baseOne)
    }
    
    override func reset() {
        cmykaSliderGroup.color = resetColor
        updateBackgroundColor()
    }

}
