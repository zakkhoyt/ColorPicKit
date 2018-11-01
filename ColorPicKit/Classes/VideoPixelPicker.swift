//
//  VideoPixelPicker.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/13/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

private let invalidPositionValue = CGFloat(-1.0)

@IBDesignable public class VideoPixelPicker: UIControl, PositionableControl, Colorable {
    
    
    // MARK: Variables
    private var _position: CGPoint = CGPoint(x: invalidPositionValue, y: invalidPositionValue)
    @IBInspectable public var position: CGPoint {
        get {
            return _position
        }
        set {
            // We don't want to accept infinities or NaN
            if abs(newValue.x) == CGFloat.infinity ||
                abs(newValue.y) == CGFloat.infinity {
                return
            }
            if newValue.x == CGFloat.nan || newValue.y == CGFloat.nan {
                return
            }
            
            if _position != newValue {
                updatePositionFrom(point: newValue)
                updateKnob()
            }
        }
    }
    
    private var _knobView: KnobView = KnobView()
    public var knobView: KnobView {
        get {
            return _knobView
        }
        set {
            _knobView = newValue
            updateKnob()
        }
    }
    
    private var _knobSize: CGSize = CGSize(width: 30, height: 30)
    @IBInspectable public var knobSize: CGSize {
        get {
            return _knobSize
        }
        set {
            _knobSize = newValue
            updateKnob()
        }
    }
    
    private var _colorKnob: Bool = true
    @IBInspectable public var colorKnob: Bool {
        get {
            return _colorKnob
        }
        set {
            _colorKnob = newValue
            updateKnob()
        }
    }
    
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    private var _borderWidth: CGFloat = 0.5
    @IBInspectable public var borderWidth: CGFloat{
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            self.layer.borderWidth = newValue
        }
    }
    
    private var _roundedCornders: Bool = false
    @IBInspectable public var roundedCorners: Bool {
        get {
            return _roundedCornders
        }
        set {
            _roundedCornders = newValue
            if _roundedCornders == false {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 0
            } else {
                self.layer.masksToBounds = true
                self.layer.cornerRadius = 40.0
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: bounds.width)
        }
    }
    
    
    
    private var _color: UIColor = .white
    /*@IBInspectable*/ public var color: UIColor {
        get {
            guard let pixelBuffer = self.pixelBuffer else {
                print("No pixel buffer to calc frame")
                return _color
            }

            if self.pixelBufferSize == nil {
                print("No pixel buffer size")
                return _color
            }

//            guard let pixelBufferSize = self.pixelBufferSize else {
//                print("No pixel buffer size")
//                return _color
//            }
            
            
//            let frame = frameForImageView()
//            let knobPoint = knobViewPointWithinImage()
//            
//            var x = knobPoint.x / frame.size.width
//            var y = knobPoint.y / frame.size.height
//            
//            x = x * pixelBufferSize.width
//            y = y * pixelBufferSize.height
//            
//            let point = CGPoint(x: x, y: y)
//            
//            if let color = pixelBuffer.getColorAt(point: point) {
//                return color
//            } else {
//                print("Failed to get color from pixelBuffer")
//            }
//            
//            return _color
            
            
            let point = knobViewPointWithinImage()
            
            if let color = pixelBuffer.getColorAt(point: point) {
                return color
            } else {
                print("Failed to get color from pixelBuffer")
            }
            
            return _color
        }
    }
    
    private var videoCaptureView = VideoCaptureView()
    private var pixelBuffer: CVPixelBuffer? = nil
    private var pixelBufferSize: CGSize? = nil


    
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    fileprivate func commonInit() {
        self.backgroundColor = UIColor.clear
        
        
        self.roundedCorners = _roundedCornders
        self.borderWidth = _borderWidth
        self.borderColor = _borderColor
        
        
        // ImageView
        videoCaptureView.contentMode = .scaleAspectFit
        //videoCaptureView.image = image
        videoCaptureView.clipsToBounds = true
        videoCaptureView.pixelBufferCallback = { pixelBuffer in
            self.pixelBuffer = pixelBuffer
            
            // Get size from pixel buffer
            CVPixelBufferLockBaseAddress(pixelBuffer, [])
            let width = CVPixelBufferGetWidth(pixelBuffer)
            let height = CVPixelBufferGetHeight(pixelBuffer)
            self.pixelBufferSize = CGSize(width: width, height: height)
            CVPixelBufferUnlockBaseAddress(pixelBuffer, [])

            self.updateKnob()
        }
        addSubview(videoCaptureView)
        
        
        // KnobView
        updateKnobSize()
        addSubview(knobView)
        
//        // Pan gesture
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHappened))
//        panGesture.minimumNumberOfTouches = 1
//        panGesture.maximumNumberOfTouches = 1
//        panGesture.delegate = self
//        self.addGestureRecognizer(panGesture)
//        
//        // Long press gesture
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHappened))
//        self.addGestureRecognizer(longPressGesture)
        
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        
        // ImageView
        videoCaptureView.frame = frameForImageView()
        
        // Position
        if position.x == invalidPositionValue || position.y == invalidPositionValue {
            position = CGPoint(x: videoCaptureView.frame.midX, y: videoCaptureView.frame.midY)
        }
        
        // KnobView
        updateKnob()
    }
    
    
    // MARK: Gestures
    
    fileprivate var knobStart: CGPoint!
    fileprivate var panStart: CGPoint!
    
    @objc private func panGestureHappened(sender: UIPanGestureRecognizer) {
        
        // Position
        if sender.state == .began {
            knobStart = knobView.center
            panStart = sender.location(in: self)
        }
        
        let deltaX = sender.location(in: self).x - panStart.x
        let newX = knobStart.x + deltaX
        
        let deltaY = sender.location(in: self).y - panStart.y
        let newY = knobStart.y + deltaY
        
        let point = CGPoint(x: newX, y: newY)
        knobView.center = point
        
        // Events
        if sender.state == .began {
            touchesHappened(point)
            touchDown()
        } else if sender.state == .changed {
            touchesHappened(point)
        } else if sender.state == .ended {
            touchesHappened(point)
            touchUpInside()
        }
    }
    
    @objc private func longPressGestureHappened(sender: UILongPressGestureRecognizer) {
        
        let point = sender.location(in: self)
        
        if sender.state == .began {
            touchesHappened(point)
            touchDown()
        } else if sender.state == .changed {
            touchesHappened(point)
        } else if sender.state == .ended {
            touchesHappened(point)
            touchUpInside()
        }
    }
    
    
    private func touchesHappened(_ point: CGPoint) {
        updatePositionFrom(point: point)
        updateKnob()
        valueChanged()
    }
    
    
    func touchDown() {
        self.sendActions(for: .touchDown)
    }
    
    func touchUpInside() {
        self.sendActions(for: .touchUpInside)
    }
    
    func valueChanged() {
        self.sendActions(for: .valueChanged)
    }
    
    
    // MARK: Private methods
    
    private func updateKnob() {
        updateKnobSize()
        updateKnobPosition()
        updateKnobColor()
    }
    
    private func updateKnobSize() {
        let center = knobView.center
        knobView.bounds = CGRect(x: 0, y: 0, width: knobSize.width, height: knobSize.height)
        knobView.center = center
    }
    
    private func updateKnobPosition() {
        
        
        knobView.center = position
    }
    
    private func updateKnobColor() {
        if colorKnob {
            knobView.color = color
        } else {
            knobView.color = .white
        }
    }
    
    
    
    private func frameForImageView() -> CGRect {

        guard let pixelBufferSize = self.pixelBufferSize else {
            print("No pixel buffer size")
            return self.bounds
        }
        

        
        if pixelBufferSize.width == 0 || pixelBufferSize.height == 0 {
            return bounds
        }
        
        let imageRatio = pixelBufferSize.width / pixelBufferSize.height
        let ratio = self.bounds.width / self.bounds.height
        
        if imageRatio > ratio {
            // image is wider than self. Bars on top/bottom
            let w = bounds.width
            let h = w / (pixelBufferSize.width / pixelBufferSize.height)
            let x = CGFloat(0)
            let y = (bounds.height - h) / 2.0
            return CGRect(x: x, y: y, width: w, height: h)
        } else {
            // image is taller than self. Bars on left/right
            let h = bounds.height
            let w = h / (pixelBufferSize.height / pixelBufferSize.width)
            let x = (bounds.width - w) / 2.0
            let y = CGFloat(0)
            return CGRect(x: x, y: y, width: w, height: h)
        }

        
        //return self.bounds
    }
    
    
    private func updatePositionFrom(point: CGPoint) {
        let imageFrame = videoCaptureView.frame
        
        var mPoint = point
        if mPoint.x < imageFrame.origin.x {
            mPoint.x = imageFrame.origin.x
        }
        
        if mPoint.x > imageFrame.origin.x + imageFrame.size.width - 1.0 {
            mPoint.x = imageFrame.origin.x + imageFrame.size.width - 1.0
        }
        
        if mPoint.y < imageFrame.origin.y {
            mPoint.y = imageFrame.origin.y
        }
        
        if mPoint.y > imageFrame.origin.y + imageFrame.size.height - 1.0 {
            mPoint.y = imageFrame.origin.y + imageFrame.size.height - 1.0
        }
        //print("point: \(point) mPoint: \(mPoint)")
        _position = mPoint
    }
    
    private func knobViewPointWithinImage() -> CGPoint {
        
        guard let pixelBuffer = self.pixelBuffer else {
            print("pixelBuffer is nil")
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
        
        let knobCenter = knobView.center
        let adjustedPoint = self.convert(knobCenter, to: videoCaptureView)
        let pixelBufferSize = UIImage.getSizeOf(pixelBuffer: pixelBuffer)
        let ratioX = adjustedPoint.x / videoCaptureView.bounds.width
        let ratioY = adjustedPoint.y / videoCaptureView.bounds.height
        let x = ratioX * (pixelBufferSize.width - 1.0)
        let y = ratioY * (pixelBufferSize.height - 1.0)
        let point = CGPoint(x: x, y: y)
        
        //        print("-----------------")
        //        print("adjustedPoint: \(adjustedPoint)")
        //        print("point: \(point)")
        //        print("pixelBufferImage.size: \(pixelBufferImage.size)")
        
        return point
        
    }

}

extension VideoPixelPicker: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
