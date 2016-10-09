//
//  UIImage+Utilities.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 9/24/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

extension UIImage {
    
    func getPixelColor(point: CGPoint) -> UIColor? {
        
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let length = CFDataGetLength(pixelData)
        let bytesPerRow = Int(length / Int(size.height))
        
        let x = Int(point.x)
        let y = Int(point.y)

        let index = y * bytesPerRow + x * 4
        
        if index < 0 {
            return nil
        } else if index > Int(Int(size.width) * Int(size.height) * 4) {
            return nil
        }
        
//        print("w:\(Int(size.width)) h:\(Int(size.height))")
//        print("x:\(Int(point.x)) y:\(Int(point.y)) index:\(index)")
        let b = CGFloat(data[index]) / CGFloat(255.0)
        let g = CGFloat(data[index+1]) / CGFloat(255.0)
        let r = CGFloat(data[index+2]) / CGFloat(255.0)
        let a = CGFloat(data[index+3]) / CGFloat(255.0)
        
//        print("r:\(r) g:\(g) b:\(b) a:\(a)")
    
        return UIColor(red: r, green: g, blue: b, alpha: a)
        
        
    }
    
    // Convert self to pixel buffer then index the point
    func getPixelColorFromPixelBuffer(point: CGPoint) -> UIColor? {
    
        guard let imageBuffer = self.pixelBuffer() else {
            print("could not create pixelBuffer")
            return nil
        }
    
        
        CVPixelBufferLockBaseAddress(imageBuffer, [])
        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
        let width = CVPixelBufferGetWidth(imageBuffer)
        let height = CVPixelBufferGetHeight(imageBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            print("Failed to create context for pixel buffer")
            return nil
        }
        
        let cgImage = context.makeImage()
        
        CVPixelBufferUnlockBaseAddress(imageBuffer, [])
        
        let image = UIImage(cgImage: cgImage!)
        
        if let color = image.getPixelColor(point: point) {
            return color
        }

        return nil
    }
    
    
    
    
    
    // Draw self.cgImage into a pixel buffer
    func pixelBuffer() -> CVPixelBuffer? {
        
        guard let cgImage = self.cgImage else {
            print("image has no cgImage")
            return nil
        }
        
        let width = Int(cgImage.width)
        let height = Int(cgImage.height)
        

        let attributes: [NSString : NSNumber] = [
            kCVPixelBufferCGImageCompatibilityKey as NSString: true as NSNumber,
            kCVPixelBufferCGBitmapContextCompatibilityKey as NSString: true as NSNumber
        ]
        
        var pixelBuffer: CVPixelBuffer? = nil
        
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         width,
                                         height,
                                         kCVPixelFormatType_32ARGB,
                                         attributes as CFDictionary,
                                         &pixelBuffer)
        assert(status == kCVReturnSuccess && pixelBuffer != nil)
        
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, [])
        
        let pxdata = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        
    
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        let context =  CGContext(
            data: pxdata,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!),
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue)

        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context?.draw(cgImage, in: frame)

        CVPixelBufferUnlockBaseAddress(pixelBuffer!, [])
        return pixelBuffer!
    }
    
    class func getColorAt(point: CGPoint, in pixelBuffer: CVPixelBuffer) -> UIColor? {
        
        // We don't want to accept infinities or NaN
        if fabs(point.x) == CGFloat.infinity ||
            fabs(point.y) == CGFloat.infinity {
            print("Cannot get color at point (infinity): \(point)")
            return nil
        }
        if point.x == CGFloat.nan || point.y == CGFloat.nan {
            print("Cannot get color at point (NaN): \(point)")
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            print("Failed to create context for pixel buffer")
            return nil
        }
        
        let cgImage = context.makeImage()
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
        
        let image = UIImage(cgImage: cgImage!)
        
        if let color = image.getPixelColor(point: point) {
            return color
        }
        
        return nil
    }
    
    class func getSizeOf(pixelBuffer: CVPixelBuffer) -> CGSize {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        //let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        return CGSize(width: width, height: height)
        
    }
}

