//
//  TOPasscodeCircleRowView.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TOPasscodeInputFieldStyle) {
    TOPasscodeInputFieldStyleFixed,    // The passcode explicitly requires a specific number of characters (Shows hollow circles)
    TOPasscodeInputFieldStyleVariable  // The passcode can be any arbitrary number of characters (Shows an empty rectangle)
};

@interface TOPasscodeInputField : UIVisualEffectView <UIKeyInput>

/* The input style of this control */
@property (nonatomic, assign) TOPasscodeInputFieldStyle style;

/* The size of each circle in this view (Default is 16) */
@property (nonatomic, assign) CGFloat fixedCircleDiameter;

/* The spacing between each circle (Default is 25.0f) */
@property (nonatomic, assign) CGFloat fixedCircleSpacing;

/* The number of circles in this view (Default is 4) */
@property (nonatomic, assign) NSInteger fixedLength;

/* The current passcode entered into this view */
@property (nonatomic, copy, nullable) NSString *passcode;

/* If this view is directly receiving input, this can change the `UIKeyboard` appearance. */
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

/* The alpha value of the views in this view (For tranclucent styling) */
@property (nonatomic, assign) CGFloat contentAlpha;

/** Called when the number of digits has been entered */
@property (nonatomic, copy) void (^passcodeCompletedHandler)(NSString *code);

/* Init with the target length needed for this passcode */
- (instancetype)initWithStyle:(TOPasscodeInputFieldStyle)style;

/* Replace the passcode with this one, and animate the transition */
- (void)setPasscode:(nullable NSString *)passcode animated:(BOOL)animated;

/* Add additional characters to the end of the passcode, and animate if desired. */
- (void)appendPasscodeCharacters:(NSString *)characters animated:(BOOL)animated;

/* Delete a number of characters from the end, animated if desired. */
- (void)deletePasscodeCharactersOfCount:(NSInteger)deleteCount animated:(BOOL)animated;

/* Plays a shaking animation and resets the passcode back to empty */
- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact;

@end

NS_ASSUME_NONNULL_END
