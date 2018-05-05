# TextFieldView
[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://swift.org/)
[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://swift.org/)
[![BCH compliance](https://bettercodehub.com/edge/badge/RazibUSA/TextFieldView?branch=master)](https://bettercodehub.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/NSStringMask/badge.svg)](https://cocoadocs.org/docsets/NSStringMask)

TextFieldView is a composite of UI components to design a form based view in iPhone and iPad app. It supports various style and field validators and very easy to use.

![Image of TextFieldView](https://github.com/RazibUSA/TextFieldView/blob/master/tfv.png)

## :bulb: Features
- Simple to add & Modify this composite component via Stoaryboard or code
- Change the Style: Box, Round, Line
- Validatate your text field data:
  - Password Validation
  - Email Validation
  - Zip Validation
  - Phone Validation
  - Empty Validation
  - Match with coupling field
- Display Error Message
- Display icon of Accepted data - Green marked
- Shake text field on error
  
## :book: Usage  

### Run/Keep your eye on the Demo Project: 
- [:link: iOS Example Project](https://github.com/RazibUSA/TextFieldView/tree/master/demo/FormDesignSwift)

### Direct use of framework
In order to correctly compile:

1. Drag the `TextFieldView.xcodeproj` to your project  
2. Go to your target's settings, hit the "+" under the "Embedded Binaries" section, and select the TextFieldView.framework  
3. `@import TextFieldView`

### Add Pod to your project:
As the prject is not added to pod spec, you have to mention full path of my repo like below:

```
 pod 'TextFieldView', :git => 'https://github.com/RazibUSA/TextFieldView.git', :tag => '0.0.3'
```

## :door: Feedback
Feel free to create a new issue or mail me razib.mollick@gmail.com
