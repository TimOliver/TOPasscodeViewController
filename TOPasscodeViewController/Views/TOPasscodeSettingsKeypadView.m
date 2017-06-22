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
#import "TOSettingsKeypadImage.h"

const CGFloat kTOPasscodeSettingsKeypadButtonSpacing = 3.0f;
const CGFloat kTOPasscodeSettingsKeypadCornderRadius = 15.0f;

@interface TOPasscodeSettingsKeypadView ()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) NSArray<TOPasscodeSettingsKeypadButton *> *keypadButtons;

@property (nonatomic, strong) UIImage *buttonBackgroundImage;
@property (nonatomic, strong) UIImage *buttonTappedBackgroundImage;

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

    [self setUpKeypadButtons];

    [self setUpDefaultValuesForStye:_style];
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

- (void)setUpDefaultValuesForStye:(TOPasscodeSettingsViewStyle)style
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

- (void)setUpImagesIfNeeded
{
    if (self.buttonBackgroundImage && self.buttonTappedBackgroundImage) {
        return;
    }

    if (self.buttonBackgroundImage == nil) {
        self.buttonBackgroundImage = [TOSettingsKeypadImage buttonImageWithCornerRadius:kTOPasscodeSettingsKeypadCornderRadius
                                                                              foregroundColor:self.keypadButtonForegroundColor
                                                                                    edgeColor:self.keypadButtonBorderColor
                                                                                edgeThickness:2.0f];
    }

    if (self.buttonTappedBackgroundImage == nil) {
        self.buttonTappedBackgroundImage = [TOSettingsKeypadImage buttonImageWithCornerRadius:kTOPasscodeSettingsKeypadCornderRadius
                                                                              foregroundColor:self.keypadButtonTappedForegroundColor
                                                                                    edgeColor:self.keypadButtonBorderColor
                                                                                edgeThickness:2.0f];
    }

    for (TOPasscodeSettingsKeypadButton *button in self.keypadButtons) {
        button.buttonBackgroundImage = self.buttonBackgroundImage;
        button.buttonTappedBackgroundImage = self.buttonTappedBackgroundImage;
    }
}

- (void)applyTheme
{
    for (TOPasscodeSettingsKeypadButton *button in self.keypadButtons) {
        button.buttonLabel.textColor = self.keypadButtonLabelTextColor;
        button.buttonLabel.letteringCharacterSpacing = self.keypadButtonLetteringSpacing;
        button.buttonLabel.letteringVerticalSpacing = self.keypadButtonVerticalSpacing;
        button.buttonLabel.letteringHorizontalSpacing = self.keypadButtonHorizontalSpacing;
        button.buttonLabel.numberLabel.font = self.keypadButtonNumberFont;
        button.buttonLabel.letteringLabel.font = self.keypadButtonLetteringFont;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setUpImagesIfNeeded];

    CGSize viewSize = self.bounds.size;
    CGSize buttonSize = CGSizeZero;

    // Four rows of three buttons
    buttonSize.width = floorf((viewSize.width / 3.0f) - (kTOPasscodeSettingsKeypadButtonSpacing * 2.0f));
    buttonSize.height = floorf((viewSize.height / 4.0f) - (kTOPasscodeSettingsKeypadButtonSpacing * 2.0f));

    CGPoint point = CGPointMake(kTOPasscodeSettingsKeypadButtonSpacing, kTOPasscodeSettingsKeypadButtonSpacing);
    CGRect buttonFrame = (CGRect){point, buttonSize};

    NSInteger i = 0;
    for (TOPasscodeSettingsKeypadButton *button in self.keypadButtons) {
        button.frame = buttonFrame;
        buttonFrame.origin.x += buttonFrame.size.width + kTOPasscodeSettingsKeypadButtonSpacing * 2.0f;

        if (++i % 3 == 0) {
            buttonFrame.origin.x = kTOPasscodeSettingsKeypadButtonSpacing;
            buttonFrame.origin.y += buttonFrame.size.height + kTOPasscodeSettingsKeypadButtonSpacing;
        }

        if (button == self.keypadButtons.lastObject) {
            buttonFrame.origin.x += buttonFrame.size.width;
            button.frame = buttonFrame;
        }
    }
}

#pragma mark - Accessors -

- (void)setStyle:(TOPasscodeSettingsViewStyle)style
{
    if (style == _style) {
        return;
    }

    _style = style;
    [self setUpDefaultValuesForStye:_style];
    [self applyTheme];
}

@end
