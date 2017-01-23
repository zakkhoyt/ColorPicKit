//
//  KeyPadButton.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 1/23/17.
//  Copyright © 2017 Zakk Hoyt. All rights reserved.
//

import UIKit

public class KeyPadButton: UIButton {
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.lightGray, for: .highlighted)
        
        self.backgroundColor = UIColor.white
        
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 4.0
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 2)

    }
}
