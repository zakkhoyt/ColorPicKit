//
//  HexKeyboardViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/16/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HexKeyboardViewController: BaseViewController {

    @IBOutlet weak var hexKeyboard: HexKeyboard!
    
    @IBAction func imagePixelPickerTouchDown(_ sender: HexKeyboard) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerTouchUpInside(_ sender: HexKeyboard) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePixelPickerValueChanged(_ sender: HexKeyboard) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = hexKeyboard.color
    }
    
    override func reset() {
//        hsbWheel.position = CGPoint(x: hsbWheel.bounds.midX, y: hsbWheel.bounds.midY)
        hexKeyboard.color = resetColor
        updateBackgroundColor()
    }

}
