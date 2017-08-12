# TOPasscodeViewController
> A passcode input and validation view controller, à la the iOS lock screen.

<p align="center">
<img src="https://raw.githubusercontent.com/TimOliver/TOPasscodeViewController/master/screenshot.jpg" width="890" style="margin:0 auto" />
</p>

[![CI Status](http://img.shields.io/travis/TimOliver/TOPasscodeViewController.svg?style=flat)](http://api.travis-ci.org/TimOliver/TOPasscodeViewController.svg)
[![CocoaPods](https://img.shields.io/cocoapods/dt/TOPasscodeViewController.svg?maxAge=3600)](https://cocoapods.org/pods/TOPasscodeViewController)
[![Version](https://img.shields.io/cocoapods/v/TOPasscodeViewController.svg?style=flat)](http://cocoadocs.org/docsets/TOPasscodeViewController)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/TimOliver/TOPasscodeViewController/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TOPasscodeViewController.svg?style=flat)](http://cocoadocs.org/docsets/TOPasscodeViewController)

`TOPasscodeViewController` is an open-source `UIViewController` subclass that will overlay a full-screen passcode UI in a similar style to that of the system over an app's content. The user must enter the correct password into it in order to proceed. This is useful for certain types of apps that might contain highly sensitive information where users may indeed want an extra level of security.

## Features
* Prompts users to enter a passcode in order to proceed.
* May be presented as a translucent overlay, partially showing the normal app content behind it.
* Supports 4 different passcode types, from 4-digit passcodes, up to full alphanumeric passcodes.
* Supports 4 base themes, including translucent/opaque and light/dark.
* Supports Touch ID validation.
* Provides an additional settings view controller for letting users change their passcode.
* Passcode validation is handled by the parent app through a variety of delegate callbacks.
* A custom animation and layout when the device is rotated to landscape mode on iPhone.
* Custom 'opening' and 'dismissal' animations.

## System Requirements
iOS 8.3 or above

## Installation

#### As a CocoaPods Dependency

Add the following to your Podfile:
``` ruby
pod 'TOPasscodeViewController'
```

#### As a Carthage Dependency

Coming soon. :)

#### Manual Installation

Download this project from GitHub, move the subfolder named 'TOPasscodeViewController' over to your project folder, and drag it into your Xcode project.

## Examples
`TOPasscodeViewController` operates around a very strict modal implementation. It cannot be pushed to a `UINavigationController` stack, and must be presented as a full-screen dialog on an existing view controller.

### Basic Implementation
```objc
- (void)showButtonTapped:(id)sender
{
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark passcodeType:TOPasscodeTypeFourDigits];
    passcodeViewController.delegate = self;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:@"1234"];
}
```

## Credits
`TOPasscodeViewController` was originally created by [Tim Oliver](http://twitter.com/TimOliverAU) as a component for [iComics](http://icomics.co), a comic reader app for iOS.

iOS Device mockups used in the screenshot created by [Pixeden](http://pixeden.com).

## License
`TOPasscodeViewController` is licensed under the MIT License, please see the [LICENSE](LICENSE) file.