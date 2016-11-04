## ColorPicKit ![](https://img.shields.io/badge/Version-1.2.3-green.svg)

##### A collection of UIControls and class extensions for selecting and defining colors

![](https://img.shields.io/badge/Supports-Swift 3-green.svg)
![](https://img.shields.io/badge/Supports-Xcode 8-green.svg)
![](https://img.shields.io/badge/Supports-Cocoapods-green.svg)  

[![ColorPicKit Video](http://i.imgur.com/Mxuv4EO.png)](https://www.youtube.com/watch?v=7y1uZWaqHRM)


![](https://zippy.gfycat.com/BlandSpeedyCoyote.webm)  

##### UIControls

ColorPicKit provides the following UIControls:
* ImagePixelPicker - Obtain the color of any individual pixel.
* HSBAWheel - Hue vs saturation.
* HSBASpectrum - Hue vs brightness & saturation where
    * y = hue
    * x = saturation from 0.0 ..< 0.5
    * x = brightness from 0.5 >.. 1.0
* HSLASpectrum - Hue vs brightness & saturation where
    * y = hue
    * x = saturation from 0.0 ..< 1.5
    * where lightness = 0.5
* YUVAASpectrum - Hue vs brightness & saturation where
    * x = u component
    * y = v component
* RGBASliderGroup - 4 sliders to define red, green, blue, and alpha components.
* HSBASliderGroup - 4 sliders to define hue, saturation, brightness, and alpha components.
* HSLASliderGroup - 4 sliders to define hue, saturation, lightness, and alpha components.
* CMYKASliderGroup - 5 sliders to define cyan, magenta, yellow, black, and alpha components.
* YUVASliderGroup - 4 sliders to define y, u, v, and alpha components
* GradientSlider - Interpolates a color between the two colors on the ends.
* HueSlider - Select a hue value.
* HexKeypad - Represents a color with a hex string where RRGGBB are chars from '0' ... 'F'

## Usage

##### InterfaceBuilder
![](https://img.shields.io/badge/Supports-UIControl-green.svg)
- Drag and drop a UIView onto your view controller
- Using the Identity Inspector, set the view's class to GradientSlider, HueSlider, RGBASliderGroup, HSBASliderGroup, CMYKASliderGroup, HSBAWheelPicker, HSBASpectrumPicker, ImagePixelPicker, or HexKeypad.
- Using the Attributes Inspector, configure IB properties (color, rounded corners, border color, knobSize, etc...)
- Drag and drop your IBActions just like any other control. All controls support.
  - ValueChanged
  - TouchDown
  - TouchUpInside

##### Programmatically
![](https://img.shields.io/badge/Supports-init%28frame%29-green.svg)
![](https://img.shields.io/badge/Supports-init%28coder%29-green.svg)  

- Create an instance of GradientSlider, HueSlider, RGBASliderGroup, HSBASliderGroup, CMYKASliderGroup, HSBAWheelPicker, HSBASpectrumPicker, or ImagePixelPicker using init(frame) or init(coder).
- Call addTarget() on the control to receive ValueChanged, TouchDown, or TouchUpInside events

````

func setupWheel() {
    self.hsbWheel = HSBAWheel(frame: self.view.bounds)
    hsbWheel.addTarget(self, action: #selector(hsbWheelValueChanged), for: .valueChanged)
}
func hsbWheelValueChanged(sender: HSBAWheel) {
    let color = sender.color
}

````


## Example

ColorPicKit includes a full example project. Clone this repository and open ColorPicKitExample.xcodeproj

## Cocoapods

This pod is not yet in the Cocoapods trunk, so you will need to install using a branch.

````

pod 'ColorPicKit', :git => 'https://github.com/zakkhoyt/ColorPicKit', :branch => '1.2.3'

````

## UIColor utilities

ColorPicKit also exposes several functions and data structures for working with hex strings, RGBA, HSBA, HSLA, CMYKA, YUVA, and interpolating a color between two known colors.

````

extension UIColor {

    public convenience init(hexString:String)
    public func hexString() -> String
    public class func colorWith(hexString: String, alpha: CGFloat = 1.0) -> UIColor
    public class func interpolateAt(value: CGFloat, betweenColor1 color1: UIColor, andColor2 color2: UIColor) -> UIColor

    // Create a color with any color type struct
    init(rgba: RGBA)
    init(hsba: HSBA)
    init(hsla: HSLA)
    init(cmyka: CMYKA)
    init(yuva: YUVA)

    // Easily convert to a different color format
    func rgba() -> RGBA
    func hsba() -> HSBA
    func hsla() -> HSLA
    func cmyka() -> CMYKA
    func yuva() -> YUVA
}

````

Where RGBA, HSBA, HSLA, CMYKA, and YUVA are defined as structs

````
// RGBA
init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

// HSBA
init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

// HSLA
init(hue: CGFloat, saturation: CGFloat, lightness: CGFloat, alpha: CGFloat)

// CMYKA
init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat)

// YUVA
init(y: CGFloat, u: CGFloat, v: CGFloat, alpha: CGFloat)

````

## UIImage and CVPixelBuffer utilities

Additionally, ColorPicKit exposes instance methods and class functions which allow you to convert UIImage to CVPixelBuffer, get CVPixelBuffer properties, and query a single pixel color.

````

extension UIImage {

    // Class functions
    public class func pixelColorOf(image: UIImage, at point: CGPoint) -> UIColor?
    public class func pixelBufferPropertiesOf(image: UIImage) -> (pixelBuffer: CVPixelBuffer?, size:CGSize, bytesPerRow: Int)
    public class func pixelBufferOf(image: UIImage) -> CVPixelBuffer?
    public class func getSizeOf(pixelBuffer: CVPixelBuffer) -> CGSize
    public class func getBytesPerRowOf(pixelBuffer: CVPixelBuffer) -> Int

    // Instance methods
    public func pixelColorAt(point: CGPoint) -> UIColor?
    public func pixelBuffer() -> CVPixelBuffer?
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
let color = image.pixelColorOf(point: center)


````
