//
//  ImagePickerViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class ImagePickerViewController: BaseViewController {

    @IBOutlet weak var imagePicker: ImagePicker!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //        imagePicker.image = #imageLiteral(resourceName: "gradient_landscape")
//    }
    
    @IBAction func imagePickerTouchDown(_ sender: ImagePicker) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePickerTouchUpInside(_ sender: AnyObject) {
        updateBackgroundColor()
    }
    
    @IBAction func imagePickerValueChanged(_ sender: AnyObject) {
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        view.backgroundColor = imagePicker.color
    }

    override func reset() {
        imagePicker.position = CGPoint(x: imagePicker.bounds.midX, y: imagePicker.bounds.midY)
        updateBackgroundColor()
    }

    
}
