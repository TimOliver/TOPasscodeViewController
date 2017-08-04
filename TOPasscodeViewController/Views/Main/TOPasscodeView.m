//
//  TOPasscodeView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeView.h"
#import "TOPasscodeViewContentLayout.h"
#import "TOPasscodeCircleButton.h"
#import "TOPasscodeInputField.h"
#import "TOPasscodeKeypadView.h"

@interface TOPasscodeView ()

/* The current layout object used to configure this view */
@property (nonatomic, weak) TOPasscodeViewContentLayout *currentLayout;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) TOPasscodeKeypadView *keypadView;
@property (nonatomic, strong, readwrite) TOPasscodeInputField *inputField;

@property (nonatomic, assign, readwrite) TOPasscodeType passcodeType;

@end

@implementation TOPasscodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithStyle:(TOPasscodeViewStyle)style passcodeType:(TOPasscodeType)type
{
    if (self = [super initWithFrame:CGRectMake(0,0,320,393)]) {
        _style = style;
        _passcodeType = type;
        [self setUp];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    // Set up default properties
    self.userInteractionEnabled = YES;
    _defaultContentLayout = [TOPasscodeViewContentLayout defaultScreenContentLayout];
    _currentLayout = _defaultContentLayout;
    _contentLayouts = @[[TOPasscodeViewContentLayout mediumScreenContentLayout],
                        [TOPasscodeViewContentLayout smallScreenContentLayout]];
    _titleText = @"Enter Passcode";

    // Start configuring views
    [self setUpViewForType:self.passcodeType];

    // Set the default layout for the views
    [self updateSubviewsForContentLayout:_defaultContentLayout];

    // Configure the theme of all of the views
    [self applyThemeForStyle:_style];
}

#pragma mark - View Layout -
- (void)layoutSubviews
{
    CGSize midViewSize = (CGSize){self.frame.size.width * 0.5f, self.frame.size.height * 0.5f};

    CGRect frame = CGRectZero;
    CGFloat y = 0.0f;

    // Title View
    if (self.titleView) {
        frame = self.titleView.frame;
        frame.origin.y = y;
        frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
        self.titleView.frame = CGRectIntegral(frame);

        y = CGRectGetMaxY(frame) + self.currentLayout.titleViewBottomSpacing;
    }

    // Title Label
    frame = self.titleLabel.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.titleLabel.frame = CGRectIntegral(frame);

    y = CGRectGetMaxY(frame) + self.currentLayout.titleLabelBottomSpacing;

    // Circle Row View
    [self.inputField sizeToFit];
    frame = self.inputField.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.inputField.frame = CGRectIntegral(frame);

    y = CGRectGetMaxY(frame) + self.currentLayout.circleRowBottomSpacing;

    // PIN Pad View
    frame = self.keypadView.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.keypadView.frame = CGRectIntegral(frame);
}

- (void)sizeToFitWidth:(CGFloat)width
{
    NSMutableArray *layouts = [NSMutableArray array];
    [layouts addObject:self.defaultContentLayout];
    [layouts addObjectsFromArray:self.contentLayouts];

    // Loop through each layout (in ascending order) and pick the best one to fit this view
    TOPasscodeViewContentLayout *contentLayout = self.defaultContentLayout;
    for (TOPasscodeViewContentLayout *layout in layouts) {
        if (width >= layout.viewWidth) {
            contentLayout = layout;
            break;
        }
    }

    // Set the new layout
    self.currentLayout = contentLayout;

    // Resize the views to fit
    [self sizeToFit];
}

- (void)sizeToFit
{
    [self.titleLabel sizeToFit];
    [self.inputField sizeToFit];
    [self.keypadView sizeToFit];

    CGRect frame = self.frame;
    frame.size.width = CGRectGetWidth(self.keypadView.frame);
    frame.size.height = 0.0f;

    // Add height for the title view
    if (self.titleView) {
        frame.size.height += self.titleView.frame.size.height;
        frame.size.height += self.currentLayout.titleViewBottomSpacing;
    }

    // Add height for the title label
    frame.size.height += self.titleLabel.frame.size.height;
    frame.size.height += self.currentLayout.titleLabelBottomSpacing;

    // Add height for the circle rows
    frame.size.height += self.inputField.frame.size.height;
    frame.size.height += self.currentLayout.circleRowBottomSpacing;

    // Add height for the keypad
    frame.size.height += self.keypadView.frame.size.height;

    // Set the frame back
    self.frame = CGRectIntegral(frame);
}

#pragma mark - View Setup -
- (void)setUpViewForType:(TOPasscodeType)type
{
    __weak typeof(self) weakSelf = self;

    self.backgroundColor = [UIColor clearColor];

    // Set up title label
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];

    // Set up the passcode style
    TOPasscodeInputFieldStyle style = TOPasscodeInputFieldStyleFixed;
    if (type >= TOPasscodeTypeCustomNumeric) {
        style = TOPasscodeInputFieldStyleVariable;
    }

    // Set up input field
    if (self.inputField == nil) {
        self.inputField = [[TOPasscodeInputField alloc] initWithStyle:style];
    }
    self.inputField.passcodeCompletedHandler = ^(NSString *passcode) {
        if (weakSelf.passcodeCompletedHandler) {
            weakSelf.passcodeCompletedHandler(passcode);
        }
    };

    // Configure the input field based on the exact passcode type
    if (style == TOPasscodeInputFieldStyleFixed) {
        self.inputField.fixedInputView.length = (self.passcodeType == TOPasscodeTypeSixDigits) ? 6 : 4;
    }
    else {
        self.inputField.showSubmitButton = (self.passcodeType == TOPasscodeTypeCustomNumeric);
    }

    [self addSubview:self.inputField];

    // Set up pad row
    if (type != TOPasscodeTypeCustomAlphanumeric) {
        if (self.keypadView == nil) {
            self.keypadView = [[TOPasscodeKeypadView alloc] init];
        }
        self.keypadView.buttonTappedHandler = ^(NSInteger button) {
            NSString *numberString = [NSString stringWithFormat:@"%ld", button];
            [weakSelf.inputField appendPasscodeCharacters:numberString animated:NO];

            if (weakSelf.passcodeDigitEnteredHandler) {
                weakSelf.passcodeDigitEnteredHandler();
            }
        };
        [self addSubview:self.keypadView];
    }
    else {
        [self.keypadView removeFromSuperview];
        self.keypadView = nil;
    }
}

- (void)updateSubviewsForContentLayout:(TOPasscodeViewContentLayout *)contentLayout
{
    // Title View
    self.titleLabel.font = contentLayout.titleLabelFont;

    // Circle Row View
    self.inputField.fixedInputView.circleDiameter = contentLayout.circleRowDiameter;
    self.inputField.fixedInputView.circleSpacing = contentLayout.circleRowSpacing;

    // Text Field Input Row
    NSInteger maximumInputLength = (self.passcodeType == TOPasscodeTypeCustomAlphanumeric) ?
                                            contentLayout.textFieldAlphanumericCharacterLength :
                                            contentLayout.textFieldNumericCharacterLength;

    self.inputField.variableInputView.outlineThickness = contentLayout.textFieldBorderThickness;
    self.inputField.variableInputView.outlineCornerRadius = contentLayout.textFieldBorderRadius;
    self.inputField.variableInputView.circleDiameter = contentLayout.textFieldCircleDiameter;
    self.inputField.variableInputView.circleSpacing = contentLayout.textFieldCircleSpacing;
    self.inputField.variableInputView.outlinePadding = contentLayout.textFieldBorderPadding;
    self.inputField.variableInputView.maximumVisibleLength = maximumInputLength;

    // Submit button
    self.inputField.submitButtonSpacing = contentLayout.submitButtonSpacing;
    self.inputField.submitButtonFontSize = contentLayout.submitButtonFontSize;

    // Keypad
    self.keypadView.buttonNumberFont = contentLayout.circleButtonTitleLabelFont;
    self.keypadView.buttonLetteringFont = contentLayout.circleButtonLetteringLabelFont;
    self.keypadView.buttonLetteringSpacing = contentLayout.circleButtonLetteringSpacing;
    self.keypadView.buttonLabelSpacing = contentLayout.circleButtonLabelSpacing;
    self.keypadView.buttonSpacing = contentLayout.circleButtonSpacing;
    self.keypadView.buttonDiameter = contentLayout.circleButtonDiameter;
}

- (void)applyThemeForStyle:(TOPasscodeViewStyle)style
{
    BOOL isTranslucent = TOPasscodeViewStyleIsTranslucent(style);
    BOOL isDark = TOPasscodeViewStyleIsDark(style);

    // Set title label color
    UIColor *titleLabelColor = self.titleLabelColor;
    if (titleLabelColor == nil) {
        titleLabelColor = isDark ? [UIColor whiteColor] : [UIColor blackColor];
    }
    self.titleLabel.textColor = titleLabelColor;

    // Add/remove the translucency effect to the buttons
    if (isTranslucent) {
        UIBlurEffect *blurEffect = [self blurEffectForStyle:style];
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        self.inputField.effect = vibrancyEffect;
        self.keypadView.vibrancyEffect = vibrancyEffect;
    }
    else {
        self.inputField.effect = nil;
        self.keypadView.vibrancyEffect = nil;
    }

    UIColor *defaultTintColor = isDark ? [UIColor colorWithWhite:0.85 alpha:1.0f] : [UIColor colorWithWhite:0.3 alpha:1.0f];
    
    // Set the tint color of the circle row view
    UIColor *circleRowColor = self.inputProgressViewTintColor;
    if (circleRowColor == nil) {
        circleRowColor = defaultTintColor;
    }
    self.inputField.tintColor = defaultTintColor;

    // Set the tint color of the keypad buttons
    UIColor *keypadButtonBackgroundColor = self.keypadButtonBackgroundColor;
    if (keypadButtonBackgroundColor == nil) {
        keypadButtonBackgroundColor = defaultTintColor;
    }
    self.keypadView.buttonBackgroundColor = keypadButtonBackgroundColor;

    // Set the color of the keypad button labels
    UIColor *buttonTextColor = self.keypadButtonTextColor;
    if (buttonTextColor == nil) {
        buttonTextColor = isDark ? [UIColor whiteColor] : [UIColor blackColor];
    }
    self.keypadView.buttonTextColor = buttonTextColor;

    // Set the highlight color of the keypad button
    UIColor *buttonHighlightedTextColor = self.keypadButtonHighlightedTextColor;
    if (buttonHighlightedTextColor == nil) {
        if (isTranslucent) {
            buttonHighlightedTextColor = isDark ? nil : [UIColor whiteColor];
        }
        else {
            buttonHighlightedTextColor = isDark ? [UIColor blackColor] : [UIColor whiteColor];
        }
    }
    self.keypadView.buttonHighlightedTextColor = buttonHighlightedTextColor;
}

#pragma mark - Passcode Management -
- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact
{
    [self.inputField resetPasscodeAnimated:animated playImpact:impact];
}

- (void)deleteLastPasscodeCharacterAnimated:(BOOL)animated
{
    [self.inputField deletePasscodeCharactersOfCount:1 animated:animated];
}

#pragma mark - Internal Style Management -
- (UIBlurEffect *)blurEffectForStyle:(TOPasscodeViewStyle)style
{
    switch (style) {
        case TOPasscodeViewStyleTranslucentDark:
            return [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        case TOPasscodeViewStyleTranslucentLight:
            return [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        default: return nil;
    }

    return nil;
}

#pragma mark - Accessors -
- (void)setDefaultContentLayout:(TOPasscodeViewContentLayout *)defaultContentLayout
{
    if (defaultContentLayout == _defaultContentLayout) { return; }
    _defaultContentLayout = defaultContentLayout;

    if (!_defaultContentLayout) {
        _defaultContentLayout = [TOPasscodeViewContentLayout defaultScreenContentLayout];
    }
}

- (void)setCurrentLayout:(TOPasscodeViewContentLayout *)currentLayout
{
    if (_currentLayout == currentLayout) { return; }
    _currentLayout = currentLayout;

    // Update the views
    [self updateSubviewsForContentLayout:currentLayout];
}

- (void)setStyle:(TOPasscodeViewStyle)style
{
    if (style == _style) { return; }
    _style = style;
    [self applyThemeForStyle:style];
}

- (void)setLeftButton:(UIButton *)leftButton
{
    if (leftButton == _leftButton) { return; }
    _leftButton = leftButton;
    self.keypadView.leftAccessoryView = leftButton;
}

- (void)setRightButton:(UIButton *)rightButton
{
    if (rightButton == _rightButton) { return; }
    _rightButton = rightButton;
    self.keypadView.rightAccessoryView = rightButton;
}

- (CGFloat)keypadButtonInset
{
    UIView *button = self.keypadView.pinButtons.firstObject;
    return CGRectGetMidX(button.frame);
}

- (void)setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;

    self.titleView.alpha = contentAlpha;
    self.titleLabel.alpha = contentAlpha;
    self.inputField.contentAlpha = contentAlpha;
    self.keypadView.contentAlpha = contentAlpha;
    self.leftButton.alpha = contentAlpha;
    self.rightButton.alpha = contentAlpha;
}

- (void)setPasscode:(NSString *)passcode
{
    [self.inputField setPasscode:passcode];
}

- (NSString *)passcode
{
    return self.inputField.passcode;
}

@end
