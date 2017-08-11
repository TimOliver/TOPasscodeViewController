//
//  TOPasscodeView.h
//
//  Copyright 2017 Timothy Oliver. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "TOPasscodeViewControllerConstants.h"

NS_ASSUME_NONNULL_BEGIN

@class TOPasscodeCircleButton;
@class TOPasscodeInputField;
@class TOPasscodeKeypadView;
@class TOPasscodeViewContentLayout;

@interface TOPasscodeView : UIView

/* The visual style of the view */
@property (nonatomic, assign) TOPasscodeViewStyle style;

/* The type of passcode being managed by it */
@property (nonatomic, readonly) TOPasscodeType passcodeType;

/* Whether the content is laid out vertically or horizontally (iPhone only) */
@property (nonatomic, assign) BOOL horizontalLayout;

/* The text in the title view (Default is 'Enter Passcode') */
@property (nonatomic, copy) NSString *titleText;

/* Customizable Accessory Views */
@property (nonatomic, strong, nullable) UIView   *titleView;
@property (nonatomic, strong, nullable) UIButton *leftButton;
@property (nonatomic, strong, nullable) UIButton *rightButton;

/* The default views always shown in this view */
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) TOPasscodeInputField *inputField;
@property (nonatomic, readonly) TOPasscodeKeypadView *keypadView;

/* Overrides for theming the various elements. */
@property (nonatomic, strong, nullable) UIColor *titleLabelColor;
@property (nonatomic, strong, nullable) UIColor *inputProgressViewTintColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonBackgroundColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonTextColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonHighlightedTextColor;

/* Horizontal inset from edge of keypad view to button center */
@property (nonatomic, readonly) CGFloat keypadButtonInset;

/* An animatable property for animating the non-translucent subviews */
@property (nonatomic, assign) CGFloat contentAlpha;

/* The passcode currently entered into this view */
@property (nonatomic, copy, nullable) NSString *passcode;

/* The default layout object controlling the
 sizing and placement of all this view's child elements. */
@property (nonatomic, strong, null_resettable) TOPasscodeViewContentLayout *defaultContentLayout;

/* As needed, additional layout objects that will be checked and used in priority over the default content layout. */
@property (nonatomic, strong, nullable) NSArray<TOPasscodeViewContentLayout *> *contentLayouts;

/* Callback triggered each time the user taps a key */
@property (nonatomic, copy, nullable) void (^passcodeDigitEnteredHandler)();

/* Callback triggered when the user has finished entering the passcode */
@property (nonatomic, copy, nullable) void (^passcodeCompletedHandler)(NSString *passcode);

/* Create a new instance with one of the style types */
- (instancetype)initWithStyle:(TOPasscodeViewStyle)style passcodeType:(TOPasscodeType)type;

/* Resize the view and all subviews for the optimum size to fit a super view of the suplied width. */
- (void)sizeToFitSize:(CGSize)size;

/* Reset the passcode to nil and optionally play animation / vibration to match */
- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact;

/* Delete the last character from the passcode */
- (void)deleteLastPasscodeCharacterAnimated:(BOOL)animated;

/* Animate the transition between horizontal and vertical layouts */
- (void)setHorizontalLayout:(BOOL)horizontalLayout animated:(BOOL)animated duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
