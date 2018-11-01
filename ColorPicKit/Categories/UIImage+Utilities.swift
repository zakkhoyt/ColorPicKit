//
//  UIImage+Utilities.swift
//  ColorBlind
//
//  Created by Zakk Hoyt on 9/24/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    
    // MARK: Public class functions
    public class func pixelColorOf(image: UIImage, at point: CGPoint) -> UIColor? {
        return image.pixelColorAt(point: point)
    }
    
    public class func pixelBufferOf(image: UIImage) -> CVPixelBuffer? {
        return image.pixelBuffer()
    }
    
    public class func pixelBufferPropertiesOf(image: UIImage) -> (pixelBuffer: CVPixelBuffer?, size:CGSize, bytesPerRow: Int) {
        return image.pixelBufferProperties()
    }
    
    
    public class func getSizeOf(pixelBuffer: CVPixelBuffer) -> CGSize {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
        return CGSize(width: width, height: height)
        
    }
    
    public class func getBytesPerRowOf(pixelBuffer: CVPixelBuffer) -> Int {
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
        return bytesPerRow
    }

    
    // MARK: Public methods
    
    // Creates a pixel buffer and gets the color of the specified point
    // Creating the pixel buffer is resource intensive, so if you are repeatedly calling
    // this method, it would be best to instead call pixelBuffer(), store it, and then
    // call UIImage.getColorAt(point: point, in: pixelBuffer)
    public func pixelColorAt(point: CGPoint) -> UIColor? {
        guard let pixelBuffer = self.pixelBuffer() else {
            print("Failed to convert image to pixelBuffer")
            return nil
        }
        
        return UIImage.getColorAt(point: point, in: pixelBuffer)
    }
    
    // Draw self.cgImage into a pixel buffer
    public func pixelBuffer() -> CVPixelBuffer? {
        
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
    
    
    public func pixelBufferProperties() -> (pixelBuffer: CVPixelBuffer?, size:CGSize, bytesPerRow: Int) {
        guard let pixelBuffer = self.pixelBuffer() else {
            print("Failed to convert image to pixelBuffer")
            return (nil, CGSize.zero, 0)
        }
        let size = UIImage.getSizeOf(pixelBuffer: pixelBuffer)
        let bytesPerRow = UIImage.getBytesPerRowOf(pixelBuffer: pixelBuffer)
        return (pixelBuffer, size, bytesPerRow)
    }
    
    

    
    
    // MARK: Internal methods
    
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
    

    // MARK: Internal Class functions
    
    class func getColorAt(point: CGPoint, in pixelBuffer: CVPixelBuffer) -> UIColor? {
        
        // We don't want to accept infinities or NaN
        if abs(point.x) == CGFloat.infinity ||
            abs(point.y) == CGFloat.infinity {
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

}


extension CVPixelBuffer {
    public func getColorAt(point: CGPoint) -> UIColor? {
        
        // We don't want to accept infinities or NaN
        if abs(point.x) == CGFloat.infinity ||
            abs(point.y) == CGFloat.infinity {
            print("Cannot get color at point (infinity): \(point)")
            return nil
        }
        if point.x == CGFloat.nan || point.y == CGFloat.nan {
            print("Cannot get color at point (NaN): \(point)")
            return nil
        }
        
        CVPixelBufferLockBaseAddress(self, [])
        let baseAddress = CVPixelBufferGetBaseAddress(self)
        let width = CVPixelBufferGetWidth(self)
        let height = CVPixelBufferGetHeight(self)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(self)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            print("Failed to create context for pixel buffer")
            return nil
        }
        
        let cgImage = context.makeImage()
        
        CVPixelBufferUnlockBaseAddress(self, [])
        
        let image = UIImage(cgImage: cgImage!)
        
        if let color = image.getPixelColor(point: point) {
            return color
        }
        
        return nil
    }
}

