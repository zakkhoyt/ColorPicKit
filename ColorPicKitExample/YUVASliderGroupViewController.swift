//
//  YUVASliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


class YUVASliderGroupViewController: BaseViewController {
 
    @IBOutlet weak var yuvaSliderGroup: YUVASliderGroup!
    
    
    @IBAction func yuvaSliderValueChanged(_ sender: YUVASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvaSliderTouchDown(_ sender: YUVASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvaSliderTouchUpInside(_ sender: YUVASliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func realtimeMixerSwitchValueChanged(_ sender: UISwitch) {
        yuvaSliderGroup.realtimeMix = sender.isOn
    }
    
    private func updateBackgroundColor() {
        colorView.color = yuvaSliderGroup.color
        colorView.hexLabel.text = yuvaSliderGroup.color.yuva().stringFor(type: .baseOne) +
        "\n" +
        yuvaSliderGroup.color.rgba().stringFor(type: .baseOne)
    }
    
    override func reset() {
        yuvaSliderGroup.color = resetColor
        updateBackgroundColor()
    }
}
