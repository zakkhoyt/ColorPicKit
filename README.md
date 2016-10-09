## ColorPicKit


This repository provides several UIControls for picking colors

![IB](https://github.com/zakkhoyt/ColorPicKit/blob/master/images/all_100816.png)

- An Image color picker
- An HSB color picker wheel
- An HSB spectrum slider
- An RGB slider set
- An HSB slider set
- An CMYK slider set
- A gradient slider
- A hue slider


It also exposes a functions and data structures for working with hex strings, RGB, HSB, and CMYK.

````
extension UIColor {
    init(hexString:String) {...}
    func hexString() -> String {...}
    func rgb() -> RGB
    func hsb() -> HSB
    func cmyk() -> CMYK
    class func rgbToCMYK(rgb: RGB) -> CMYK
    class func rgbToHSB(rgb: RGB) -> HSB
    class func hsbToRGB(hsb: HSB) -> RGB
    class func hsbToCMYK(hsb: HSB) -> CMYK
    class func cmykToRGB(cmyk: CMYK) -> RGB
    class func cmykToHSB(cmyk: CMYK) -> HSB
}
````

where RGB, HSB, and CMYK are defined as tuples

````
typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
typealias CMYK = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)
typealias HSB = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)

````

Written in Swift 3.0

## Usage
- Drag and drop a UIView onto your view controller
- Set the view's class to GradientSlider, RGBSliders, HSBSliders, CMYKSliders, HSBWheelPicker, ImagePicker, or HSBSpectrumPicker.
- Configure IB properties in the Attributes Inspector (color, rounded corners, border color, etc...)
- Drag and drop your IBActions just like any other control. These controls support
  - ValueChanged
  - TouchDown
  - TouchUpInside

## Example

See the example project. Clone this repository and open ColorPicKitExample.xcodeproj

## Cocoapods

For the time being, this pod needs to be pulled from its github master branch.

````
pod 'ColorPicKit', :git => 'https://github.com/zakkhoyt/ColorPicKit', :branch => 'master'
````

## Images

### Image Picker

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_image.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/image.png)


### Color Wheel

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_wheel.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/wheel.png)

### Spectrum Picker

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_spectrum.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/spectrum.png)


### RGB Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_rgb.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/rgb.png)


### HSB Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_hsb.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/hsb.png)


### CMYK Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_cmyk.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/cmyk.png)

### Gradient Slider

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_gradient.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/gradient.png)

### Hue Slider

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/ib_hue.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicKit/master/images/hue.png)
