//
//  TOPasscodeCircleRowView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeInputField.h"

#import "TOPasscodeVariableInputView.h"
#import "TOPasscodeFixedInputView.h"

#import <AudioToolbox/AudioToolbox.h>

@interface TOPasscodeInputField ()

// Convenience getters
@property (nonatomic, readonly) UIView *inputView; // Returns whichever input field is currently visible
@property (nonatomic, readonly) NSInteger maximumPasscodeLength; // The mamximum number of characters allowed (0 if uncapped)


@property (nonatomic, readwrite, nullable) TOPasscodeFixedInputView *fixedInputView;
@property (nonatomic, readwrite, nullable) TOPasscodeVariableInputView *variableInputView;

@end

@implementation TOPasscodeInputField

#pragma mark - View Set-up -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpForStyle:TOPasscodeInputFieldStyleFixed];
    }

    return self;
}

- (instancetype)initWithStyle:(TOPasscodeInputFieldStyle)style
{
    if (self = [self initWithFrame:CGRectZero]) {
        _style = style;
        [self setUpForStyle:style];
    }

    return self;
}

- (void)setUpForStyle:(TOPasscodeInputFieldStyle)style
{
    if (self.inputView) {
        [self.inputView removeFromSuperview];
        self.variableInputView = nil;
        self.fixedInputView = nil;
    }

    if (style == TOPasscodeInputFieldStyleVariable) {
        self.variableInputView = [[TOPasscodeVariableInputView alloc] init];
        [self.contentView addSubview:self.variableInputView];
    }
    else {
        self.fixedInputView = [[TOPasscodeFixedInputView alloc] init];
        [self.contentView addSubview:self.fixedInputView];
    }

    // Set the frame for the currently visible input view
    [self.inputView sizeToFit];

    // Size this view to match
    [self sizeToFit];
}

#pragma mark - View Layout -
- (void)sizeToFit
{
    // Resize the view to encompass the current input view
    CGRect frame = self.frame;
    [self.inputView sizeToFit];
    frame.size = self.inputView.frame.size;
    self.frame = frame;
}

#pragma mark - Text Input Protocol -
- (BOOL)canBecomeFirstResponder { return YES; }

- (BOOL)hasText { return self.passcode.length > 0; }

- (void)insertText:(NSString *)text
{
    [self appendPasscodeCharacters:text animated:NO];
}
- (void)deleteBackward
{
    [self deletePasscodeCharactersOfCount:1 animated:YES];
}

- (UIKeyboardType)keyboardType { return UIKeyboardTypeDefault; }

#pragma mark - Text Input -
- (void)setPasscode:(NSString *)passcode animated:(BOOL)animated
{
    if (passcode == self.passcode) { return; }
    _passcode = passcode;

    BOOL passcodeIsComplete = NO;
    if (self.fixedInputView) {
        [self.fixedInputView setHighlightedLength:_passcode.length animated:animated];
        passcodeIsComplete = _passcode.length >= self.maximumPasscodeLength;
    }
    else {
        [self.variableInputView setLength:_passcode.length animated:animated];
    }

    if (passcodeIsComplete && self.passcodeCompletedHandler) {
        self.passcodeCompletedHandler(_passcode);
    }
}

- (void)appendPasscodeCharacters:(NSString *)characters animated:(BOOL)animated
{
    if (characters == nil) { return; }
    if (self.maximumPasscodeLength > 0 && self.passcode.length >= self.maximumPasscodeLength) { return; }

    if (_passcode == nil) { _passcode = @""; }
    [self setPasscode:[_passcode stringByAppendingString:characters] animated:animated];
}

- (void)deletePasscodeCharactersOfCount:(NSInteger)deleteCount animated:(BOOL)animated
{
    if (deleteCount <= 0 || self.passcode.length <= 0) { return; }
    [self setPasscode:[self.passcode substringToIndex:(self.passcode.length - 1)] animated:animated];
}

- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact
{
    [self setPasscode:nil animated:animated];

    if (impact) {
        // https://stackoverflow.com/questions/41444274/how-to-check-if-haptic-engine-uifeedbackgenerator-is-supported
        AudioServicesPlaySystemSoundWithCompletion(1521, nil);
    }

    if (!animated) { return; }

    CGPoint center = self.center;
    CGPoint offset = center;
    offset.x -= self.frame.size.width * 0.3f;

    // Play the view sliding out and then springing back in
    id completionBlock = ^(BOOL finished) {
        [UIView animateWithDuration:1.0f
                              delay:0.0f
             usingSpringWithDamping:0.15f
              initialSpringVelocity:10.0f
                            options:0 animations:^{
                                self.center = center;
                            }completion:nil];
    };

    [UIView animateWithDuration:0.05f animations:^{
        self.center = offset;
    }completion:completionBlock];
}

#pragma mark - Private Accessors -
- (UIView *)inputView
{
    if (self.fixedInputView) {
        return (UIView *)self.fixedInputView;
    }

    return (UIView *)self.variableInputView;
}

- (NSInteger)maximumPasscodeLength
{
    if (self.style == TOPasscodeInputFieldStyleFixed) {
        return self.fixedInputView.length;
    }

    return 0;
}

#pragma mark - Public Accessors -

- (void)setStyle:(TOPasscodeInputFieldStyle)style
{
    if (style == _style) { return; }
    _style = style;
    [self setUpForStyle:_style];
}

- (void)setPasscode:(NSString *)passcode
{
    [self setPasscode:passcode animated:NO];
}

- (void)setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;
    self.inputView.alpha = contentAlpha;
}

@end
