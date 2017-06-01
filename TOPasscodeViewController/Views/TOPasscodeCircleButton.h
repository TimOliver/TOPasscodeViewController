//
//  TOPasscodeCircleButton.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPasscodeCircleButton : UIControl

// Required to be set by the user
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *hightlightedBackgroundImage;
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong, nullable) UIColor *highlightedTextColor;

@property (nonatomic, readonly) NSString *numberString;
@property (nonatomic, readonly) NSString *letteringString;

// Has initial default values
@property (nonatomic, strong) UIFont *numberFont;
@property (nonatomic, strong) UIFont *letteringFont;
@property (nonatomic, assign) CGFloat letteringCharacterSpacing;
@property (nonatomic, assign) CGFloat letteringVerticalSpacing;

// Callback handler
@property (nonatomic, copy) void (^buttonTappedHandler)();

- (instancetype)initWithNumberString:(NSString *)numberString letteringString:(NSString *)letteringString;

// Automatically called when tapped
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
