//
//  DeleteButton.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 1/23/17.
//  Copyright © 2017 Zakk Hoyt. All rights reserved.
//

import UIKit

class DeleteButton: KeyPadButton {
    
    var topLine: CAShapeLayer!
    var bottomLine: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
        if let _ = self.topLine {
            self.topLine?.removeFromSuperlayer()
            self.topLine = nil
        }
        
        if let _ = self.bottomLine {
            self.bottomLine?.removeFromSuperlayer()
            self.bottomLine = nil
        }

        let lineColor = UIColor.black.cgColor
        
        topLine = CAShapeLayer()
        layer.addSublayer(topLine!)
        
        bottomLine = CAShapeLayer()
        layer.addSublayer(bottomLine!)


        
        let centerX = self.bounds.midX
        let centerY = self.bounds.midY
        
        do {
            let path = UIBezierPath()
            
            // Right triangle with an hyp of 15. Each side is 10.6, half that is 5.3
            do {
                let x: CGFloat = centerX - 5.3
                let y: CGFloat = centerY + 1
                path.move(to: CGPoint(x: x, y: y))
            }
            do {
                let x: CGFloat = centerX + 5.3
                let y: CGFloat = centerY - 10.6
                path.addLine(to: CGPoint(x: x, y: y))
            }

            topLine?.fillColor = lineColor
            topLine?.strokeColor = lineColor
            topLine.path = path.cgPath
            topLine.lineWidth = 3.0
        }
        
        do {
            let path = UIBezierPath()
            do {
                let x: CGFloat = centerX - 5.3
                let y: CGFloat = centerY - 1
                path.move(to: CGPoint(x: x, y: y))
            }
            do {
                let x: CGFloat = centerX + 5.3
                let y: CGFloat = centerY + 10.6
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            bottomLine?.fillColor = lineColor
            bottomLine?.strokeColor = lineColor
            bottomLine.path = path.cgPath
            bottomLine.lineWidth = 3.0
        }
    }
}
