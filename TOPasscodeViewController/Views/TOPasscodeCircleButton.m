//
//  TOPasscodeCircleButton.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeCircleButton.h"
#import "TOPasscodeCircleView.h"
#import "TOPasscodeNumberLabel.h"

@interface TOPasscodeCircleButton ()

@property (nonatomic, strong, readwrite) TOPasscodeNumberLabel *numberLabel;
@property (nonatomic, strong, readwrite) TOPasscodeCircleView *circleView;
@property (nonatomic, strong, readwrite) UIVisualEffectView *vibrancyView;

@property (nonatomic, readwrite, copy) NSString *numberString;
@property (nonatomic, readwrite, copy) NSString *letteringString;

@end

@implementation TOPasscodeCircleButton

- (instancetype)initWithNumberString:(NSString *)numberString letteringString:(NSString *)letteringString
{
    if (self = [super init]) {
        _numberString = numberString;
        _letteringString = letteringString;
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    self.userInteractionEnabled = YES;
    
    _textColor = [UIColor whiteColor];
    _letteringVerticalSpacing = 6.0f;
    _letteringCharacterSpacing = 3.0f;

    [self setUpSubviews];
    [self setUpViewInteraction];
}

- (void)setUpSubviews
{
    if (!self.circleView) {
        self.circleView = [[TOPasscodeCircleView alloc] initWithFrame:self.bounds];
        [self addSubview:self.circleView];
    }

    if (!self.numberLabel) {
        self.numberLabel = [[TOPasscodeNumberLabel alloc] initWithFrame:self.bounds];
        self.numberLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.numberLabel.userInteractionEnabled = NO;
        [self addSubview:self.numberLabel];
    }

    if (!self.vibrancyView) {
        self.vibrancyView = [[UIVisualEffectView alloc] initWithEffect:nil];
        self.vibrancyView.userInteractionEnabled = NO;
        [self.vibrancyView.contentView addSubview:self.circleView];
        [self addSubview:self.vibrancyView];
    }
}

- (void)setUpViewInteraction
{
    if (self.allTargets.count) { return; }

    [self addTarget:self action:@selector(buttonDidTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonDidDragInside:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(buttonDidDragOutside:) forControlEvents:UIControlEventTouchDragExit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.vibrancyView.frame = self.bounds;
    self.circleView.frame = self.vibrancyView ? self.vibrancyView.bounds : self.bounds;

    CGSize viewSize = self.frame.size;

    CGFloat numberVerticalHeight = self.numberFont.capHeight;
    CGFloat letteringVerticalHeight = self.letteringFont.capHeight;

    CGFloat textTotalHeight = (numberVerticalHeight+2.0f) + self.letteringVerticalSpacing + (letteringVerticalHeight+2.0f);

    [self bringSubviewToFront:self.labelContainerView];

    [self.numberLabel sizeToFit];
    CGRect frame = self.numberLabel.frame;
    frame.size.height = ceil(numberVerticalHeight) + 2.0f;
    frame.origin.x = ceilf((viewSize.width - frame.size.width) * 0.5f);
    frame.origin.y = floorf((viewSize.height - textTotalHeight) * 0.5f);
    self.numberLabel.frame = CGRectIntegral(frame);

    if (self.letteringLabel) {
        [self.letteringLabel sizeToFit];

        CGFloat y = CGRectGetMaxY(frame);
        y += self.letteringVerticalSpacing;

        frame = self.letteringLabel.frame;
        frame.size.height = ceil(letteringVerticalHeight) + 2.0f;
        frame.origin.y = floorf(y);
        frame.origin.x = (viewSize.width - frame.size.width) * 0.5f;
        self.letteringLabel.frame = CGRectIntegral(frame);
    }
}

#pragma mark - User Interaction -
- (void)buttonDidTouchDown:(id)sender
{
    if (self.buttonTappedHandler) { self.buttonTappedHandler(); }
    [self setHighlighted:YES animated:NO];
}

- (void)buttonDidTouchUpInside:(id)sender { [self setHighlighted:NO animated:YES]; }
- (void)buttonDidDragInside:(id)sender    { [self setHighlighted:YES animated:NO]; }
- (void)buttonDidDragOutside:(id)sender   { [self setHighlighted:NO animated:YES]; }

#pragma mark - Accessors -

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [self.circleView setHighlighted:highlighted animated:animated];

    if (!self.highlightedTextColor) { return; }

    void (^textFadeBlock)() = ^{
        self.numberLabel.textColor = highlighted ? self.highlightedTextColor : self.textColor;
        self.letteringLabel.textColor = highlighted ? self.highlightedTextColor : self.textColor;
    };

    if (!animated) {
        textFadeBlock();
        return;
    }

    [UIView transitionWithView:self.labelContainerView
                      duration:0.6f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:textFadeBlock
                    completion:nil];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.circleView.circleImage = backgroundImage;
    CGRect frame = self.frame;
    frame.size = backgroundImage.size;
    self.frame = frame;
}

- (void)setVibrancyEffect:(UIVibrancyEffect *)vibrancyEffect
{
    if (_vibrancyEffect == vibrancyEffect) { return; }
    _vibrancyEffect = vibrancyEffect;
    self.vibrancyView.effect = _vibrancyEffect;
}

- (UIImage *)backgroundImage { return self.circleView.circleImage; }

- (void)setHightlightedBackgroundImage:(UIImage *)hightlightedBackgroundImage
{
    self.circleView.highlightedCircleImage = hightlightedBackgroundImage;
}

- (UIImage *)hightlightedBackgroundImage { return self.circleView.highlightedCircleImage; }

- (void)setNumberFont:(UIFont *)numberFont
{
    self.numberLabel.font = numberFont;
    [self setNeedsLayout];
}

- (UIFont *)numberFont { return self.numberLabel.font; }

- (void)setLetteringFont:(UIFont *)letteringFont
{
    self.letteringLabel.font = letteringFont;
    [self setNeedsLayout];
}

- (UIFont *)letteringFont { return self.letteringLabel.font; }

- (void)setLetteringString:(NSString *)letteringString
{
    if (letteringString == _letteringString) { return; }
    _letteringString = letteringString;
    [self updateLetteringLabelText];
    [self setNeedsLayout];
}

- (void)setLetteringCharacterSpacing:(CGFloat)letteringCharacterSpacing
{
    _letteringCharacterSpacing = letteringCharacterSpacing;
    [self updateLetteringLabelText];
    [self setNeedsLayout];
}

- (void)setLetteringVerticalSpacing:(CGFloat)letteringVerticalSpacing
{
    _letteringVerticalSpacing = letteringVerticalSpacing;
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor == _textColor) { return; }
    _textColor = textColor;

    self.numberLabel.textColor = _textColor;
    self.letteringLabel.textColor = _textColor;
}

@end
