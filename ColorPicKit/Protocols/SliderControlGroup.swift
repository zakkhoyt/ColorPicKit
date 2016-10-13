//
//  SliderControlGroup.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

protocol SliderControlGroup: ColorControl {
    var barHeight: CGFloat { set get }
    var knobSize: CGSize { set get }
}
