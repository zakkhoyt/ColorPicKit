//
//  HSBWheelBrightnessViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBWheelBrightnessViewController: BaseViewController {

    @IBOutlet weak var hsbWheel: HSBWheel!
    @IBOutlet weak var brightnessSlider: GradientSlider!
    
    
    // MARK: colorWheel actions
    @IBAction func colorWheelValueChanged(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    @IBAction func colorWheelTouchDown(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    @IBAction func colorWheelTouchUpInside(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    // MARK: brightnessSlider actions
    @IBAction func brightnessSliderTouchDown(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func brightnessSliderTouchUpInside(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func brightnessSliderValueChanged(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    
    private func updateBackgroundColor() {
        let brightness = brightnessSlider.value
        hsbWheel.brightness = brightness
        view.backgroundColor = hsbWheel.color
    }
    
    override func reset() {
        hsbWheel.color = resetColor
        updateBackgroundColor()
    }
}
