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

@interface TOPasscodeKeypadView : UIView

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

/** Accessory views placed on either side of the '0' button */
@property (nonatomic, strong, nullable) UIView *leftAccessoryView;
@property (nonatomic, strong, nullable) UIView *rightAccessoryView;

/** The controls making up each of the button views */
@property (nonatomic, readonly) NSArray<TOPasscodeCircleButton *> *pinButtons;

@end

NS_ASSUME_NONNULL_END
