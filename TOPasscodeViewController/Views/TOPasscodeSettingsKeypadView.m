//
//  TOPasscodeSettingsKeypadView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/18/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsKeypadView.h"
#import "TOPasscodeSettingsKeypadButton.h"
#import "TOPasscodeButtonLabel.h"

const CGFloat kTOPasscodeSettingsKeypadButtonSpacing = 7.0f;
const CGFloat kTOPasscodeSettingsKeypadCornderRadius = 15.0f;

@interface TOPasscodeSettingsKeypadView ()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) NSArray<UIButton *> *keypadButtons;

@end

@implementation TOPasscodeSettingsKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    /* Button label styling */
    _keypadButtonNumberFont = [UIFont systemFontOfSize:17.0f weight:UIFontWeightRegular];
    _keypadButtonLetteringFont = [UIFont systemFontOfSize:12.0f weight:UIFontWeightThin];
    _keypadButtonVerticalSpacing = 3.0f;
    _keypadButtonHorizontalSpacing = 3.0f;
    _keypadButtonLetteringSpacing = 3.0f;

    CGSize viewSize = self.frame.size;
    CGFloat height = 1.0f / [[UIScreen mainScreen] scale];
    self.separatorView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,{viewSize.width, height}}];
    self.separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.separatorView];

    [self applyTheme];
}

- (void)setUpKeypadButtons
{
    NSInteger numberOfButtons = 10;
    NSArray *letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL",
                                @"MNO", @"PQRS", @"TUV", @"WXYZ"];

    NSMutableArray *buttons = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < numberOfButtons; i++) {
        TOPasscodeSettingsKeypadButton *button = [TOPasscodeSettingsKeypadButton button];
        button.buttonLabel.numberString = [NSString stringWithFormat:@"%ld", (i+1) % 10];

        if (i > 0) {
            NSInteger j = i - 1;
            if (j < letteredTitles.count) {
                button.buttonLabel.letteringString = letteredTitles[j];
            }
        }

        [self addSubview:button];
        [buttons addObject:button];
    }

    self.keypadButtons = [NSArray arrayWithArray:buttons];
}

- (void)applyTheme
{


}

- (void)setDefaultValuesForStye:(TOPasscodeSettingsViewStyle)style
{
    BOOL isDark = style == TOPasscodeSettingsViewStyleDark;

    // Keypad label
    self.keypadButtonLabelTextColor = isDark ? [UIColor whiteColor] : [UIColor blackColor];

    self.keypadButtonForegroundColor = isDark ? [UIColor colorWithWhite:0.3f alpha:1.0f] : [UIColor whiteColor];
    self.keypadButtonTappedForegroundColor = isDark ? [UIColor colorWithWhite:0.3f alpha:1.0f] : [UIColor whiteColor];

    // Button border color
    UIColor *borderColor = nil;
    if (isDark) {
        borderColor = [UIColor colorWithWhite:0.2 alpha:1.0f];
    }
    else {
        borderColor = [UIColor colorWithRed:166.0f/255.0f green:174.0f/255.0f blue:186.0f/255.0f alpha:1.0f];
    }
    self.keypadButtonBorderColor = borderColor;

    // Background Color
    UIColor *backgroundColor = nil;
    if (isDark) {
        backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    }
    else {
        backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:225.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    }
    self.backgroundColor = backgroundColor;

    // Separator lines
    UIColor *separatorColor = nil;
    if (isDark) {
        separatorColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    }
    else {
        separatorColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    }
    self.separatorView.backgroundColor = separatorColor;
}

- (void)setStyle:(TOPasscodeSettingsViewStyle)style
{
    if (style == _style) {
        return;
    }

    _style = style;
    [self setDefaultValuesForStye:style];
    [self applyTheme];
}

@end
