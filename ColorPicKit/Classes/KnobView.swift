//
//  KnobView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

@IBDesignable public class KnobView: UIView, Knob {
    
    private var _color: UIColor = UIColor.white
    @IBInspectable public var color: UIColor {
        get {
            return _color
        }
        set {
            _color = newValue
            setNeedsDisplay()
        }
    }
    
    private var _borderColor: UIColor = UIColor.lightGray
    @IBInspectable public var borderColor: UIColor {
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            setNeedsDisplay()
        }
    }

    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            setNeedsDisplay()
        }
    }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    public override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let borderFrame = bounds.insetBy(dx: borderWidth / 2.0,  dy: borderWidth / 2.0)
        context.setFillColor(color.cgColor)
        context.addEllipse(in: borderFrame)
        context.fillPath()
        context.setLineWidth(borderWidth)
        context.setStrokeColor(borderColor.cgColor)
        context.addEllipse(in: borderFrame)
        context.strokePath()
        
    }



    
}
