//
//  HueView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



class HueView: UIView {
    
    
    private var _roundedCornders: Bool = false
    @IBInspectable var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            setNeedsDisplay()
        }
    }
    
    private var _borderColor: UIColor = .darkGray
    @IBInspectable var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            layer.borderColor = newValue.cgColor
            setNeedsDisplay()
        }
    }
    
    private var _borderWidth: CGFloat = 1.0
    @IBInspectable var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            layer.borderWidth = newValue
            setNeedsDisplay()
        }
    }
    
    
    private var _saturation: CGFloat = 1.0
    open var saturation: CGFloat {
        get {
            return _saturation
        }
        set {
            if _saturation != newValue {
                _saturation = newValue
                updateGradient()
                setNeedsDisplay()
            }
        }
    }
    
    private var _brightness: CGFloat = 1.0
    open var brightness: CGFloat {
        get {
            return _brightness
        }
        set {
            if _brightness != newValue {
                _brightness = newValue
                updateGradient()
                setNeedsDisplay()
            }
        }
    }
    
    fileprivate var imageData = [GradientData]()
    fileprivate var imageDataLength = Int(0)
    fileprivate var radialImage: CGImage? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.clear
    }
    
    
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }
    override open func draw(_ rect: CGRect) {
        
        
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
            print("no context")
            return
        }
        
        context.saveGState()
        let borderFrame = bounds.insetBy(dx: -borderWidth / 2.0, dy: -borderWidth / 2.0)
        if borderWidth > 0 {
            context.setLineWidth(borderWidth)
            context.setStrokeColor(borderColor.cgColor)
            context.addRect(borderFrame)
            context.strokePath()
            
        }
        
        context.addRect(bounds)
        context.clip()
        if let radialImage = radialImage {
            context.draw(radialImage, in: bounds)
        }
        context.restoreGState()
    }
    
    fileprivate func updateGradient() {
        if bounds.width == 0 || bounds.height == 0 {
            return
        }
        radialImage = nil
        let width = Int(bounds.width)
        let height = Int(bounds.height)
        let dataLength = MemoryLayout<GradientData>.size * width * height
        
        imageData.removeAll()
        self.imageDataLength = dataLength
        
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
                let rgb = colorForPoint(point)
                let gradientData = GradientData(red: UInt8(rgb.red * CGFloat(255)),
                                                green: UInt8(rgb.green * CGFloat(255)),
                                                blue: UInt8(rgb.blue * CGFloat(255)))
                imageData.append(gradientData)
            }
        }
        
        let bitmapInfo: CGBitmapInfo = []
        
        let callback: CGDataProviderReleaseDataCallback = { _ in
            
        }
        if let dataProvider = CGDataProvider(dataInfo: nil, data: &imageData, size: dataLength, releaseData: callback) {
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let renderingIntent = CGColorRenderingIntent.defaultIntent
            radialImage = CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 24, bytesPerRow: width * 3, space: colorSpace, bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: renderingIntent)
        }
        setNeedsDisplay()
    }
    
    fileprivate func colorForPoint(_ point: CGPoint) -> RGB {
        let hue = point.x / bounds.width
        let rgb = UIColor.hsbToRGB(hsb: (hue, saturation, brightness))
        return rgb
    }

    
}
