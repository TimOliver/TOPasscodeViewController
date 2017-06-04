//
//  ViewController.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "ViewController.h"
#import "TOPasscodeViewController.h"
#import "SettingsViewController.h"

@interface ViewController () <TOPasscodeViewControllerDelegate>

@property (nonatomic, copy) NSString *passcode;
@property (nonatomic, assign) TOPasscodeViewStyle style;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView *dimmingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.passcode = @"1234";

    // Enable mipmaps so the rescaled image will look properly sampled
    self.imageView.layer.minificationFilter = kCAFilterTrilinear;
}

- (IBAction)showButtonTapped:(id)sender
{
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:self.style];
    passcodeViewController.delegate = self;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)settingsButtonTapped:(id)sender
{
    SettingsViewController *controller = [[SettingsViewController alloc] init];
    controller.passcode = self.passcode;
    controller.style = self.style;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];

    __weak typeof(self) weakSelf = self;
    __weak typeof(controller) weakController = controller;
    controller.doneButtonTappedHandler = ^{
        weakSelf.passcode = weakController.passcode;
        weakSelf.style = weakController.style;

        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:self.passcode];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.presentedViewController) {
        return [self.presentedViewController preferredStatusBarStyle];
    }

    return UIStatusBarStyleLightContent;
}
@end
