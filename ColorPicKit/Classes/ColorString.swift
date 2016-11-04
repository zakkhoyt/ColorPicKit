//
//  ColorString.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 10/30/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import Foundation


protocol ColorString {
    func stringFor(type: ColorStringType) -> String
}
