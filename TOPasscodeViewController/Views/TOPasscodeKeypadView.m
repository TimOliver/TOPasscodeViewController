//
//  TOPasscodeCircleKeypadView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeKeypadView.h"
#import "TOPasscodeCircleImage.h"
#import "TOPasscodeCircleButton.h"
#import "TOPasscodeCircleView.h"

@interface TOPasscodeKeypadView()

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *tappedButtonImage;

@property (nonatomic, strong, readwrite) NSArray<TOPasscodeCircleButton *> *pinButtons;

@end

@implementation TOPasscodeKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _buttonDiameter = 81.0f;
        _buttonSpacing = (CGSize){25,15};
        _buttonStrokeWidth = 1.5f;
        _showLettering = YES;
        _buttonNumberFont = nil;
        _buttonLetteringFont = nil;
        _buttonLabelSpacing = FLT_MIN;
        _buttonLetteringSpacing = FLT_MIN;
        [self sizeToFit];
    }

    return self;
}

- (void)setUpButtons
{
    NSMutableArray *buttons = [NSMutableArray array];

    NSInteger numberOfButtons = 10;
    NSArray *letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL",
                                @"MNO", @"PQRS", @"TUV", @"WXYZ"];

    __weak typeof(self) weakSelf = self;

    for (NSInteger i = 0; i < numberOfButtons; i++) {
        // Work out the button number text
        NSInteger buttonNumber = i + 1;
        if (buttonNumber == 10) { buttonNumber = 0; }
        NSString *numberString = [NSString stringWithFormat:@"%ld", (long)buttonNumber];

        // Work out the lettering text
        NSString *letteringString = nil;
        if (self.showLettering && i > 0 && i-1 < letteredTitles.count) {
            letteringString = letteredTitles[i-1];
        }

        // Create a new button
        TOPasscodeCircleButton *circleButton = [[TOPasscodeCircleButton alloc] initWithNumberString:numberString letteringString:letteringString];
        circleButton.backgroundImage = self.buttonImage;
        circleButton.hightlightedBackgroundImage = self.tappedButtonImage;
        circleButton.vibrancyEffect = self.vibrancyEffect;

        // Add handler for when button is tapped
        circleButton.buttonTappedHandler = ^{
            if (weakSelf.buttonTappedHandler) {
                weakSelf.buttonTappedHandler(buttonNumber);
            }
        };

        // Add the button
        [self addSubview:circleButton];
        [buttons addObject:circleButton];
    }

    _pinButtons = [NSArray arrayWithArray:buttons];
}

- (void)sizeToFit
{
    CGFloat padding = 2.0f;

    CGRect frame = self.frame;
    frame.size.width  = ((self.buttonDiameter + padding) * 3) + (self.buttonSpacing.width * 2);
    frame.size.height = ((self.buttonDiameter + padding) * 4) + (self.buttonSpacing.height * 3);
    self.frame = frame;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger i = 0;
    CGPoint origin = CGPointZero;
    for (TOPasscodeCircleButton *button in self.pinButtons) {
        CGRect frame = button.frame;
        frame.origin = origin;
        button.frame = frame;

        CGFloat horizontalOffset = frame.size.width + self.buttonSpacing.width;
        origin.x += horizontalOffset;

        i++;
        if (i % 3 == 0) {
            origin.x = 0.0f;
            origin.y = origin.y + frame.size.height + self.buttonSpacing.height;
        }
    }

    TOPasscodeCircleButton *lastButton = self.pinButtons.lastObject;
    CGRect frame = lastButton.frame;
    frame.origin.x += (frame.size.width + self.buttonSpacing.width);
    lastButton.frame = frame;

    CGFloat midPointY = CGRectGetMidY(frame);

    if (self.leftAccessoryView) {
        CGRect leftButtonFrame = self.pinButtons.firstObject.frame;
        CGFloat midPointX = CGRectGetMidX(leftButtonFrame);

        [self.leftAccessoryView sizeToFit];
        self.leftAccessoryView.center = (CGPoint){midPointX, midPointY};
    }

    if (self.rightAccessoryView) {
        CGRect rightButtonFrame = self.pinButtons[2].frame;
        CGFloat midPointX = CGRectGetMidX(rightButtonFrame);

        [self.rightAccessoryView sizeToFit];
        self.rightAccessoryView.center = (CGPoint){midPointX, midPointY};
    }
}

#pragma mark - Style Accessors -
- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect
{
    if (vibrancyEffect == _vibrancyEffect) { return; }
    _vibrancyEffect = vibrancyEffect;

    for (TOPasscodeCircleButton *button in self.pinButtons) {
        button.vibrancyEffect = _vibrancyEffect;
    }
}

#pragma mark - Lazy Getters -
- (UIImage *)buttonImage
{
    if (!_buttonImage) {
        _buttonImage = [TOPasscodeCircleImage hollowCircleImageOfSize:self.buttonDiameter strokeWidth:self.buttonStrokeWidth padding:1.0f];
    }

    return _buttonImage;
}

- (UIImage *)tappedButtonImage
{
    if (!_tappedButtonImage) {
        _tappedButtonImage = [TOPasscodeCircleImage circleImageOfSize:self.buttonDiameter inset:self.buttonStrokeWidth * 0.5f padding:1.0f];
    }

    return _tappedButtonImage;
}

- (NSArray<TOPasscodeCircleButton *> *)pinButtons
{
    if (_pinButtons) { return _pinButtons; }
    [self setUpButtons];
    return _pinButtons;
}

#pragma mark - Public Layout Setters -
- (void)updateButtonsForCurrentState
{
    for (TOPasscodeCircleButton *circleButton in self.pinButtons) {
        circleButton.backgroundImage = self.buttonImage;
        circleButton.hightlightedBackgroundImage = self.tappedButtonImage;
        circleButton.numberFont = self.buttonNumberFont;
        circleButton.letteringFont = self.buttonLetteringFont;
        circleButton.letteringVerticalSpacing = self.buttonLabelSpacing;
        circleButton.letteringCharacterSpacing = self.buttonLetteringSpacing;
        circleButton.tintColor = self.buttonBackgroundColor;
        circleButton.textColor = self.buttonTextColor;
        circleButton.highlightedTextColor = self.buttonHighlightedTextColor;
    }

    [self setNeedsLayout];
}

- (void)setButtonDiameter:(CGFloat)buttonDiameter
{
    if (_buttonDiameter == buttonDiameter) { return; }
    _buttonDiameter = buttonDiameter;
    _tappedButtonImage = nil;
    _buttonImage = nil;
    [self updateButtonsForCurrentState];
}

- (void)setButtonSpacing:(CGSize)buttonSpacing
{
    if (CGSizeEqualToSize(_buttonSpacing, buttonSpacing)) { return; }
    _buttonSpacing = buttonSpacing;
    [self updateButtonsForCurrentState];
}

- (void)setButtonStrokeWidth:(CGFloat)buttonStrokeWidth
{
    if (_buttonStrokeWidth== buttonStrokeWidth) { return; }
    _buttonStrokeWidth = buttonStrokeWidth;
    _tappedButtonImage = nil;
    _buttonImage = nil;
    [self updateButtonsForCurrentState];
}

- (void)setShowLettering:(BOOL)showLettering
{
    if (_showLettering == showLettering) { return; }
    _showLettering = showLettering;
    [self updateButtonsForCurrentState];
}

- (void)setButtonNumberFont:(UIFont *)buttonNumberFont
{
    if (_buttonNumberFont == buttonNumberFont) { return; }
    _buttonNumberFont = buttonNumberFont;
    [self updateButtonsForCurrentState];
}

- (void)setButtonLetteringFont:(UIFont *)buttonLetteringFont
{
    if (buttonLetteringFont == _buttonLetteringFont) { return; }
    _buttonLetteringFont = buttonLetteringFont;
    [self updateButtonsForCurrentState];
}

- (void)setButtonLabelSpacing:(CGFloat)buttonLabelSpacing
{
    if (buttonLabelSpacing == _buttonLabelSpacing) { return; }
    _buttonLabelSpacing = buttonLabelSpacing;
    [self updateButtonsForCurrentState];
}

- (void)setButtonLetteringSpacing:(CGFloat)buttonLetteringSpacing
{
    if (buttonLetteringSpacing == _buttonLetteringSpacing) { return; }
    _buttonLetteringSpacing = buttonLetteringSpacing;
    [self updateButtonsForCurrentState];
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor
{
    if (buttonBackgroundColor == _buttonBackgroundColor) { return; }
    _buttonBackgroundColor = buttonBackgroundColor;
    [self updateButtonsForCurrentState];
}

- (void)setButtonTextColor:(UIColor *)buttonTextColor
{
    if (buttonTextColor == _buttonTextColor) { return; }
    _buttonTextColor = buttonTextColor;
    [self updateButtonsForCurrentState];
}

- (void)setButtonHighlightedTextColor:(UIColor *)buttonHighlightedTextColor
{
    if (buttonHighlightedTextColor == _buttonHighlightedTextColor) { return; }
    _buttonHighlightedTextColor = buttonHighlightedTextColor;
    [self updateButtonsForCurrentState];
}

- (void)setLeftAccessoryView:(UIView *)leftAccessoryView
{
    if (_leftAccessoryView == leftAccessoryView) { return; }
    _leftAccessoryView = leftAccessoryView;
    [self addSubview:_leftAccessoryView];
    [self setNeedsLayout];
}

- (void)setRightAccessoryView:(UIView *)rightAccessoryView
{
    if (_rightAccessoryView == rightAccessoryView) { return; }
    _rightAccessoryView = rightAccessoryView;
    [self addSubview:_rightAccessoryView];
    [self setNeedsLayout];
}

- (void)setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;

    for (TOPasscodeCircleButton *button in self.pinButtons) {
        button.labelContainerView.alpha = contentAlpha;
        button.circleView.alpha = contentAlpha;
    }
}

@end
