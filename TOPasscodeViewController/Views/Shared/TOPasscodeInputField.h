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

/* The 'submit' button shown when `showSubmitButton` is true. */
@property (nonatomic, readonly, nullable) UIButton *submitButton;

/* Shows an 'OK' button next to the view when characters have been added. */
@property (nonatomic, assign) BOOL showSubmitButton;

/* The amount of spacing between the 'OK' button and the passcode field */
@property (nonatomic, assign) CGFloat submitButtonSpacing;

/* The amount of spacing between the 'OK' button and the passcode field */
@property (nonatomic, assign) CGFloat submitButtonVerticalSpacing;

/* The font size of the submit button */
@property (nonatomic, assign) CGFloat submitButtonFontSize;

/* The current passcode entered into this view */
@property (nonatomic, copy, nullable) NSString *passcode;

/* If this view is directly receiving input, this can change the `UIKeyboard` appearance. */
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

/* The type of button used for the 'Done' button in the keyboard */
@property(nonatomic, assign) UIReturnKeyType returnKeyType;

/* The alpha value of the views in this view (For tranclucent styling) */
@property (nonatomic, assign) CGFloat contentAlpha;

/* Whether the view may be tapped to enable character input (Default is NO) */
@property (nonatomic, assign) BOOL enabled;

/** Called when the number of digits has been entered, or the user tapped 'Done' on the keyboard */
@property (nonatomic, copy) void (^passcodeCompletedHandler)(NSString *code);

/** Horizontal layout. The 'OK' button will be placed under the text field */
@property (nonatomic, assign) BOOL horizontalLayout;

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

/* Animates the OK button changing location */
- (void)setHorizontalLayout:(BOOL)horizontalLayout animated:(BOOL)animated duration:(CGFloat)duration;

@end

NS_ASSUME_NONNULL_END
