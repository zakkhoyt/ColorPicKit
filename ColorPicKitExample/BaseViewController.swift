//
//  BaseViewController.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let resetColor = UIColor.cyan
    let resetValue = CGFloat(0.5)

    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reset bar button item
        let resetBarb = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetBarbAction))
        navigationItem.rightBarButtonItem = resetBarb
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // ColorView 
        colorView.layer.borderWidth = 0.5
        colorView.layer.borderColor = UIColor.lightGray.cgColor
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 8.0
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { 
            self.reset()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reset()
    }
    
    
    func resetBarbAction(sender: UIBarButtonItem) {
        trace()
        reset()
    }
    
    func trace(message: String? = nil, file: String = #file, function: String = #function, line: Int = #line) {
        var output = "\(file) - \(function) - \(line)"
        if let message = message {
            output += " - " + message
        }
        print(output)
    }
    
    func reset() {
        print("TODO: Child view controller must implement")
    }

}
