//
//  PositionableControl.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/10/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

protocol PositionableControl: KnobbedControl {
    var position: CGPoint { get set }
}
