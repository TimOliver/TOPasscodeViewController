//
//  TOPasscodeCircleKeypadView.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TOPasscodeCircleButton;

/* The direction this keypad is laid out.
   When horizontal, the '0' button is on the right side */
typedef NS_ENUM(NSInteger, TOPasscodeKeypadLayout) {
    TOPasscodeKeypadLayoutVertical,
    TOPasscodeKeypadLayoutHorizontal
};

@interface TOPasscodeKeypadView : UIView

/** The type of layout for the buttons (Default is vertical) */
@property (nonatomic, assign) TOPasscodeKeypadLayout layout;

/** The vibrancy effect to be applied to each button background */
@property (nonatomic, strong, nullable) UIVibrancyEffect *vibrancyEffect;

/** The size of each input button */
@property (nonatomic, assign) CGFloat buttonDiameter;

/** The stroke width of the buttons */
@property (nonatomic, assign) CGFloat buttonStrokeWidth;

/** The spacing between the buttons. Default is (CGSize){25,15} */
@property (nonatomic, assign) CGSize buttonSpacing;

/** The font of the number in each button */
@property (nonatomic, strong) UIFont *buttonNumberFont;

/** The font of the lettering label */
@property (nonatomic, strong) UIFont *buttonLetteringFont;

/** The spacing between the lettering and the number label */
@property (nonatomic, assign) CGFloat buttonLabelSpacing;

/** The spacing between the letters in the lettering label */
@property (nonatomic, assign) CGFloat buttonLetteringSpacing;

/** Show the 'ABC' lettering under the numbers */
@property (nonatomic, assign) BOOL showLettering;

/** The spacing in points between the letters */
@property (nonatomic, assign) CGFloat letteringSpacing;

/** The tint color of the button backgrounds */
@property (nonatomic, strong) UIColor *buttonBackgroundColor;

/** The color of the text elements in each button */
@property (nonatomic, strong) UIColor *buttonTextColor;

/** Optionally the color of text when it's tapped. */
@property (nonatomic, strong, nullable) UIColor *buttonHighlightedTextColor;

/** The alpha value of all non-translucent views */
@property (nonatomic, assign) CGFloat contentAlpha;

/** Accessory views placed on either side of the '0' button */
@property (nonatomic, strong, nullable) UIView *leftAccessoryView;
@property (nonatomic, strong, nullable) UIView *rightAccessoryView;

/** The controls making up each of the button views */
@property (nonatomic, readonly) NSArray<TOPasscodeCircleButton *> *keypadButtons;

/** The block that is triggered whenever a user taps one of the buttons */
@property (nonatomic, copy) void (^buttonTappedHandler)(NSInteger buttonNumber);

/* Perform an animation of a set duration to the new layout */
- (void)setLayout:(TOPasscodeKeypadLayout)layout animated:(BOOL)animated duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
