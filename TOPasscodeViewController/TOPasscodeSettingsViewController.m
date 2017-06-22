//
//  TOPasscodeSettingsViewController.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/8/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsViewController.h"
#import "TOPasscodeNumberInputView.h"
#import "TOPasscodeSettingsKeypadView.h"

const CGFloat kTOPasscodeSettingsLabelInputSpacing = 15.0f;
const CGFloat kTOPasscodeKeypadMaxSizeRatio = 0.40f;
const CGFloat kTOPasscodeKeypadMinHeight = 200.0f;
const CGFloat kTOPasscodeKeypadMaxHeight = 330.0f;

@interface TOPasscodeSettingsViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TOPasscodeNumberInputView *numberInputView;
@property (nonatomic, strong) TOPasscodeSettingsKeypadView *keypadView;

@end

@implementation TOPasscodeSettingsViewController

- (instancetype)initWithStyle:(TOPasscodeSettingsViewStyle)style
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _style = style;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;

    self.title = NSLocalizedString(@"Enter Passcode", @"");

    // Create container view
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin
                                            | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.containerView];

    // Create title label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"Enter your passcode";
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.titleLabel sizeToFit];
    [self.containerView addSubview:self.titleLabel];

    // Create number view
    self.numberInputView = [[TOPasscodeNumberInputView alloc] initWithRequiredLength:4];
    self.numberInputView.tintColor = [UIColor blackColor];
    self.numberInputView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.numberInputView sizeToFit];
    [self.containerView addSubview:self.numberInputView];

    // Create keypad view
    self.keypadView = [[TOPasscodeSettingsKeypadView alloc] initWithFrame:CGRectZero];
    self.keypadView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.keypadView];

    // Add callbacks for the keypad view
    self.keypadView.numberButtonTappedHandler= ^(NSInteger number) {
        NSString *numberString = [NSString stringWithFormat:@"%ld", number];
        [weakSelf.numberInputView appendPasscodeCharacters:numberString animated:NO];
    };

    self.keypadView.deleteButtonTappedHandler = ^{ [weakSelf.numberInputView deletePasscodeCharactersOfCount:1 animated:YES]; };

    // Set height of the container view (This will never change)
    CGRect frame = self.containerView.frame;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = CGRectGetHeight(self.titleLabel.frame) + CGRectGetHeight(self.numberInputView.frame)
                            + kTOPasscodeSettingsLabelInputSpacing;
    self.containerView.frame = CGRectIntegral(frame);

    // Set frame of title label
    frame = self.titleLabel.frame;
    frame.origin.x = (CGRectGetWidth(self.view.frame) - CGRectGetWidth(frame)) * 0.5f;
    self.titleLabel.frame = CGRectIntegral(frame);

    // Set frame of number pad
    frame = self.numberInputView.frame;
    frame.origin.x = (CGRectGetWidth(self.view.frame) - CGRectGetWidth(frame)) * 0.5f;
    frame.origin.y = (CGRectGetHeight(self.titleLabel.frame) + kTOPasscodeSettingsLabelInputSpacing);
    self.numberInputView.frame = CGRectIntegral(frame);

    // Apply light/dark mode
    [self applyThemeForStyle:self.style];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGSize viewSize = self.view.bounds.size;

    // Layout the keypad view
    CGRect frame = self.keypadView.frame;
    frame.size.height = viewSize.height * kTOPasscodeKeypadMaxSizeRatio;
    frame.size.height = MAX(frame.size.height, kTOPasscodeKeypadMinHeight);
    frame.size.height = MIN(frame.size.height, kTOPasscodeKeypadMaxHeight);
    frame.size.width = viewSize.width;
    frame.origin.y = viewSize.height - frame.size.height;
    self.keypadView.frame = CGRectIntegral(frame);

    BOOL horizontalLayout = frame.size.height < kTOPasscodeKeypadMinHeight + FLT_EPSILON;
    BOOL animated = ([self.view.layer animationForKey:@"bounds.size"] != nil);
    [self.keypadView setButtonLabelHorizontalLayout:horizontalLayout animated:animated];

    CGFloat topContentHeight = self.topLayoutGuide.length;

    // Layout the container view
    frame = self.containerView.frame;
    frame.origin.y = ((viewSize.height - (topContentHeight + self.keypadView.frame.size.height)) - frame.size.height) * 0.5f;
    frame.origin.y += topContentHeight;
    self.containerView.frame = CGRectIntegral(frame);
}

- (void)applyThemeForStyle:(TOPasscodeSettingsViewStyle)style
{
    BOOL isDark = (style == TOPasscodeSettingsViewStyleDark);

    UIColor *backgroundColor;
    if (isDark) {
        backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    }
    else {
        backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:241.0f/255.0f alpha:1.0f];
    }
    self.view.backgroundColor = backgroundColor;

}

@end
