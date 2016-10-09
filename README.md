## ColorPicker


This repository provides several UIControls for picking colors

![IB](https://github.com/zakkhoyt/ColorPicker/blob/master/images/all_100816.png)

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

See the example project. Clone this repository and open ColorPickerExample.xcodeproj

## Cocoapods

For the time being, this pod needs to be pulled from its github master branch.

````
pod 'ColorPicker', :git => 'https://github.com/zakkhoyt/ColorPicker', :branch => 'master'
````

## Images

### Image Picker

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_image.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/image.png)


### Color Wheel

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_wheel.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/wheel.png)

### Spectrum Picker

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_spectrum.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/spectrum.png)


### RGB Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_rgb.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/rgb.png)


### HSB Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_hsb.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/hsb.png)


### CMYK Sliders

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_cmyk.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/cmyk.png)

### Gradient Slider

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_gradient.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/gradient.png)

### Hue Slider

![IB](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/ib_hue.png)

![In use](https://raw.githubusercontent.com/zakkhoyt/ColorPicker/master/images/hue.png)

## Contributions

Please feel free to clone this repository or submit pull requests to improve functionality or add new controls.

A few things that could make these controls more useful:
* Expose the color property as IBDesignable so that the consumer can set the starting color in IB.
* Integrating alpha sliders as an optional IBDesignable so that the consumer can set/get colors with alpha included.
* Integrating an optional brightness slider to WheelPicker as IBDesignable.
* Add and optional IBDesignable property "showLabels" so that (for example) the RGB sliders are labeled Red, Green, Blue. Expose the labels to the consumer so that they may be customized.
* Refactoring classes so that more code is reused.
* Add a UIPanGesture to WheelPicker and SpectrumPicker so that the user can move the KnobView without their finger covering it.
