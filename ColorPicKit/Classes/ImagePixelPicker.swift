//
//  ImagePixelPicker.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

private let invalidPositionValue = CGFloat(-1.0)
@IBDesignable public class ImagePixelPicker: UIControl, PositionableControl, Colorable {
    
    
    // MARK: Variables
    
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
    
    private var _borderColor: UIColor = .lightGray
    @IBInspectable public var borderColor: UIColor{
        get {
            return _borderColor
        }
        set {
            _borderColor = newValue
            self.layer.borderColor = newValue.cgColor
            knobView.borderColor = newValue
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
            knobView.borderWidth = newValue
        }
    }
    
    public override var intrinsicContentSize: CGSize  {
        get {
            return CGSize(width: bounds.width, height: bounds.width)
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
    
    private var _color: UIColor = .white
    /*@IBInspectable*/ public var color: UIColor {
        get {
            guard let pixelBuffer = self.pixelBuffer else {
                print("No pixelBuffer to look at")
                return _color
            }
            
            
            let point = knobViewPointWithinImage()
            
            if let color = UIImage.getColorAt(point: point, in: pixelBuffer) {
                return color
            } else {
                print("Failed to get color from pixel buffer")
            }
            
            return _color
        }
    }
    
    
    
    private var _image: UIImage = UIImage()
    @IBInspectable public var image: UIImage {
        get {
            return _image
        }
        set {
            if _image != newValue {
                _image = newValue
                imageView.image = newValue
                self.pixelBuffer = newValue.pixelBuffer()
            }
        }
    }
    
    
    private var _position: CGPoint = CGPoint(x: invalidPositionValue, y: invalidPositionValue)
    @IBInspectable public var position: CGPoint {
        get {
            return _position
        }
        set {
            // We don't want to accept infinities or NaN
            if fabs(newValue.x) == CGFloat.infinity ||
                fabs(newValue.y) == CGFloat.infinity {
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

    
    
    private var imageView = UIImageView()
    private var pixelBuffer: CVPixelBuffer? = nil

    
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
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.clipsToBounds = true
        addSubview(imageView)

        
        // KnobView
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        updateKnobSize()
        addSubview(knobView)
    }

    
    override open func layoutSubviews() {
        super.layoutSubviews()


        // ImageView
        image = _image
        imageView.frame = frameForImageView()
        
        // Position
        if position.x == invalidPositionValue || position.y == invalidPositionValue {
            position = CGPoint(x: imageView.frame.midX, y: imageView.frame.midY)
        }

        // KnobView
        knobView.borderWidth = borderWidth
        knobView.borderColor = borderColor
        updateKnob()
    }
    
    
    // MARK: Touches
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        touchDown()
        
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesHappened(touches, with: event)
        touchUpInside()
    }
    
    private func touchesHappened(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let point = touch?.location(in: self){
            updatePositionFrom(point: point)
            updateKnob()
            valueChanged()
        }
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
        knobView.color = color
    }

    
    
    private func frameForImageView() -> CGRect {
        if image.size.width == 0 || image.size.height == 0 {
            return bounds
        }
        
        image = _image
        let imageRatio = image.size.width / image.size.height
        let ratio = self.bounds.width / self.bounds.height
        
        if imageRatio > ratio {
            // image is wider than self. Bars on top/bottom
            let w = bounds.width
            let h = w / (image.size.width / image.size.height)
            let x = CGFloat(0)
            let y = (bounds.height - h) / 2.0
            return CGRect(x: x, y: y, width: w, height: h)
        } else {
            // image is taller than self. Bars on left/right
            let h = bounds.height
            let w = h / (image.size.height / image.size.width)
            let x = (bounds.width - w) / 2.0
            let y = CGFloat(0)
            return CGRect(x: x, y: y, width: w, height: h)
        }
    }
    
    
    private func updatePositionFrom(point: CGPoint) {
        let imageFrame = imageView.frame

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
        
        guard let pixelBuffer = pixelBuffer else {
            print("pixelBuffer is nil")
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
        
        let knobCenter = knobView.center
        let adjustedPoint = self.convert(knobCenter, to: imageView)
        let pixelBufferSize = UIImage.getSizeOf(pixelBuffer: pixelBuffer)
        let ratioX = adjustedPoint.x / imageView.bounds.width
        let ratioY = adjustedPoint.y / imageView.bounds.height
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




