//
//  HueSliderView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit



public class HueSliderView: SliderView {
    var imageData = [GradientData]()
    var imageDataLength = Int(0)
    var radialImage: CGImage? = nil

    
    
    override func drawBackground(context: CGContext) {

        
        updateGradient()
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
    
    func updateGradient() {
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
                let rgba = colorForPoint(point)
                let gradientData = GradientData(red: UInt8(rgba.red * CGFloat(255)),
                                                green: UInt8(rgba.green * CGFloat(255)),
                                                blue: UInt8(rgba.blue * CGFloat(255)))
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
    func colorForPoint(_ point: CGPoint) -> RGBA {
        
//        let hue = point.x / bounds.width
//        let rgba = UIColor.hsbaToRGBA(hsba: HSBA(hue: hue, saturation: saturation, brightness: brightness))
//        return rgba
        assert(false, "child must impelement")
        return UIColor.clear.rgba()
    }
}

