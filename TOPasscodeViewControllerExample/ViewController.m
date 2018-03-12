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
@property (nonatomic, assign) BOOL showButtonLettering;
@property (nonatomic, assign) TOPasscodeViewStyle style;
@property (nonatomic, assign) TOPasscodeType type;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView *dimmingView;

@property (nonatomic, strong) LAContext *authContext;
@property (nonatomic, assign) BOOL biometricsAvailable;
@property (nonatomic, assign) BOOL faceIDAvailable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.passcode = @"1234";
    self.showButtonLettering = YES;

    // Enable mipmaps so the rescaled image will look properly sampled
    self.imageView.layer.minificationFilter = kCAFilterTrilinear;

    // Show 'Touch ID' button if it's available
    self.authContext = [[LAContext alloc] init];
    self.biometricsAvailable = [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    
    if (@available(iOS 11.0, *)) {
        self.faceIDAvailable = (self.authContext.biometryType == LABiometryTypeFaceID);
    }
}

- (IBAction)showButtonTapped:(id)sender
{
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:self.style passcodeType:self.type];
    passcodeViewController.delegate = self;
    passcodeViewController.allowBiometricValidation = self.biometricsAvailable;
    passcodeViewController.biometryType = self.faceIDAvailable ? TOPasscodeBiometryTypeFaceID : TOPasscodeBiometryTypeTouchID;
    passcodeViewController.keypadButtonShowLettering = self.showButtonLettering;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)settingsButtonTapped:(id)sender
{
    SettingsViewController *controller = [[SettingsViewController alloc] init];
    controller.passcode = self.passcode;
    controller.passcodeType = self.type;
    controller.style = self.style;
    controller.wallpaperImage = self.imageView.image;
    controller.showButtonLettering = self.showButtonLettering;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];

    __weak typeof(self) weakSelf = self;
    __weak typeof(controller) weakController = controller;
    controller.doneButtonTappedHandler = ^{
        weakSelf.passcode = weakController.passcode;
        weakSelf.style = weakController.style;
        weakSelf.type = weakController.passcodeType;
        weakSelf.showButtonLettering = weakController.showButtonLettering;

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
            dispatch_async(dispatch_get_main_queue(), ^{
                // Create a new Touch ID context for next time
                [weakSelf.authContext invalidate];
                weakSelf.authContext = [[LAContext alloc] init];

                // Dismiss the passcode controller
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
            return;
        }

        // Actual UI changes need to be made on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [passcodeViewController setContentHidden:NO animated:YES];
        });

        // The user hit 'Enter Password'. This should probably do nothing
        // but make sure the passcode controller is visible.
        if (error.code == kLAErrorUserFallback) {
            NSLog(@"User tapped 'Enter Password'");
            return;
        }

        // The user hit the 'Cancel' button in the Touch ID dialog.
        // At this point, you could either simply return the user to the passcode controller,
        // or dismiss the protected content and go back to a safer point in your app (Like the login page).
        if (error.code == LAErrorUserCancel) {
            NSLog(@"User tapped cancel.");
            return;
        }

        // There shouldn't be any other potential errors, but just in case
        NSLog(@"%@", error.localizedDescription);
    };

    [passcodeViewController setContentHidden:YES animated:YES];

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
