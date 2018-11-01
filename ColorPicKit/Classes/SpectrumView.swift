//
//  SpectrumView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/25/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit


class SpectrumView: UIView {
    
    // MARK: Variables
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            if _borderColor != newValue {
                _borderColor = newValue
                self.layer.borderColor = newValue.cgColor
            }
        }
    }
    
    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            if _borderWidth != newValue {
                _borderWidth = newValue
                self.layer.borderWidth = newValue
            }
        }
    }
    
    
    fileprivate var imageData: [GradientData] = [GradientData]()
    fileprivate var imageDataLength: Int = 0
    fileprivate var radialImage: CGImage? = nil
    
    
    // MARK: Private methods
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        updateGradient()
    }
    override open func draw(_ rect: CGRect) {
        
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
            //            CGContextDrawImage(context, wheelFrame, radialImage)
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
                let rgb = rgbaFor(point: point)
                let gradientData = GradientData(red: UInt8(rgb.red * CGFloat(255)),
                                                green: UInt8(rgb.green * CGFloat(255)),
                                                blue: UInt8(rgb.blue * CGFloat(255)))
                imageData.append(gradientData)
            }
        }
        
        let bitmapInfo: CGBitmapInfo = []
        
        let callback: CGDataProviderReleaseDataCallback = { _,_,_  in
            
        }
        if let dataProvider = CGDataProvider(dataInfo: nil, data: &imageData, size: dataLength, releaseData: callback) {
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let renderingIntent = CGColorRenderingIntent.defaultIntent
            radialImage = CGImage(width: width, height: height, bitsPerComponent: 8, bitsPerPixel: 24, bytesPerRow: width * 3, space: colorSpace, bitmapInfo: bitmapInfo, provider: dataProvider, decode: nil, shouldInterpolate: true, intent: renderingIntent)
        }
        setNeedsDisplay()
    }
    
    // MARK: Public methods
    func rgbaFor(point: CGPoint) -> RGBA {
        print("child class must implement")
        return UIColor.clear.rgba()
    }
    
    
}
