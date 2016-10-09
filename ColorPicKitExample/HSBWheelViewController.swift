//
//  HSBWheelViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HSBWheelViewController: BaseViewController {

    @IBOutlet weak var hsbWheel: HSBWheel!
    
    @IBAction func imagePickerTouchDown(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePickerTouchUpInside(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePickerValueChanged(_ sender: HSBWheel) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = hsbWheel.color
    }
    
    override func reset() {
        hsbWheel.position = CGPoint(x: hsbWheel.bounds.midX, y: hsbWheel.bounds.midY)
        updateBackgroundColor()
    }

}
