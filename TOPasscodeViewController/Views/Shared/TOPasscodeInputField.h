//
//  TOPasscodeCircleRowView.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TOPasscodeFixedInputView.h"
#import "TOPasscodeVariableInputView.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TOPasscodeInputFieldStyle) {
    TOPasscodeInputFieldStyleFixed,    // The passcode explicitly requires a specific number of characters (Shows hollow circles)
    TOPasscodeInputFieldStyleVariable  // The passcode can be any arbitrary number of characters (Shows an empty rectangle)
};

@interface TOPasscodeInputField : UIVisualEffectView <UIKeyInput>

/* The input style of this control */
@property (nonatomic, assign) TOPasscodeInputFieldStyle style;

/* A row of hollow circles at a preset length. Valid only when `style` is set to `fixed` */
@property (nonatomic, readonly, nullable) TOPasscodeFixedInputView *fixedInputView;

/* A rounded rectangle representing a password of arbitrary length. Valid only when `style` is set to `variable`. */
@property (nonatomic, readonly, nullable) TOPasscodeVariableInputView *variableInputView;

/* The current passcode entered into this view */
@property (nonatomic, copy, nullable) NSString *passcode;

/* If this view is directly receiving input, this can change the `UIKeyboard` appearance. */
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

/* The alpha value of the views in this view (For tranclucent styling) */
@property (nonatomic, assign) CGFloat contentAlpha;

/* Whether the view may be tapped to enable character input (Default is NO) */
@property (nonatomic, assign) BOOL enabled;

/** Called when the number of digits has been entered, or the user tapped 'Done' on the keyboard */
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
