//
//  TOPasscodeCircleButton.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeCircleButton.h"
#import "TOPasscodeCircleView.h"
#import "TOPasscodeButtonLabel.h"

@interface TOPasscodeCircleButton ()

@property (nonatomic, strong, readwrite) TOPasscodeButtonLabel *buttonLabel;
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

    if (!self.buttonLabel) {
        self.buttonLabel = [[TOPasscodeButtonLabel alloc] initWithFrame:self.bounds];
        self.buttonLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.buttonLabel.userInteractionEnabled = NO;
        self.buttonLabel.letteringVerticalSpacing = self.letteringVerticalSpacing;
        self.buttonLabel.letteringCharacterSpacing = self.letteringCharacterSpacing;
        self.buttonLabel.textColor = self.textColor;
        self.buttonLabel.numberString = self.numberString;
        self.buttonLabel.letteringString = self.letteringString;
        [self addSubview:self.buttonLabel];
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
    self.buttonLabel.frame = self.bounds;
    [self bringSubviewToFront:self.buttonLabel];
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
        self.buttonLabel.textColor = highlighted ? self.highlightedTextColor : self.textColor;
    };

    if (!animated) {
        textFadeBlock();
        return;
    }

    [UIView transitionWithView:self.buttonLabel
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
    self.buttonLabel.numberLabel.font = numberFont;
    [self setNeedsLayout];
}

- (UIFont *)numberFont { return self.buttonLabel.numberLabel.font; }

- (void)setLetteringFont:(UIFont *)letteringFont
{
    self.buttonLabel.letteringLabel.font = letteringFont;
    [self setNeedsLayout];
}

- (UIFont *)letteringFont { return self.buttonLabel.letteringLabel.font; }

- (void)setLetteringVerticalSpacing:(CGFloat)letteringVerticalSpacing
{
    _letteringVerticalSpacing = letteringVerticalSpacing;
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor == _textColor) { return; }
    _textColor = textColor;

    self.buttonLabel.textColor = _textColor;
}

@end
