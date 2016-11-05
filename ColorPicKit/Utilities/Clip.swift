//
//  Clip.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/4/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import UIKit

func clip(_ value: CGFloat) -> CGFloat {
    return max(0.0, min(1.0, value))
}

func closeEnough(value: CGFloat, expected: CGFloat, tolerance: CGFloat = 0.01) -> Bool {
    let min = clip(expected - tolerance)
    let max = clip(expected + tolerance)
    return min <= value && value <= max
}

func by360(_ value: CGFloat) -> CGFloat {
    return value / 360.0
}

func by255(_ value: CGFloat) -> CGFloat {
    return value / 255.0
}

func by100(_ value: CGFloat) -> CGFloat {
    return value / 100.0
}


