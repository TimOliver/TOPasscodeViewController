//
//  TOPasscodeSettingsViewController.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/8/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsViewController.h"
#import "TOPasscodeNumberInputView.h"

@interface TOPasscodeSettingsViewController ()

@property (nonatomic, strong) TOPasscodeNumberInputView *numberInputView;

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

    self.title = NSLocalizedString(@"Enter Passcode", @"");

    self.numberInputView = [[TOPasscodeNumberInputView alloc] initWithRequiredLength:4];
    self.numberInputView.frame = CGRectOffset(self.numberInputView.frame, 0.0f, 100.0);
    [self.view addSubview:self.numberInputView];

    [self applyThemeForStyle:self.style];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.numberInputView becomeFirstResponder];
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
