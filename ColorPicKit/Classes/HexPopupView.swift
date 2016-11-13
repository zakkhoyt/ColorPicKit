//
//  HexPopupView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/12/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public class HexPopupView: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private var hexLabel: UILabel? = nil
    private func commonInit() {
        backgroundColor = UIColor.darkGray
        
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        
        hexLabel = UILabel(frame: bounds)
        hexLabel?.textColor = .white
        hexLabel?.textAlignment = .center
        hexLabel?.text = "0xFF"
        hexLabel?.font.withSize(12)
        
        addSubview(hexLabel!)
        
    }
    

    func setText(text: String) {
        hexLabel?.text = text
    }
    
    
}
