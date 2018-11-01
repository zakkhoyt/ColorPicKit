//
//  ColorTextField.swift
//  ColorTextField
//
//  Created by Zakk Hoyt on 1/21/17.
//  Copyright © 2017 Zakk Hoyt. All rights reserved.
//

import UIKit


public enum ColorTextFieldStyle: Int {
    case rgb
    case rgba
    
    case hsb
    case hsba
    
    case hsl
    case hsla
    
    case cmyk
    case cmyka
    
    case yuv
    case yuva
    
    func requiredLength() -> Int {
        switch self {
        case .rgb:
            return 6
        case .rgba:
            return 8
        case .hsb:
            return 6
        case .hsba:
            return 8
        case .hsl:
            return 6
        case .hsla:
            return 8
        case .cmyk:
            return 8
        case .cmyka:
            return 10
        case .yuv:
            return 6
        case .yuva:
            return 8
        }
    }
    
    func title() -> String {
        switch self {
        case .rgb:
            return "RGB"
        case .rgba:
            return "RGBA"
        case .hsb:
            return "HSB"
        case .hsba:
            return "HSBA"
        case .hsl:
            return "HSL"
        case .hsla:
            return "HSLA"
        case .cmyk:
            return "CMYK"
        case .cmyka:
            return "CMYAK"
        case .yuv:
            return "YUV"
        case .yuva:
            return "YUVA"
        }
        
    }
    
    func format() -> String {
        switch self {
        case .rgb:
            return "RRGGBB"
        case .rgba:
            return "RRGGBBAA"
        case .hsb:
            return "HHSSBB"
        case .hsba:
            return "HHSSBBAA"
        case .hsl:
            return "HHSSLL"
        case .hsla:
            return "HHSSLLAA"
        case .cmyk:
            return "CCMMYYKK"
        case .cmyka:
            return "CCMMYYKKAA"
        case .yuv:
            return "YYUUVV"
        case .yuva:
            return "YYUUVVAA"
        }
        
    }

}

@IBDesignable public class ColorTextField: UITextField {
    
    
    @IBInspectable
    fileprivate var _color: UIColor = .white
    public var color: UIColor {
        get {
            return _color
        }
        set {
            _color = newValue
            colorView.backgroundColor = newValue
            self.sendActions(for: .valueChanged)
        }
    }
    
    @IBInspectable
    public var leftPadding: CGFloat = 4 {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable
    public var rightPadding: CGFloat = 4 {
        didSet {
            updateUI()
        }
    }
    
    
    public var style: ColorTextFieldStyle = .hsba
    
    
    fileprivate var hexKeyPadView: HexKeyPadView!
    fileprivate var styleLabel: UILabel!
    fileprivate var colorView: UIView!
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        
        
        
        let width = UIScreen.main.bounds.width
//        let height: CGFloat = 258 // iOS keyboard as measured in a 7 simulator
        let height = width / 1.5
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        hexKeyPadView = HexKeyPadView(frame: frame)
        hexKeyPadView.backgroundColor = UIColor.lightGray
        
        hexKeyPadView.delegate = self
        inputView = hexKeyPadView
        updateUI()
    }
    
    public override func prepareForInterfaceBuilder() {
        updateUI()
    }
    
    fileprivate func updateUI() {
        updateLeftView()
        updateRightView()
        
        if let placeholder = placeholder {
            let attr = [convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor): tintColor.withAlphaComponent(0.5),
                        convertFromNSAttributedStringKey(NSAttributedString.Key.font): self.font!] as [String : Any]
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: convertToOptionalNSAttributedStringKeyDictionary(attr))
        }
    }
    
    fileprivate func updateLeftView() {
        
        leftViewMode = .always
        
        if styleLabel == nil {
            styleLabel = UILabel(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
        }
        styleLabel.font = self.font
        styleLabel.text = "[" + style.format() + "]"
        //styleLabel.textColor = tintColor
        styleLabel.textColor = self.textColor?.withAlphaComponent(0.5)
        styleLabel.sizeToFit()
        
        
        if leftView == nil {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: styleLabel.bounds.width + leftPadding, height: styleLabel.bounds.height))
            view.addSubview(styleLabel)
            leftView = view
        }
    }
    
    
    fileprivate func updateRightView() {
        rightViewMode = .always
        
        if rightView == nil {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20 + rightPadding, height: 20))
            //            view.backgroundColor = .lightGray
            rightView = view
            
            colorView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            colorView.backgroundColor = .cyan
            view.addSubview(colorView)
            
        }
    }
    
    // Convert hex string to array of floats.
    // RGB: FF8000 => [1.0, 0.5, 0.0)
    fileprivate func convertToFloats(text: String) -> [CGFloat] {
    
        // Example: RGB is 6 chars, Divided by 2 is 3 bytes
        let length = style.requiredLength() / 2
        
        let scanner = Scanner(string: text)
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        
        var ints = [Int]()
        for i in 0..<length {
            //var shift = ((length - 1) - i)
            var shift = i
            shift = shift * 8
            ints.append(Int(color >> UInt32(shift)) & mask)
        }
        
        var floats = [CGFloat]()
        for i in ints {
            floats.append(CGFloat(i) / CGFloat(255))
        }
        
        return floats
        
    }
    
    fileprivate func updateColorView() {
        
        guard let text = self.text else {
            return
        }
        
        let floats = convertToFloats(text: text)
        
        
        switch style {
        case .rgb:
            let rgba = RGBA(red: floats[2], green: floats[1], blue: floats[0], alpha: 1.0)
            self.color = rgba.color()
        case .rgba:
            let rgba = RGBA(red: floats[3], green: floats[2], blue: floats[1], alpha: floats[0])
            self.color = rgba.color()
        case .hsb:
            let hsba = HSBA(hue: floats[2], saturation: floats[1], brightness: floats[0], alpha: 1.0)
            self.color = hsba.color()
        case .hsba:
            let hsba = HSBA(hue: floats[3], saturation: floats[2], brightness: floats[1], alpha: floats[0])
            self.color = hsba.color()
        case .hsl:
            let hsla = HSLA(hue: floats[2], saturation: floats[1], lightness: floats[0], alpha: 1.0)
            self.color = hsla.color()
        case .hsla:
            let hsla = HSLA(hue: floats[3], saturation: floats[2], lightness: floats[1], alpha: floats[0])
            self.color = hsla.color()
        case .cmyk:
            let cmyka = CMYKA(cyan: floats[3], magenta: floats[2], yellow: floats[1], black: floats[0], alpha: 1.0)
            self.color = cmyka.color()
        case .cmyka:
            let cmyka = CMYKA(cyan: floats[4], magenta: floats[3], yellow: floats[2], black: floats[1], alpha: floats[0])
            self.color = cmyka.color()
        case .yuv:
            let yuva = YUVA(y: floats[2], u: floats[1], v: floats[0], alpha: 1.0)
            self.color = yuva.color()
        case .yuva:
            let yuva = YUVA(y: floats[3], u: floats[2], v: floats[1], alpha: floats[0])
            self.color = yuva.color()
        }
    }
}

extension ColorTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let requiredLength = style.requiredLength()
        if text.count < requiredLength {
            
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

extension ColorTextField: HexKeyPadViewDelegate {
    
    func hexKeyPadView(_ hexKeyPadView: HexKeyPadView, didPressKey key: String) {
        if let text = self.text {
            let requiredLength = style.requiredLength()
            if text.count < requiredLength {
                self.text = text + key
            }
        } else {
            self.text = key
        }
        
        updateColorView()
        
    }
    
    func hexKeyPadViewDidPressCloseKey(_ hexKeyPadView: HexKeyPadView) {
        resignFirstResponder()
    }
    
    func hexKeyPadViewDidPressDeleteKey(_ hexKeyPadView: HexKeyPadView) {
        if let text = self.text {
            if text.count > 0 {
//                let truncated = text.substring(to: text.index(before: text.endIndex))
//                self.text = truncated
                self.deleteBackward()
                updateColorView()
            }
        }
        
    }
    
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
