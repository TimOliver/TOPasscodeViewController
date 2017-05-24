//
//  TOPINCircleButton.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINCircleButton.h"
#import "TOPINCircleView.h"

@interface TOPINCircleButton ()

@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *letteringLabel;
@property (nonatomic, strong) TOPINCircleView *circleView;
@property (nonatomic, strong) UIVisualEffectView *vibrancyView;

@property (nonatomic, readwrite, copy) NSString *numberString;
@property (nonatomic, readwrite, copy) NSString *letteringString;

@end

@implementation TOPINCircleButton

- (instancetype)initWithNumberString:(NSString *)numberString letteringString:(NSString *)letteringString
{
    if (self = [super init]) {
        _numberString = numberString;
        _letteringString = letteringString;
        [self setUp];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    self.userInteractionEnabled = YES;
    
    _textColor = [UIColor whiteColor];
    _numberFont = [UIFont systemFontOfSize:37.5f weight:UIFontWeightThin];
    _letteringFont = [UIFont monospacedDigitSystemFontOfSize:9.0f weight:UIFontWeightThin];
    _letteringVerticalSpacing = 6.0f;

    self.circleView = [[TOPINCircleView alloc] initWithFrame:self.bounds];
    [self addSubview:self.circleView];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self setUpSubviews];

    [self addTarget:self action:@selector(buttonDidTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonDidDragInside:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(buttonDidDragOutside:) forControlEvents:UIControlEventTouchDragExit];
}

- (void)setUpSubviews
{
    if (!self.numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numberLabel.text = self.numberString;
        self.numberLabel.font = self.numberFont;
        self.numberLabel.textColor = self.textColor;
        [self.numberLabel sizeToFit];
        [self addSubview:self.numberLabel];
    }

    if (self.vibrancyEffect && !self.vibrancyView) {
        self.vibrancyView = [[UIVisualEffectView alloc] initWithEffect:self.vibrancyEffect];
        self.vibrancyView.userInteractionEnabled = NO;
        [self.vibrancyView.contentView addSubview:self.circleView];
        [self addSubview:self.vibrancyView];
    }

    if (self.letteringString && !self.letteringLabel) {
        self.letteringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:self.letteringString];
        [attrStr addAttribute:NSKernAttributeName value:@(3.0) range:NSMakeRange(0, attrStr.length-1)];
        self.letteringLabel.attributedText = attrStr;
        self.letteringLabel.font = self.letteringFont;
        self.letteringLabel.textColor = self.textColor;
        [self.letteringLabel sizeToFit];
        [self addSubview:self.letteringLabel];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.vibrancyView.frame = self.bounds;
    self.circleView.frame = self.vibrancyView ? self.vibrancyView.bounds : self.bounds;

    CGSize viewSize = self.frame.size;

    CGFloat numberVerticalHeight = self.numberFont.capHeight;
    CGFloat letteringVerticalHeight = self.letteringFont.capHeight;

    CGFloat textTotalHeight = numberVerticalHeight + self.letteringVerticalSpacing + letteringVerticalHeight;

    CGRect frame = self.numberLabel.frame;
    frame.size.height = numberVerticalHeight;
    frame.origin.x = (viewSize.width - frame.size.width) * 0.5f;
    frame.origin.y = (viewSize.height - textTotalHeight) * 0.5f;
    self.numberLabel.frame = CGRectIntegral(frame);

    if (self.letteringLabel) {
        CGFloat y = CGRectGetMaxY(frame);
        y += self.letteringVerticalSpacing;

        frame = self.letteringLabel.frame;
        frame.size.height = letteringVerticalHeight;
        frame.origin.y = y;
        frame.origin.x = (viewSize.width - frame.size.width) * 0.5f;
        self.letteringLabel.frame = CGRectIntegral(frame);
    }
}

#pragma mark - User Interaction -
- (void)buttonDidTouchDown:(id)sender
{
    if (self.buttonTappedHandler) { self.buttonTappedHandler(); }
    [self.circleView setHighlighted:YES animated:NO];
}

- (void)buttonDidTouchUpInside:(id)sender { [self.circleView setHighlighted:NO animated:YES]; }
- (void)buttonDidDragInside:(id)sender    { [self.circleView setHighlighted:YES animated:NO]; }
- (void)buttonDidDragOutside:(id)sender   { [self.circleView setHighlighted:NO animated:YES]; }

#pragma mark - Accessors -

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.circleView.circleImage = backgroundImage;
    CGRect frame = self.frame;
    frame.size = backgroundImage.size;
    self.frame = frame;
}

- (UIImage *)backgroundImage
{
    return self.circleView.circleImage;
}

- (void)setHightlightedBackgroundImage:(UIImage *)hightlightedBackgroundImage
{
    self.circleView.highlightedCircleImage = hightlightedBackgroundImage;
}

- (UIImage *)hightlightedBackgroundImage
{
    return self.circleView.highlightedCircleImage;
}

@end
