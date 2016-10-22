## ColorPicKit ![](https://img.shields.io/badge/Version-1.2.2-green.svg)

##### A collection of UIControls and class extensions for selecting and defining colors

![](https://img.shields.io/badge/Supports-Swift 3-green.svg)
![](https://img.shields.io/badge/Supports-Xcode 8-green.svg)
![](https://img.shields.io/badge/Supports-Cocoapods-green.svg)  

![](http://i.imgur.com/GHkQixd.png)

##### UIControls

ColorPicKit provides the following UIControls:
* ImagePixelPicker - Obtain the color of any individual pixel.
* HSBWheel - Hue vs saturation.
* HSBSpectrum - Hue vs brightness & saturation where
    * y = hue
    * x = saturation from 0.0 ..< 0.5
    * x = brightness from 0.5 >.. 1.0
* RGBSliderGroup - 3 sliders to define red, green, and blue components.
* HSBSliderGroup - 3 sliders to define hue, saturation, and brightness components.
* CMYKSliderGroup - 4 sliders to define cyan, magenta, yellow, and black components.
* GradientSlider - Interpolates a color between the two colors on the ends.
* HueSlider - Select a hue value.
* HexKeypad - Represents a color with a hex string where RRGGBB are chars from '0' ... 'F' 

## Usage

##### InterfaceBuilder
![](https://img.shields.io/badge/Supports-UIControl-green.svg)
- Drag and drop a UIView onto your view controller
- Using the Identity Inspector, set the view's class to GradientSlider, HueSlider, RGBSliderGroup, HSBSliderGroup, CMYKSliderGroup, HSBWheelPicker, HSBSpectrumPicker, ImagePixelPicker, or HexKeypad.
- Using the Attributes Inspector, configure IB properties (color, rounded corners, border color, knobSize, etc...)
- Drag and drop your IBActions just like any other control. All controls support
  - ValueChanged
  - TouchDown
  - TouchUpInside

##### Programmatically
![](https://img.shields.io/badge/Supports-init%28frame%29-green.svg)
![](https://img.shields.io/badge/Supports-init%28coder%29-green.svg)  

- Create an instance of GradientSlider, HueSlider, RGBSliderGroup, HSBSliderGroup, CMYKSliderGroup, HSBWheelPicker, HSBSpectrumPicker, or ImagePixelPicker using init(frame) or init(coder).
- Call addTarget() on the control to receive ValueChanged, TouchDown, or TouchUpInside events

````

func setupWheel() {
    self.hsbWheel = HSBWheel(frame: self.view.bounds)
    hsbWheel.addTarget(self, action: #selector(hsbWheelValueChanged), for: .valueChanged)
}
func hsbWheelValueChanged(sender: HSBWheel) {
    let color = sender.color
}

````


## Example

ColorPicKit includes a full example project. Clone this repository and open ColorPicKitExample.xcodeproj

## Cocoapods

This pod is not yet in the Cocoapods trunk, so you will need to install using a branch.

````

pod 'ColorPicKit', :git => 'https://github.com/zakkhoyt/ColorPicKit', :branch => '1.2.2'

````

## UIColor utilities

ColorPicKit also exposes several functions and data structures for working with hex strings, RGBA, HSBA, and CMYKA, and interpolating a color between two known colors.

````

extension UIColor {

    public convenience init(hexString:String)
    public convenience init(rgb: RGBA, alpha: CGFloat = 1.0)
    public convenience init(hsb: HSBA, alpha: CGFloat = 1.0)
    public convenience init(cmyk: CMYKA, alpha: CGFloat = 1.0)

    public func hexString() -> String
    public func rgb() -> RGBA
    public func hsb() -> HSBA
    public func cmyk() -> CMYKA

    public class func colorWith(hexString: String, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(rgb: RGBA, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(hsb: HSBA, alpha: CGFloat = 1.0) -> UIColor
    public class func colorWith(cmyk: CMYKA, alpha: CGFloat = 1.0) -> UIColor

    public class func interpolateAt(value: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor
    public class func rgbToCMYKA(rgb: RGBA) -> CMYKA
    public class func rgbToHSBA(rgb: RGBA) -> HSBA
    public class func hsbToRGBA(hsb: HSBA) -> RGBA
    public class func hsbToCMYKA(hsb: HSBA) -> CMYKA
    public class func cmykToRGBA(cmyk: CMYKA) -> RGBA
    public class func cmykToHSBA(cmyk: CMYKA) -> HSBA

}

````

RGBA, HSBA, and CMYKA are defined as tuples

````
{
public typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat)
public typealias CMYKA = (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat)
public typealias HSBA = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat)
}

````

## UIImage and CVPixelBuffer utilities

Additionally, ColorPicKit exposes instance methods and class functions which allow you to convert UIImage to CVPixelBuffer, get CVPixelBuffer properties, and query a single pixel color.

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

##### Examples

````
// Get color of center pixel
guard let image = UIImage(named: "mars_earth") else {
    return
}
let center = CGPoint(x: image.size.width / 2.0, y: image.size.height / 2.0)
let color = image.pixelColorAt(point: center)


````


## Interface Builder Images
#### ImagePixelPicker
![IB](http://i.imgur.com/Mf9Laoj.png)

#### HSBWheel
![IB](http://i.imgur.com/STCTD02.png)

#### HSBSpectrum
![IB](http://i.imgur.com/AAL8lMB.png)

#### RGBSliderGroup
![IB](http://i.imgur.com/rCY68tR.png)

#### HSBSliderGroup
![IB](http://i.imgur.com/SL0F2DT.png)

#### CMYKSliderGroup
![IB](http://i.imgur.com/t3vyZvY.png)

#### GradientSlider
![IB](http://i.imgur.com/BJjK7Me.png)

#### HueSlider
![IB](http://i.imgur.com/YJuVTFX.png)

#### HexKeypad
![IB]()



## Images in use
#### ImagePixelPicker
![In use](http://i.imgur.com/8yaZiBF.png)

#### HSBWheel
![In use](http://i.imgur.com/AVtix56.png)

#### HSBSpectrum
![In use](http://i.imgur.com/Rak6ukf.png)

#### RGBSliderGroup
![In use](http://i.imgur.com/jUmgXb0.png)

#### HSBSliderGroup
![In use](http://i.imgur.com/PFIWWLa.png)

#### CMYKSliderGroup
![In use](http://i.imgur.com/jWvX44n.png)

#### GradientSlider
![In use](http://i.imgur.com/hX2MQ9q.png)

#### HueSlider
![In use](http://i.imgur.com/7IUiq1b.png)

#### HexKeypad
![IB]()

