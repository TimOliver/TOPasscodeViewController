//
//  TOPINView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINView.h"
#import "TOPINViewContentLayout.h"
#import "TOPINCircleButton.h"
#import "TOPINCircleRowView.h"
#import "TOPINCircleKeypadView.h"

@interface TOPINView ()

/* The current layout object used to configure this view */
@property (nonatomic, weak) TOPINViewContentLayout *currentLayout;

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) TOPINCircleKeypadView *keypadView;
@property (nonatomic, strong, readwrite) TOPINCircleRowView *circleRowView;

@end

@implementation TOPINView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithStyle:(TOPINViewStyle)style
{
    if (self = [super initWithFrame:CGRectMake(0,0,320,393)]) {
        _style = style;
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
    _defaultContentLayout = [TOPINViewContentLayout defaultScreenContentLayout];
    _currentLayout = _defaultContentLayout;
    _contentLayouts = @[[TOPINViewContentLayout mediumScreenContentLayout],
                        [TOPINViewContentLayout smallScreenContentLayout]];
    _titleText = @"Enter Passcode";

    // Start configuring views
    [self setUpView];

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
        self.titleView.frame = frame;

        y = CGRectGetMaxY(frame) + self.currentLayout.titleViewBottomSpacing;
    }

    // Title Label
    frame = self.titleLabel.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.titleLabel.frame = frame;

    y = CGRectGetMaxY(frame) + self.currentLayout.titleLabelBottomSpacing;

    // Circle Row View
    frame = self.circleRowView.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.circleRowView.frame = frame;

    y = CGRectGetMaxY(frame) + self.currentLayout.circleRowBottomSpacing;

    // PIN Pad View
    frame = self.keypadView.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.keypadView.frame = frame;
}

- (void)sizeToFitWidth:(CGFloat)width
{
    NSMutableArray *layouts = [NSMutableArray array];
    [layouts addObject:self.defaultContentLayout];
    [layouts addObjectsFromArray:self.contentLayouts];

    // Loop through each layout (in ascending order) and pick the best one to fit this view
    TOPINViewContentLayout *contentLayout = self.defaultContentLayout;
    for (TOPINViewContentLayout *layout in layouts) {
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
    [self.circleRowView sizeToFit];
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
    frame.size.height += self.circleRowView.frame.size.height;
    frame.size.height += self.currentLayout.circleRowBottomSpacing;

    // Add height for the keypad
    frame.size.height += self.keypadView.frame.size.height;

    // Set the frame back
    self.frame = frame;
}

#pragma mark - View Setup -
- (void)setUpView
{
    self.backgroundColor = [UIColor clearColor];

    // Set up title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];

    // Set up circle rows
    self.circleRowView = [[TOPINCircleRowView alloc] init];
    [self addSubview:self.circleRowView];

    // Set up pad row
    self.keypadView = [[TOPINCircleKeypadView alloc] init];
    [self addSubview:self.keypadView];
}

- (void)updateSubviewsForContentLayout:(TOPINViewContentLayout *)contentLayout
{
    // Title View
    self.titleLabel.font = contentLayout.titleLabelFont;

    // Circle Row View
    self.circleRowView.circleDiameter = contentLayout.circleRowDiameter;
    self.circleRowView.circleSpacing = contentLayout.circleRowSpacing;

    // Keypad
    self.keypadView.buttonNumberFont = contentLayout.circleButtonTitleLabelFont;
    self.keypadView.buttonLetteringFont = contentLayout.circleButtonLetteringLabelFont;
    self.keypadView.buttonLetteringSpacing = contentLayout.circleButtonLetteringSpacing;
    self.keypadView.buttonLabelSpacing = contentLayout.circleButtonLabelSpacing;
    self.keypadView.buttonSpacing = contentLayout.circleButtonSpacing;
    self.keypadView.buttonDiameter = contentLayout.circleButtonDiameter;
}

- (void)applyThemeForStyle:(TOPINViewStyle)style
{
    BOOL isTranslucent = TOPINViewStyleIsTranslucent(style);
    BOOL isDark = TOPINViewStyleIsDark(style);

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
        self.circleRowView.effect = vibrancyEffect;
        self.keypadView.vibrancyEffect = vibrancyEffect;
    }
    else {
        self.circleRowView.effect = nil;
        self.keypadView.vibrancyEffect = nil;
    }

    UIColor *defaultTintColor = isDark ? [UIColor colorWithWhite:0.75 alpha:1.0f] : [UIColor colorWithWhite:0.3 alpha:1.0f];

    // Set the tint color of the circle row view
    UIColor *circleRowColor = self.inputProgressViewTintColor;
    if (circleRowColor == nil) {
        circleRowColor = defaultTintColor;
    }
    self.circleRowView.tintColor = defaultTintColor;

    // Set the tint color of the keypad buttons
    UIColor *keypadButtonBackgroundColor = self.keypadButtonBackgroundColor;
    if (keypadButtonBackgroundColor == nil) {
        keypadButtonBackgroundColor = defaultTintColor;
    }
    self.keypadView.tintColor = keypadButtonBackgroundColor;

    // Set the color of the keypad button labels
    UIColor *buttonTextColor = self.keypadButtonTextColor;
    if (buttonTextColor == nil) {
        buttonTextColor = isDark ? [UIColor whiteColor] : [UIColor blackColor];
    }
    self.keypadView.buttonTextColor = buttonTextColor;

    // Set the highlight color of the keypad button
    UIColor *buttonHighlightedTextColor = self.keypadButtonHighlightedTextColor;
    if (buttonHighlightedTextColor == nil) {
        buttonHighlightedTextColor = isDark ? nil : [UIColor whiteColor];
    }
    self.keypadView.buttonHighlightedTextColor = buttonHighlightedTextColor;
}

#pragma mark - Internal Style Management -
- (UIBlurEffect *)blurEffectForStyle:(TOPINViewStyle)style
{
    switch (style) {
        case TOPINViewStyleTranslucentDark:
            return [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        case TOPINViewStyleTranslucentLight:
            return [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        case TOPINViewStyleTranslucentExtraLight:
            return [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        default: return nil;
    }

    return nil;
}

#pragma mark - Accessors -
- (void)setDefaultContentLayout:(TOPINViewContentLayout *)defaultContentLayout
{
    if (defaultContentLayout == _defaultContentLayout) { return; }
    _defaultContentLayout = defaultContentLayout;

    if (!_defaultContentLayout) {
        _defaultContentLayout = [TOPINViewContentLayout defaultScreenContentLayout];
    }
}

- (void)setCurrentLayout:(TOPINViewContentLayout *)currentLayout
{
    if (_currentLayout == currentLayout) { return; }
    _currentLayout = currentLayout;

    // Update the views
    [self updateSubviewsForContentLayout:currentLayout];
}

- (void)setStyle:(TOPINViewStyle)style
{
    if (style == _style) { return; }
    _style = style;
    [self applyThemeForStyle:style];
}

@end
