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

- (instancetype)initWithFrame:(CGRect)frame style:(TOPINViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
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

    // Configure the theme of all of the views
    [self applyThemeForStyle:_style];
}

#pragma mark - View Setup -
- (void)setUpView
{
    self.backgroundColor = [UIColor clearColor];

    // Set up title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = self.titleText;
    self.titleLabel.font = self.currentLayout.titleLabelFont;
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

- (void)applyThemeForStyle:(TOPINViewStyle)style
{
    
}

#pragma mark - Internal Style Management -

#pragma mark - Accessors -
- (void)setDefaultContentLayout:(TOPINViewContentLayout *)defaultContentLayout
{
    if (defaultContentLayout == _defaultContentLayout) { return; }
    _defaultContentLayout = defaultContentLayout;

    if (!_defaultContentLayout) {
        _defaultContentLayout = [TOPINViewContentLayout defaultScreenContentLayout];
    }
}

@end
