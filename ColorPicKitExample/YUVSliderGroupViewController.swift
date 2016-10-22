//
//  YUVSliderGroupViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/22/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Foundation


class YUVSliderGroupViewController: BaseViewController {
 
    @IBOutlet weak var yuvSliderGroup: YUVSliderGroup!
    
    
    @IBAction func yuvSliderValueChanged(_ sender: YUVSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvSliderTouchDown(_ sender: YUVSliderGroup) {
        updateBackgroundColor()
    }
    
    @IBAction func yuvSliderTouchUpInside(_ sender: YUVSliderGroup) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = yuvSliderGroup.color
    }
    
    override func reset() {
        yuvSliderGroup.color = resetColor
        updateBackgroundColor()
    }
    
}
