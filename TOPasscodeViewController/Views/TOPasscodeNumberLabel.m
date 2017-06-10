//
//  TOKeypadNumberLabel.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/10/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeNumberLabel.h"

@interface TOPasscodeNumberLabel ()

@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) UILabel *letteringLabel;

@end

@implementation TOPasscodeNumberLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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

- (void)updateLetteringLabelText
{
    if (self.letteringString.length == 0) {
        return;
    }

    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:self.letteringString];
    [attrStr addAttribute:NSKernAttributeName value:@(_letteringCharacterSpacing) range:NSMakeRange(0, attrStr.length-1)];
    self.letteringLabel.attributedText = attrStr;
}

@end
