//
//  TOPasscodeSettingsKeypadButton.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/21/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsKeypadButton.h"
#import "TOPasscodeButtonLabel.h"

@interface TOPasscodeSettingsKeypadButton ()

@property (nonatomic, strong, readwrite) TOPasscodeButtonLabel *buttonLabel;

@end

@implementation TOPasscodeSettingsKeypadButton

+ (TOPasscodeSettingsKeypadButton *)button
{
    return [TOPasscodeSettingsKeypadButton buttonWithType:UIButtonTypeSystem];
}

#pragma mark - Lazy Accessor -
- (TOPasscodeButtonLabel *)buttonLabel
{
    if (_buttonLabel) { return _buttonLabel; }

    CGRect frame = self.bounds;
    frame.size.height -= self.bottomInset;

    _buttonLabel = [[TOPasscodeButtonLabel alloc] initWithFrame:frame];
    _buttonLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_buttonLabel];

    return _buttonLabel;
}

#pragma mark - Layout Accessor -
- (void)setBottomInset:(CGFloat)bottomInset
{
    _bottomInset = bottomInset;

    CGRect frame = self.bounds;
    frame.size.height -= _bottomInset;
    self.buttonLabel.frame = frame;
}

#pragma mark - Background Image Accessor -

- (void)setButtonBackgroundImage:(UIImage *)buttonBackgroundImage
{
    [self setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
}

- (UIImage *)buttonBackgroundImage { return [self backgroundImageForState:UIControlStateNormal]; }

- (void)setButtonTappedBackgroundImage:(UIImage *)buttonTappedBackgroundImage
{
    [self setBackgroundImage:buttonTappedBackgroundImage forState:UIControlStateHighlighted];
}

- (UIImage *)buttonTappedBackgroundImage { return [self backgroundImageForState:UIControlStateHighlighted]; }

@end
