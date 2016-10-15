//
//  GradientSliderViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class GradientSliderViewController: BaseViewController {

    
    @IBOutlet weak var gradientSlider: GradientSlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func grayscaleSliderValueChanged(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchDown(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    @IBAction func grayscaleSliderTouchUpInside(_ sender: GradientSlider) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = gradientSlider.color
    }
    
    override func reset() {
        gradientSlider.value = resetValue
        updateBackgroundColor()
    }

}
