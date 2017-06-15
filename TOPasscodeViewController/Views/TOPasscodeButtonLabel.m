//
//  TOKeypadNumberLabel.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/10/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeButtonLabel.h"

@interface TOPasscodeButtonLabel ()

@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) UILabel *letteringLabel;

@end

@implementation TOPasscodeButtonLabel

#pragma mark - View Setup -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _letteringVerticalSpacing = 6.0f;
        _letteringCharacterSpacing = 3.0f;
        [self setUpViews];
    }

    return self;
}

- (void)setUpViews
{
    if (!self.numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.numberLabel.text = self.numberString;
        self.numberLabel.font = [UIFont systemFontOfSize:37.5f weight:UIFontWeightThin];;
        self.numberLabel.textColor = self.textColor;
        [self.numberLabel sizeToFit];
        [self addSubview:self.numberLabel];
    }

    if (!self.letteringLabel) {
        self.letteringLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.letteringLabel.font = [UIFont monospacedDigitSystemFontOfSize:9.0f weight:UIFontWeightThin];
        self.letteringLabel.textColor = self.textColor;
        [self.letteringLabel sizeToFit];
        [self addSubview:self.letteringLabel];
        [self updateLetteringLabelText];
    }
}

#pragma mark - View Layout -

- (void)updateLetteringLabelText
{
    if (self.letteringString.length == 0) {
        return;
    }

    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:self.letteringString];
    [attrStr addAttribute:NSKernAttributeName value:@(_letteringCharacterSpacing) range:NSMakeRange(0, attrStr.length-1)];
    self.letteringLabel.attributedText = attrStr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize viewSize = self.bounds.size;

    UIFont *numberFont = self.numberLabel.font;
    UIFont *letteringFont = self.letteringLabel.font;

    CGFloat numberVerticalHeight = numberFont.capHeight;
    CGFloat letteringVerticalHeight = letteringFont.capHeight;
    CGFloat textTotalHeight = (numberVerticalHeight+2.0f) + self.letteringVerticalSpacing + (letteringVerticalHeight+2.0f);

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

#pragma mark - Accessors -

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor == _textColor) { return; }
    _textColor = textColor;

    self.numberLabel.textColor = _textColor;
    self.letteringLabel.textColor = _textColor;
}
/***********************************************************/

- (void)setNumberString:(NSString *)numberString
{
    self.numberLabel.text = numberString;
    [self setNeedsLayout];
}

- (NSString *)numberString { return self.numberLabel.text; }

/***********************************************************/

- (void)setLetteringString:(NSString *)letteringString
{
    _letteringString = [letteringString copy];
    [self updateLetteringLabelText];
    [self setNeedsLayout];
}

/***********************************************************/

- (void)setLetteringCharacterSpacing:(CGFloat)letteringCharacterSpacing
{
    _letteringCharacterSpacing = letteringCharacterSpacing;
    [self updateLetteringLabelText];
}

@end
