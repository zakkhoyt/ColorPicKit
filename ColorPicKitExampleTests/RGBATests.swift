//
//  RGBATests.swift
//  ColorPicKitExample
//
//  Created by Zakk Hoyt on 11/4/16.
//  Copyright © 2016 Zakk Hoyt. All rights reserved.
//

import XCTest
@testable import ColorPicKitExample

class RGBATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    // MARK: constructors
    func testInit() {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        let steps = 10
        let perCycle: CGFloat = 1.0 / CGFloat(steps)
        for i in 0...steps {
            
            let value: CGFloat = perCycle * CGFloat(i)
            red = value
            green = value
            blue = value
            alpha = value
            
            let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
            
            XCTAssert(rgba.red == red)
            XCTAssert(rgba.green == green)
            XCTAssert(rgba.blue == blue)
            XCTAssert(rgba.alpha == alpha)
        }
        
        // Test clipping to 0.0
        do {
            red = -0.1
            green = -0.1
            blue = -0.1
            alpha = -0.1
            
            let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
            
            XCTAssert(rgba.red == 0.0)
            XCTAssert(rgba.green == 0.0)
            XCTAssert(rgba.blue == 0.0)
            XCTAssert(rgba.alpha == 0.0)
        }
        
        // Test clipping to 1.0
        do {
            red = 1.1
            green = 1.1
            blue = 1.1
            alpha = 1.1
            
            let rgba = RGBA(red: red, green: green, blue: blue, alpha: alpha)
            
            XCTAssert(rgba.red == 1.0)
            XCTAssert(rgba.green == 1.0)
            XCTAssert(rgba.blue == 1.0)
            XCTAssert(rgba.alpha == 1.0)
        }

    }
    

    
    // MARK: instance methods
    func testColor() {
        // Test a few known color
        
        func rgbaAgainstUIColor(rgba: RGBA) {
            let color = rgba.color()
            
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            XCTAssert(rgba.red == red)
            XCTAssert(rgba.green == green)
            XCTAssert(rgba.blue == blue)
            XCTAssert(rgba.alpha == alpha)
        }
        
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.0))
        rgbaAgainstUIColor(rgba: RGBA(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0))

    }
    
    func testRGBAToHSBA() {
        
        func rgbaToHSBA(rgba: RGBA, knownHSBA: HSBA) {
            let hsba = rgba.hsba()
            
            print("hsba1: \(hsba.stringFor(type: .baseSixteen)), hsba1: \(knownHSBA.stringFor(type: .baseSixteen))")
            XCTAssert(closeEnough(value: hsba.hue, expected: knownHSBA.hue), "\nhue \(hsba.hue) != \(knownHSBA.hue)")
            XCTAssert(closeEnough(value: hsba.saturation, expected: knownHSBA.saturation), "\nsaturation \(hsba.saturation) != \(knownHSBA.saturation)")
            XCTAssert(closeEnough(value: hsba.brightness, expected: knownHSBA.brightness), "\nbrightness \(hsba.brightness) != \(knownHSBA.brightness)")
        }
        
        // values taken from http://colorizer.org/
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(255), blue: by255(255))
            let hsba = HSBA(hue: by360(0), saturation: by100(0), brightness: by100(100))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }

        
        do {
            let rgba = RGBA(red: by255(5), green: by255(5), blue: by255(5))
            let hsba = HSBA(hue: by360(0), saturation: by100(0), brightness: by100(1.9))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }
        
        do {
            let rgba = RGBA(red: by255(50), green: by255(100), blue: by255(150))
            let hsba = HSBA(hue: by360(210), saturation: by100(66.67), brightness: by100(58.82))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }
        
        do {
            let rgba = RGBA(red: by255(127), green: by255(255), blue: by255(0))
            let hsba = HSBA(hue: by360(90.12), saturation: by100(100), brightness: by100(100))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(0), blue: by255(51))
            let hsba = HSBA(hue: by360(348), saturation: by100(100), brightness: by100(100))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }
        
        do {
            let rgba = RGBA(red: by255(196), green: by255(58), blue: by255(247))
            let hsba = HSBA(hue: by360(283.81), saturation: by100(76.52), brightness: by100(96.86))
            rgbaToHSBA(rgba: rgba, knownHSBA: hsba)
        }
    }
    
    func testRGBAToHSLA() {
        
        func rgbaToHSLA(rgba: RGBA, knownHSLA: HSLA) {
            let hsla = rgba.hsla()
            
            print("hsla1: \(hsla.stringFor(type: .baseSixteen)), hsla1: \(knownHSLA.stringFor(type: .baseSixteen))")
            XCTAssert(closeEnough(value: hsla.hue, expected: knownHSLA.hue), "\nhue \(hsla.hue) != \(knownHSLA.hue)")
            XCTAssert(closeEnough(value: hsla.saturation, expected: knownHSLA.saturation), "\nsaturation \(hsla.saturation) != \(knownHSLA.saturation)")
            XCTAssert(closeEnough(value: hsla.lightness, expected: knownHSLA.lightness), "\nlightness \(hsla.lightness) != \(knownHSLA.lightness)")
        }
        
        // values taken from http://colorizer.org/
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(255), blue: by255(255))
            let hsla = HSLA(hue: by360(0), saturation: by100(0), lightness: by100(100))
            rgbaToHSLA(rgba: rgba, knownHSLA: hsla)
        }
        
        do {
            let rgba = RGBA(red: by255(216), green: by255(217), blue: by255(219))
            let hsla = HSLA(hue: by360(220), saturation: by100(4), lightness: by100(85.29))
            rgbaToHSLA(rgba: rgba, knownHSLA: hsla)
        }
        
        do {
            let rgba = RGBA(red: by255(14), green: by255(77), blue: by255(45))
            let hsla = HSLA(hue: by360(149.52), saturation: by100(69.23), lightness: by100(17.84))
            rgbaToHSLA(rgba: rgba, knownHSLA: hsla)
        }
        
        do {
            let rgba = RGBA(red: by255(0), green: by255(17), blue: by255(0))
            let hsla = HSLA(hue: by360(120), saturation: by100(100), lightness: by100(3.33))
            rgbaToHSLA(rgba: rgba, knownHSLA: hsla)
        }
    }
    
    func testRGBAToCMYKA() {
        
        func rgbaToCMYKA(rgba: RGBA, knownCMYKA: CMYKA) {
            let cmyka = rgba.cmyka()
            
            print("cmyka1: \(cmyka.stringFor(type: .baseSixteen)), cmyka1: \(knownCMYKA.stringFor(type: .baseSixteen))")
            XCTAssert(closeEnough(value: cmyka.cyan, expected: knownCMYKA.cyan), "\ncyan \(cmyka.cyan) != \(knownCMYKA.cyan)")
            XCTAssert(closeEnough(value: cmyka.magenta, expected: knownCMYKA.magenta), "\nmagenta \(cmyka.magenta) != \(knownCMYKA.magenta)")
            XCTAssert(closeEnough(value: cmyka.yellow, expected: knownCMYKA.yellow), "\nyellow \(cmyka.yellow) != \(knownCMYKA.yellow)")
            XCTAssert(closeEnough(value: cmyka.black, expected: knownCMYKA.black), "\nblack \(cmyka.black) != \(knownCMYKA.black)")
        }
        
        // values taken from http://colorizer.org/
        
        do {
            let rgba = RGBA(red: by255(0), green: by255(0), blue: by255(0))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(0), yellow: by100(0), black: by100(100))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(1), green: by255(1), blue: by255(1))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(0), yellow: by100(0), black: by100(99.61))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(1), green: by255(1), blue: by255(255))
            let cmyka = CMYKA(cyan: by100(99.61), magenta: by100(99.61), yellow: by100(0), black: by100(0))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(0), blue: by255(255))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(100), yellow: by100(0), black: by100(0))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(255), blue: by255(0))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(0), yellow: by100(100), black: by100(0))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(187), green: by255(64), blue: by255(45))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(65.78), yellow: by100(75.94), black: by100(26.67))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }
        
        do {
            let rgba = RGBA(red: by255(255), green: by255(255), blue: by255(255))
            let cmyka = CMYKA(cyan: by100(0), magenta: by100(0), yellow: by100(0), black: by100(0))
            rgbaToCMYKA(rgba: rgba, knownCMYKA: cmyka)
        }

    }
    
//    func testRGBAToYUVA() {
//        
//        func rgbaToYUVA(rgba: RGBA, knownYUVA: YUVA) {
//            let yuva = rgba.yuva()
//            
//            print("yuva1: \(yuva.stringFor(type: .baseOne)), yuva1: \(knownYUVA.stringFor(type: .baseOne))")
//            XCTAssert(closeEnough(value: yuva.y, expected: knownYUVA.y), "\ny \(yuva.y) != \(knownYUVA.y)")
//            XCTAssert(closeEnough(value: yuva.u, expected: knownYUVA.u), "\nu \(yuva.u) != \(knownYUVA.u)")
//            XCTAssert(closeEnough(value: yuva.v, expected: knownYUVA.v), "\nv \(yuva.v) != \(knownYUVA.v)")
//        }
//        
//        // values taken from http://colorizer.org/
//        
//        
////        do {
////            let rgba = RGBA(red: by255(0), green: by255(134.93), blue: by255(0))
////            let yuva = YUVA(y: 0.3, u: 0.5 + 0.5, v: -0.17 + 0.5)
////            rgbaToYUVA(rgba: rgba, knownYUVA: yuva)
////        }
//        
//
//        
////        do {
////            let rgba = RGBA(red: by255(255), green: by255(0), blue: by255(0))
////            let yuva = YUVA(y: 0.3, u: 0.5, v: -0.17)
////            rgbaToYUVA(rgba: rgba, knownYUVA: yuva)
////        }
//        do {
//            let rgba = RGBA(red: by255(255), green: by255(0), blue: by255(0))
//            let yuva = YUVA(y: 0.3, u: -0.17, v: 0.5)
//            rgbaToYUVA(rgba: rgba, knownYUVA: yuva)
//        }
//
//
//    }
//    
    func testYUVA() {
        let yuva1 = YUVA(y: 0.3, u: 0.33, v: 1.0)
        print("yuva1: " + yuva1.stringFor(type: .baseOne))
        let rgba = yuva1.rgba()
        print("rgba: " + rgba.stringFor(type: .baseOne))
        let yuva2 = rgba.yuva()
        print("yuva2: " + yuva2.stringFor(type: .baseOne))
        
        print("Done with YUVA")
    }
    
    // MARK: class functions
    
    
    // MARK: ColorString
    
    
    // MARK: UIColor 
    
    
    // MARK: UIImage
}
