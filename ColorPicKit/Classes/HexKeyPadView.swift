//
//  HexKeyPad.swift
//  ColorTextField
//
//  Created by Zakk Hoyt on 1/21/17.
//  Copyright © 2017 Zakk Hoyt. All rights reserved.
//

import UIKit


protocol HexKeyPadViewDelegate: class {
    func hexKeyPadView(_ hexKeyPadView: HexKeyPadView, didPressKey key: String)
    func hexKeyPadViewDidPressCloseKey(_ hexKeyPadView: HexKeyPadView)
    func hexKeyPadViewDidPressDeleteKey(_ hexKeyPadView: HexKeyPadView)
}


class HexKeyPadView: UIView {
    
    var delegate: HexKeyPadViewDelegate? = nil
    
    fileprivate let toolBarHeight = CGFloat(44)
    fileprivate var closeButton: KeyPadButton!
    fileprivate var deleteButton: DeleteButton!
    fileprivate var buttons: [KeyPadButton] = [KeyPadButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.white
        
        // Top tool bar
        
        do {
            closeButton = KeyPadButton(type: .custom)
            closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
            closeButton.setTitle("Done", for: .normal)
            addSubview(closeButton)
            
            deleteButton = DeleteButton(type: .custom)
            deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
            deleteButton.setTitle("", for: .normal)
            addSubview(deleteButton)
            
        }
        
        // Keys
        do {
            for i in 0..<16 {
                let button = KeyPadButton(type: .custom)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
                button.tag = Int(i)
                
                let title = String(format: "%X", i)
                button.setTitle(title, for: .normal)
                
                buttons.append(button)
                addSubview(button)
            }
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        do {
            let width = frame.width / 4.0
            let height = toolBarHeight
            
            let halfWidth = width / 2.0
            let halfHeight = height / 2.0
            let buttonWidth = width - 8.0
            let buttonHeight = height - 8.0

            do {
                let frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
                closeButton.frame = frame
                
                let centerX = 0 + halfWidth
                let centerY = 0 + halfHeight
                let center = CGPoint(x: centerX, y: centerY)
                closeButton.center = center
            }
            
            do {
                let frame = CGRect(x: 3 * width, y: 0, width: buttonWidth, height: buttonHeight)
                deleteButton.frame = frame
                
                let centerX = 3 * width + halfWidth
                let centerY = 0 + halfHeight
                let center = CGPoint(x: centerX, y: centerY)
                deleteButton.center = center
            }
            
            
        }
        
        do {
            let width: CGFloat = frame.size.width / 4.0
            let height: CGFloat = (frame.size.height - toolBarHeight) / 4.0
            
            let halfWidth = width / 2.0
            let halfHeight = height / 2.0
            let buttonWidth = width - 8.0
            let buttonHeight = height - 8.0
            
            for i in 0..<16 {
                let x = i / 4
                let y = i % 4

                
                let centerX = width * CGFloat(x) + halfWidth
                let centerY = toolBarHeight + height * CGFloat(y) + halfHeight
                
                let button = buttons[i]
                
                
                let frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
                button.frame = frame
                
                let center = CGPoint(x: centerX, y: centerY)
                button.center = center
                
                
            }

        }
        
    }
    
    @objc private func closeButtonAction(sender: UIButton) {
        print("closeButton tapped")
        delegate?.hexKeyPadViewDidPressCloseKey(self)
    }
    
    @objc private func deleteButtonAction(sender: UIButton) {
        print("deleteButton tapped")
        delegate?.hexKeyPadViewDidPressDeleteKey(self)
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        print("\(sender.tag) tapped")
        let key = String(format: "%X", sender.tag)
        delegate?.hexKeyPadView(self, didPressKey: key)
    }
    
}
