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
@property (nonatomic, readonly) UIView *inputField; // Returns whichever input field is currently visible
@property (nonatomic, readonly) NSInteger maximumPasscodeLength; // The mamximum number of characters allowed (0 if uncapped)

@property (nonatomic, strong, readwrite) TOPasscodeFixedInputView *fixedInputView;
@property (nonatomic, strong, readwrite) TOPasscodeVariableInputView *variableInputView;
@property (nonatomic, strong, readwrite) UIButton *submitButton;

@end

@implementation TOPasscodeInputField

#pragma mark - View Set-up -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
        [self setUpForStyle:TOPasscodeInputFieldStyleFixed];
    }

    return self;
}

- (instancetype)initWithStyle:(TOPasscodeInputFieldStyle)style
{
    if (self = [self initWithFrame:CGRectZero]) {
        _style = style;
        [self setUp];
        [self setUpForStyle:style];
    }

    return self;
}

- (void)setUp
{
    _submitButtonSpacing = 4.0f;
}

- (void)setUpForStyle:(TOPasscodeInputFieldStyle)style
{
    if (self.inputField) {
        [self.inputField removeFromSuperview];
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
    [self.inputField sizeToFit];

    // Size this view to match
    [self sizeToFit];
}

#pragma mark - View Layout -
- (void)sizeToFit
{
    // Resize the view to encompass the current input view
    CGRect frame = self.frame;
    [self.inputField sizeToFit];
    frame.size = self.inputField.frame.size;
    self.frame = CGRectIntegral(frame);
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (!self.submitButton) { return; }

    [self.submitButton sizeToFit];
    CGRect frame = self.submitButton.frame;
    frame.origin.x = CGRectGetMaxX(self.bounds) + self.submitButtonSpacing;
    frame.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(frame)) * 0.5f;
    self.submitButton.frame = CGRectIntegral(frame);
}

#pragma mark - Interaction -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (!self.enabled) { return; }
    self.contentAlpha = 0.5f;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (!self.enabled) { return; }
    [UIView animateWithDuration:0.3f animations:^{
        self.contentAlpha = 1.0f;
    }];
    [self becomeFirstResponder];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect frame = self.bounds;
    frame.size.width += self.submitButton.frame.size.width + (self.submitButtonSpacing * 2.0f);

    if (CGRectContainsPoint(frame, point)) {
        return YES;
    }
    return NO;
}

- (id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    if ([[super hitTest:point withEvent:event] isEqual:self.submitButton]) {
        if (CGRectContainsPoint(self.submitButton.frame, point)) {
            return self.submitButton;
        } else {
            return self;
        }
    }

    return [super hitTest:point withEvent:event];
}

#pragma mark - Text Input Protocol -
- (BOOL)canBecomeFirstResponder { return self.enabled; }

- (BOOL)hasText { return self.passcode.length > 0; }

- (void)insertText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.passcodeCompletedHandler) { self.passcodeCompletedHandler(self.passcode); }
        return;
    }

    [self appendPasscodeCharacters:text animated:NO];
}
- (void)deleteBackward
{
    [self deletePasscodeCharactersOfCount:1 animated:YES];
}

- (UIKeyboardType)keyboardType { return UIKeyboardTypeASCIICapable; }

- (UITextAutocorrectionType)autocorrectionType { return UITextAutocorrectionTypeNo; }

- (UIReturnKeyType)returnKeyType { return UIReturnKeyGo; }

- (BOOL)enablesReturnKeyAutomatically { return YES; }

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

    if (self.submitButton) {
        self.submitButton.hidden = (_passcode.length == 0);
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

    if (!self.submitButton) { return; }

    [UIView animateWithDuration:0.7f animations:^{
        self.submitButton.alpha = 0.0f;
    } completion:^(BOOL complete) {
        self.submitButton.alpha = 1.0f;
        self.submitButton.hidden = YES;
    }];
}

#pragma mark - Button Callbacks -
- (void)submitButtonTapped:(id)sender
{
    if (self.passcodeCompletedHandler) {
        self.passcodeCompletedHandler(self.passcode);
    }
}

#pragma mark - Private Accessors -
- (UIView *)inputField
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

- (void)setShowSubmitButton:(BOOL)showSubmitButton
{
    if (_showSubmitButton == showSubmitButton) {
        return;
    }

    _showSubmitButton = showSubmitButton;

    if (!_showSubmitButton) {
        [self.submitButton removeFromSuperview];
        self.submitButton = nil;
        return;
    }

    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTitle:@"OK" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    self.submitButton.hidden = YES;
    [self addSubview:self.submitButton];

    [self setNeedsLayout];
}

- (void)setSubmitButtonSpacing:(CGFloat)submitButtonSpacing
{
    if (submitButtonSpacing == _submitButtonSpacing) { return; }
    _submitButtonSpacing = submitButtonSpacing;
    [self setNeedsLayout];
}

- (void)setSubmitButtonFontSize:(CGFloat)submitButtonFontSize
{
    if (submitButtonFontSize == _submitButtonFontSize) { return; }
    _submitButtonFontSize = submitButtonFontSize;
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:_submitButtonFontSize];
    [self.submitButton sizeToFit];
    [self setNeedsLayout];
}

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
    self.inputField.alpha = contentAlpha;
    self.submitButton.alpha = contentAlpha;
}

@end
