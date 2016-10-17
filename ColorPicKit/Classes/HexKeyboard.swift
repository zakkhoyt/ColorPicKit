//
//  HexKeyboard.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/16/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class HexKeyboard: UIControl, Colorable, ColorControl {

    private var _roundedCornders: Bool = false
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            if _roundedCornders == false {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 0
            } else {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 40.0
            }
        }
    }
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    private var _borderWidth: CGFloat = 0.0
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            self.layer.borderWidth = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: bounds.width)
        }
    }

    private var _font: UIFont = UIFont.boldSystemFont(ofSize: 30)
    @IBInspectable public var font: UIFont {
        get {
            return _font
        }
        set {
            _font = newValue
            layoutSubviews()
        }
    }
    
    private var _textColor: UIColor = .darkGray
    @IBInspectable public var textColor: UIColor {
        get {
            return _textColor
        }
        set {
            _textColor = newValue
            layoutSubviews()
        }
    }
    
    

    
    private var _color: UIColor = .white
    @IBInspectable public var color: UIColor {
        get {
            if let hexString = hexLabel.text {
                let color = UIColor(hexString: hexString)
                return color
            }
            return _color
        }
        set {
            _color = newValue
            hexLabel.text = newValue.hexString()
        }
    }
    
    
    //private var hexLabelHeight: CGFloat = 30
    private var hexLabel = UILabel()
    private var keys = [UIButton]()
    private var backspace = UIButton()
    private var clear = UIButton()
    
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
        self.roundedCorners = _roundedCornders
        self.borderWidth = _borderWidth
        self.borderColor = _borderColor
        
        
        // Keys

        for i in 0..<16 {
            let button = UIButton(type: .custom)
            button.setTitle(String(format: "%X", i), for: .normal)
            button.tag = i
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(hexKeyTouchDown), for: .touchDown)
            button.addTarget(self, action: #selector(hexKeyTouchUpInside), for: .touchUpInside)
            addSubview(button)
            keys.append(button)
        }
        
        // Label
        
        
        hexLabel.textAlignment = .center
        hexLabel.text = ""
        addSubview(hexLabel)
        
        
        
        // Backspace
        
        backspace = UIButton(type: .custom)
        backspace.setTitle("🔙", for: .normal)
        backspace.backgroundColor = UIColor.clear
        backspace.addTarget(self, action: #selector(backspaceKeyTouchDown), for: .touchDown)
        addSubview(backspace)
        
        
        clear = UIButton(type: .custom)
        clear.setTitle("❌", for: .normal)
        clear.backgroundColor = UIColor.clear
        clear.addTarget(self, action: #selector(clearKeyTouchDown), for: .touchDown)
        addSubview(clear)


    }

    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        
        let quarterWidth = bounds.width / 4.0
        let fifthHeight = bounds.height / 5.0
        for i in 0..<16 {
            let x: CGFloat = CGFloat(i % 4) * quarterWidth
            let y: CGFloat = fifthHeight + CGFloat(i / 4) * fifthHeight
            let w: CGFloat = quarterWidth
            let h: CGFloat = fifthHeight
            let frame = CGRect(x: x, y: y, width: w, height: h)
            let button = keys[i]
            button.frame = frame
            button.titleLabel?.font = font
            button.setTitleColor(textColor, for: .normal)
            
        }
        
        
        let labelFrame = CGRect(x: quarterWidth, y: 0, width: bounds.width - 2 * quarterWidth, height: fifthHeight)
        hexLabel.frame = labelFrame
        hexLabel.backgroundColor = UIColor.clear
        hexLabel.font = font
        hexLabel.textColor = textColor
        
        
        backspace.frame = CGRect(x: bounds.width - quarterWidth, y: 0, width: quarterWidth, height: fifthHeight)
        backspace.titleLabel?.font = font
        backspace.setTitleColor(textColor, for: .normal)
        
        clear.frame = CGRect(x: 0, y: 0, width: quarterWidth, height: fifthHeight)
        clear.titleLabel?.font = font
        clear.setTitleColor(textColor, for: .normal)

    }
    
    func clearKeyTouchDown(sender: UIButton) {
        hexLabel.text = ""
        valueChanged()
    }
    
    
    @objc private func backspaceKeyTouchDown(sender: UIButton) {
        guard var hexString = hexLabel.text else {
            return
        }
        
        if hexString.characters.count == 0 {
            return
        }
        
        hexString.characters.removeLast()
        hexLabel.text = hexString
        
        valueChanged()
    }
    
    @objc private func hexKeyTouchUpInside(sender: UIButton) {
        valueChanged()
        touchUpInside()
    }
    
    @objc private func hexKeyTouchDown(sender: UIButton) {
        print("key \(sender.tag) pressed")
        
        if (hexLabel.text?.characters.count)! >= 6 {
            print("Hex string already 6 chars")
            return
        }
        
        let digit = String(format: "%X", sender.tag)
        if let hexString = hexLabel.text {
            hexLabel.text = hexString + digit
        } else {
            hexLabel.text = digit
        }
        
        
        touchDown()
        valueChanged()
    }
    
    
    func touchDown() {
        self.sendActions(for: .touchDown)
    }
    
    func touchUpInside() {
        self.sendActions(for: .touchUpInside)
    }
    
    func valueChanged() {
        self.sendActions(for: .valueChanged)
    }
    
}
