//
//  KnobbedControl.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/8/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

protocol KnobbedControl: ColorControl {
    var knobView: KnobView { get set }
    var knobSize: CGSize  { get set }
    var colorKnob: Bool { get set }
}
