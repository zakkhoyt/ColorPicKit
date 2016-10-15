//
//  HueSliderViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HueSliderViewController: BaseViewController {

    @IBOutlet weak var hueSlider: HueSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func grayscaleSliderValueChanged(_ sender: HueSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchDown(_ sender: HueSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchUpInside(_ sender: HueSlider) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
 //       view.backgroundColor = hueSlider.color
        colorView.backgroundColor = hueSlider.color
    }
    
    override func reset() {
        hueSlider.value = resetValue
        updateBackgroundColor()
    }
}
