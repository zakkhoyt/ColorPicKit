//
//  VideoCaptureView.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/13/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit
import AVFoundation

typealias VideoCaptureViewDidUpdate = (_ pixelBuffer: CVPixelBuffer) -> Void

class VideoCaptureView: UIView {
    
    
    var pixelBufferCallback: VideoCaptureViewDidUpdate? = nil
//    var pixelBuffer: CVPixelBuffer? = nil
//    var pixelBufferSize: CGSize? = nil

    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var videoInput: AVCaptureDeviceInput!

    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if previewLayer == nil {
            setupCaptureSession()
        }
        previewLayer?.frame = self.bounds
        
    }
    
    private func setupCaptureSession() {
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {
            self.backgroundColor = UIColor.lightGray
            //alert(title: "Woops!", message: "Your device doesn't seem to have a camera. To get the most value, use this app on a device with a camera.")
            print("Whoops! Your device doesn't seem to have a camera")
            assert(false)
            return
        }
        
        self.backgroundColor = UIColor.darkGray
        captureSession = AVCaptureSession()
        
        // Set input
        videoInput = videoInputFor(position: .back)
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            print("Failed to add video input")
            return
        }
        
//        // Set output (preview layer)
//        let offset = CGFloat(20.0)
//        let x = offset
//        let y = CGFloat(82) + offset
//        let w = view.bounds.size.width - 2*offset
//        let h = view.bounds.size.height - (CGFloat(82) + 2*offset + (tabBarController?.tabBar.bounds.size.height)!)
//        let frame = CGRect(x: x, y: y, width: w, height: h)
        
//        // Make crosshair view sit on top of preview layer
//        topLayoutConstraint.constant = y
//        leadingLayoutConstraint.constant = x
//        trailingLayoutConstraint.constant = x
//        bottomLayoutConstraint.constant = offset + (tabBarController?.tabBar.bounds.size.height)!
//        crosshairRenderingView.touchPoint = CGPoint(x: w/2.0, y: h/2.0)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.bounds
        previewLayer.masksToBounds = true
        //previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.videoGravity = AVLayerVideoGravity(rawValue: convertFromAVLayerVideoGravity(AVLayerVideoGravity.resizeAspect))
        

        self.layer.addSublayer(previewLayer)
        
        // Set output (pixel callback)
        let pixelOutput = AVCaptureVideoDataOutput()
        //pixelOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable: Int(kCVPixelFormatType_32BGRA)] as! [String : Any]
        pixelOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        pixelOutput.alwaysDiscardsLateVideoFrames = true
        pixelOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        if captureSession.canAddOutput(pixelOutput) {
            captureSession.addOutput(pixelOutput)
        } else {
            print("Failed to add pixel buffer output")
            return
        }
        
        captureSession.startRunning()
    }
    
    func videoInputFor(position: AVCaptureDevice.Position) -> AVCaptureDeviceInput? {
        
        guard let videoCaptureDevice = captureDeviceFor(position: position) else {
            return nil
        }

        // White balance
        if videoCaptureDevice.isWhiteBalanceModeSupported(AVCaptureDevice.WhiteBalanceMode.locked) {
            do {
                try videoCaptureDevice.lockForConfiguration()
                videoCaptureDevice.whiteBalanceMode = .locked
                videoCaptureDevice.unlockForConfiguration()
            } catch let error as NSError {
                print("Failed to lock white balance: " + error.localizedDescription)
            }
        }
        
        // Assign to input
        do {
            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            return videoInput
        } catch let error as NSError{
            print("Failed to create AVCaptureDeviceInput from AVCaptureInput: " + error.localizedDescription)
        }
        
        return nil
    }
    
    func captureDeviceFor(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        if #available(iOS 10.0, *) {
            let deviceTypes = [AVCaptureDevice.DeviceType.builtInDuoCamera, AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera]
            let discovery = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: AVMediaType(rawValue: convertFromAVMediaType(AVMediaType.video)), position: AVCaptureDevice.Position.unspecified)
            let cameras = discovery.devices
            
            //if let cameras = cameras {
                if position == .front {
                    for camera in cameras {
                        if camera.position == .front {
                            return camera
                        }
                    }
                } else if position == .back {
                    // Prefer duo camera
                    for camera in cameras {
                        if camera.deviceType == AVCaptureDevice.DeviceType.builtInDuoCamera {
                            return camera
                        }
                    }
                    
                    for camera in cameras {
                        if camera.deviceType == AVCaptureDevice.DeviceType.builtInWideAngleCamera {
                            return camera
                        }
                    }
                    
                    return cameras.first
                }
//            }
        } else {
            // Fallback on earlier versions
        }
        
        return nil
        
    }
    
}

extension VideoCaptureView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        print("captureOutput")
//        
//        
//        // See if enough time has elapsed to refresh the color
//        let duration = 0.25
//        let now = Date()
//        if now.timeIntervalSince(throttleDate) < duration {
//            return
//        }
//        throttleDate = now
//        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        
//        if let _ = self.pixelBuffer {
//            CVPixelBufferUnlockBaseAddress(self.pixelBuffer!, [])
//        }
        
//        self.pixelBuffer = imageBuffer
//        
//        if let pixelBuffer = self.pixelBuffer {
//            CVPixelBufferLockBaseAddress(pixelBuffer, [])
//            
//            let width = CVPixelBufferGetWidth(pixelBuffer)
//            let height = CVPixelBufferGetHeight(pixelBuffer)
//            self.pixelBufferSize = CGSize(width: width, height: height)
//            
//            CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
//            
//        }
        
        
        pixelBufferCallback?(imageBuffer)
        
//
//        CVPixelBufferLockBaseAddress(imageBuffer, [])
//        let baseAddress = CVPixelBufferGetBaseAddress(imageBuffer)
//        let width = CVPixelBufferGetWidth(imageBuffer)
//        let height = CVPixelBufferGetHeight(imageBuffer)
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
//        
//        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
//            Console.error(message: "Failed to create context for pixel buffer")
//            return
//        }
//        
//        let cgImage = context.makeImage()
//        
//        CVPixelBufferUnlockBaseAddress(imageBuffer, [])
//        
//        let image = UIImage(cgImage: cgImage!)
//        
//        let halfWidth = Int(Double(width) / 2.0)
//        let halfHeight = Int(Double(height) / 2.0)
//        
//        let point = CGPoint(x: halfWidth, y: halfHeight)
//        if let uiColor = image.getPixelColor(point: point) {
//            let color = ColorService.shared.closestColor(uiColor: uiColor)
//            colorView.color = color
//        }
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVLayerVideoGravity(_ input: AVLayerVideoGravity) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVMediaType(_ input: AVMediaType) -> String {
	return input.rawValue
}
