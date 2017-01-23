//
//  HexKeypadViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/16/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class HexKeypadViewController: BaseViewController {

//    @IBOutlet weak var hexKeyboard: HexKeypad!
//    
//    @IBAction func imagePixelPickerTouchDown(_ sender: HexKeypad) {
//        updateBackgroundColor()
//    }
//    
//    @IBAction func imagePixelPickerTouchUpInside(_ sender: HexKeypad) {
//        updateBackgroundColor()
//    }
//    
//    @IBAction func imagePixelPickerValueChanged(_ sender: HexKeypad) {
//        updateBackgroundColor()
//    }
//    
//    private func updateBackgroundColor() {
//        colorView.backgroundColor = hexKeyboard.color
//    }
//    
//    override func reset() {
////        hsbWheel.position = CGPoint(x: hsbWheel.bounds.midX, y: hsbWheel.bounds.midY)
//        hexKeyboard.color = resetColor
//        updateBackgroundColor()
//    }

    @IBOutlet weak var colorTextField: ColorTextField!
    
    @IBAction func colorTextFieldValueChanged(_ sender: Any) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        colorView.backgroundColor = colorTextField.color
    }
    
    override func reset() {
        colorTextField.color = resetColor
        updateBackgroundColor()
    }

    
}
