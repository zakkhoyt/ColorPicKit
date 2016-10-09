//
//  ColorControl.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

protocol ColorControl {
    
    var roundedCorners: Bool { get set }
    var borderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
    
    var intrinsicContentSize: CGSize  { get }
    
    func touchDown()
    func touchUpInside()
    func valueChanged()
}
