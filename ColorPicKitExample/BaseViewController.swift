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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resetBarb = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetBarbAction))
        navigationItem.rightBarButtonItem = resetBarb
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
