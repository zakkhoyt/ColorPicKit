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
        updateBrightnessSlider()
    }
    
    @IBAction func colorWheelTouchDown(_ sender: HSBWheel) {
        updateBackgroundColor()
        updateBrightnessSlider()
    }
    
    @IBAction func colorWheelTouchUpInside(_ sender: HSBWheel) {
        updateBackgroundColor()
        updateBrightnessSlider()
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
    
    private func updateBrightnessSlider() {
        
        let hsb = hsbWheel.color.hsb()
        let color = UIColor(hue: hsb.hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        brightnessSlider.color2 = color
    }
    
    private func updateBackgroundColor() {
        let brightness = brightnessSlider.value
        hsbWheel.brightness = brightness
        view.backgroundColor = hsbWheel.color
    }
    
    override func reset() {
        hsbWheel.position = CGPoint(x: hsbWheel.bounds.midX, y: hsbWheel.bounds.midY)
        brightnessSlider.value = resetValue
        
        updateBackgroundColor()
        updateBrightnessSlider()
        
    }
}
