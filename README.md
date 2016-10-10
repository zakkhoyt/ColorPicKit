## ColorPicKit

Written in Swift 3.0

This repository provides several UIControls for picking colors as well as class extensions for UIColor and UIImage which are related to colors.

![IB](https://github.com/zakkhoyt/ColorPicKit/blob/master/images/all_100816.png)

* An Image color picker - Get the color of any individual pixel.
* An HSB color picker wheel - Hue vs saturation.
* An HSB spectrum picker - A 2 dimensional plot where y = hue and x = saturation from 0.0 ..< 0.5 and x = brightness from 0.5 >.. 1.0
* An RGB slider set - 3 sliders to select red, green, and blue.
* An HSB slider set - 3 sliders to select hue, saturation, and brightness.
* An CMYK slider set - 4 sliders to select cyan, magenta, yellow, and black.
* A gradient slider - Interpolate a color between two established colors.
* A hue slider - Select a hue value.

#### UIColor utilities

ColorPicKit also exposes several functions and data structures for working with hex strings, RGB, HSB, and CMYK, and interpolating a color between two known colors.

````

extension UIColor {

    public convenience init(hexString:String)
    public convenience init(rgb: RGB, alpha: CGFloat = 1.0)
    public convenience init(hsb: HSB, alpha: CGFloat = 1.0)
    public convenience init(cmyk: CMYK, alpha: CGFloat = 1.0)

    public func hexString() -> String
    public func rgb() -> RGB
    public func hsb() -> HSB
    public func cmyk() -> CMYK

    public class func colorWith(hexString: String, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(rgb: RGB, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(hsb: HSB, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(cmyk: CMYK, alpha: CGFloat = 1.0) -> UIColor

    public class func interpolateAt(percent: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor
    public class func rgbToCMYK(rgb: RGB) -> CMYK
    public class func rgbToHSB(rgb: RGB) -> HSB
    public class func hsbToRGB(hsb: HSB) -> RGB
    public class func hsbToCMYK(hsb: HSB) -> CMYK
    public class func cmykToRGB(cmyk: CMYK) -> RGB
    public class func cmykToHSB(cmyk: CMYK) -> HSB

}

````

RGB, HSB, and CMYK are defined as tuples

````

public typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat)
public typealias CMYK = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)
public typealias HSB = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)

````

#### UIImage and CVPixelBuffer utilities

Additionally, I've exposed instance methods and class functions which allow you to convert UIImage to CVPixelBuffer, get CVPixelBuffer properties, and query a pixel color.

````

extension UIImage {

    // Class functions
    public class func pixelBufferOf(image: UIImage) -> CVPixelBuffer?
    public class func pixelBufferPropertiesOf(image: UIImage) -> (pixelBuffer: CVPixelBuffer?, size:CGSize, bytesPerRow: Int)
    public class func getSizeOf(pixelBuffer: CVPixelBuffer) -> CGSize
    public class func getBytesPerRowOf(pixelBuffer: CVPixelBuffer) -> Int
    public class func pixelColorOf(image: UIImage, at point: CGPoint) -> UIColor?

    // Instance methods
    public func pixelBuffer() -> CVPixelBuffer? {
    public func pixelColorAt(point: CGPoint) -> UIColor? {
    public func pixelBufferProperties() -> (pixelBuffer: CVPixelBuffer?, size:CGSize, bytesPerRow: Int)

}

````

## Usage
- Drag and drop a UIView onto your view controller
- Set the view's class to GradientSlider, HueSlider, RGBSliderGroup, HSBSliderGroup, CMYKSliderGroup, HSBWheelPicker, HSBSpectrumPicker, or ImagePicker.
- Using the Attributes Inspector, configure IB properties (color, rounded corners, border color, etc...)
- Drag and drop your IBActions just like any other control. All controls support
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

## Contributions

See the issues page for new features, bugs, and improvements.
