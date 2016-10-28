//
//  SliderView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/26/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

public class SliderView: UIView {
    
    
    private var _roundedCornders: Bool = false
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            setNeedsDisplay()
        }
    }
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            layer.borderColor = newValue.cgColor
            setNeedsDisplay()
        }
    }
    
    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            layer.borderWidth = newValue
            setNeedsDisplay()
        }
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
    }
    
    
    
    override public func draw(_ rect: CGRect) {
        
        backgroundColor = UIColor.clear
        
        // Round corners
        if roundedCorners {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = bounds.midY
        } else {
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 0
        }
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        
        
        guard let context = UIGraphicsGetCurrentContext() else {
            print("No Context")
            return
        }
        
        drawBackground(context: context)
    }
    
    func drawBackground(context: CGContext) {
        assert(false, "Child must implement")
    }

    
}
