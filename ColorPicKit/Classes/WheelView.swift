//
//  WheelView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/25/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

class WheelView: UIView {
    
    @IBInspectable public var borderWidth: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable public var borderColor: UIColor = UIColor.darkGray {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    @IBInspectable public var inset: CGFloat = 8.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var _brightness: CGFloat = 1.0
    @IBInspectable public var brightness: CGFloat {
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
    
    private var _radius: CGFloat = 0
    var radius: CGFloat{
        get {
            return _radius
        }
        set {
            if _radius != newValue {
                _radius = newValue
                setNeedsDisplay()
            }
        }
    }
    fileprivate var imageData = [GradientData]()
    fileprivate var imageDataLength = Int(0)
    fileprivate var radialImage: CGImage? = nil
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
    }
    
    
    
    func colorForPoint(_ point: CGPoint) -> RGBA {
        //print("point: \(point) bounds: \(bounds)")
        let center = CGPoint(x: radius, y: radius)
        let angle = atan2(point.x - center.x, point.y - center.y) + CGFloat.pi
        let dist = pointDistance(point, CGPoint(x: center.x, y: center.y))
        var hue  = angle / CGFloat.pi * 2.0
        hue = min(hue, 1.0 - 0.0000001)
        hue = max(hue, 0.0)
        
        var sat = dist / radius
        
        sat = min(sat, 1.0)
        sat = max(sat, 0.0)
        //let rgb = UIColor.hsbaToRGBA(hsb: (hue, sat, brightness))
        let rgba = UIColor.hsbaToRGBA(hsba: HSBA(hue: hue, saturation: sat, brightness: brightness))
        return rgba
    }
    
    func pointForColor(color: UIColor) -> CGPoint {
        let hsba = color.hsba()
        let angle = (hsba.hue * CGFloat.pi * 2.0) + CGFloat.pi / 2.0
        let distance = radius * hsba.saturation
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let x = center.x + distance * cos(angle)
        let y = center.y + distance * sin(angle)
        return CGPoint(x: x, y: y)
    }
    
    func pointDistance(_ p1: CGPoint, _ p2: CGPoint) ->  CGFloat {
        let aSquared = (p1.x - p2.x) * (p1.x - p2.x)
        let bSquared = (p1.y - p2.y) * (p1.y - p2.y)
        let root = sqrt(aSquared + bSquared)
        return root
    }
    
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let minDimension = min(bounds.size.width, bounds.size.height)
        radius = minDimension / 2.0 - 2 * inset
        updateGradient()
    }
    
    func updateGradient() {
        if bounds.width == 0 || bounds.height == 0 {
            return
        }
        radialImage = nil
        let width = Int(radius * 2.0)
        let height = Int(width)
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
    
    override open func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("no context")
            return
        }
        context.saveGState()
        
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        let wheelFrame = CGRect(x: center.x - radius,
                                y: center.y - radius,
                                
                                width: radius * 2.0,
                                height: radius * 2.0)
        
        
        let borderFrame = wheelFrame.insetBy(dx: -borderWidth / 2.0, dy: -borderWidth / 2.0)
        
        if borderWidth > 0 {
            context.setLineWidth(borderWidth)
            context.setStrokeColor(borderColor.cgColor)
            context.addEllipse(in: borderFrame)
            context.strokePath()
            
        }
        
        context.addEllipse(in: wheelFrame)
        context.clip()
        if let radialImage = radialImage {
            context.draw(radialImage, in: wheelFrame)
        }
        context.restoreGState()
    }
    
    // MARK: Public methods
    func rgbaFor(point: CGPoint) -> RGBA {
        print("child class must implement")
        return UIColor.clear.rgba()
    }

    
    
}
