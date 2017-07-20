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
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController () <TOPasscodeViewControllerDelegate>

@property (nonatomic, copy) NSString *passcode;
@property (nonatomic, assign) TOPasscodeViewStyle style;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView *dimmingView;

@property (nonatomic, strong) LAContext *authContext;
@property (nonatomic, assign) BOOL biometricsAvailable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.passcode = @"1234";

    // Enable mipmaps so the rescaled image will look properly sampled
    self.imageView.layer.minificationFilter = kCAFilterTrilinear;

    // Show 'Touch ID' button if it's available
    self.authContext = [[LAContext alloc] init];
    self.biometricsAvailable = [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
}

- (IBAction)showButtonTapped:(id)sender
{
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:self.style];
    passcodeViewController.delegate = self;
    passcodeViewController.allowBiometricValidation = self.biometricsAvailable;
    passcodeViewController.passcodeType = (self.passcode.length == 6) ? TOPasscodeTypeSixDigits : TOPasscodeTypeFourDigits;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)settingsButtonTapped:(id)sender
{
    SettingsViewController *controller = [[SettingsViewController alloc] init];
    controller.passcode = self.passcode;
    controller.style = self.style;
    controller.wallpaperImage = self.imageView.image;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];

    __weak typeof(self) weakSelf = self;
    __weak typeof(controller) weakController = controller;
    controller.doneButtonTappedHandler = ^{
        weakSelf.passcode = weakController.passcode;
        weakSelf.style = weakController.style;

        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };

    controller.wallpaperChangedHandler = ^(UIImage *image) {
        weakSelf.imageView.image = image;
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

- (void)didPerformBiometricValidationRequestInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    __weak typeof(self) weakSelf = self;
    NSString *reason = @"Touch ID to continue using this app";
    id reply = ^(BOOL success, NSError *error) {

        // Touch ID validation was successful
        // (Use this to dismiss the passcode controller and display the protected content)
        if (success) {
            // Create a new Touch ID context for next time
            [weakSelf.authContext invalidate];
            weakSelf.authContext = [[LAContext alloc] init];

            // Dismiss the passcode controller
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            return;
        }

        // The user hit the 'Cancel' button in the Touch ID dialog
        // (Use this to dismiss the controller if desired, but do not show the protected content)
        if (error.code == LAErrorUserCancel) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            return;
        }

        // The other main error would be if the user hit 'Enter Passcode', in which case they can enter
        // their passcode manually into the passcode controller
        NSLog(@"%@", error.localizedDescription);
    };

    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:reply];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.presentedViewController) {
        return [self.presentedViewController preferredStatusBarStyle];
    }

    return UIStatusBarStyleLightContent;
}
@end
