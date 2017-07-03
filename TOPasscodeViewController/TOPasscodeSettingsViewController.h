//
//  TOPasscodeSettingsViewController.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/8/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPasscodeViewControllerConstants.h"

@class TOPasscodeSettingsViewController;

typedef NS_ENUM(NSInteger, TOPasscodeSettingsViewState) {
    TOPasscodeSettingsViewStateEnterNewPassword,
    TOPasscodeSettingsViewStateConfirmNewPassword,
    TOPasscodeSettingsViewStateEnterCurrentPassword
};

NS_ASSUME_NONNULL_BEGIN

@protocol TOPasscodeSettingsViewControllerDelegate <NSObject>

@optional

/** Called when the user was prompted to input their current passcode.
 Return YES if passcode was right and NO otherwise.

 Returning NO will cause a warning label to appear
 */
- (BOOL)passcodeSettingsViewController:(TOPasscodeSettingsViewController *)passcodeSettingsViewController
             didAttemptCurrentPasscode:(NSString *)passcode;

/** Called when the user has successfully set a new passcode. At this point, you should save over
    the old passcode with the new one. */
- (void)passcodeSettingsViewController:(TOPasscodeSettingsViewController *)passcodeSettingsViewController
                didChangeToNewPasscode:(NSString *)passcode ofType:(TOPasscodeType)type;

@end

// ----------------------------------------------------------------------

@interface TOPasscodeSettingsViewController : UIViewController

/** Delegate event for controlling and responding to the behavior of this controller */
@property (nonatomic, weak, nullable) id<TOPasscodeSettingsViewControllerDelegate> delegate;

/** The current state of the controller (confirming old passcode or creating a new one) */
@property (nonatomic, assign) TOPasscodeSettingsViewState state;

/** Set the visual style of the view controller (light or dark) */
@property (nonatomic, assign) TOPasscodeSettingsViewStyle style;

/** The number of incorrect passcode attempts the user has made. Use this property to decide when to disable input. */
@property (nonatomic, assign) NSInteger failedPasscodeAttemptCount;

/** Before setting a new passcode, show a UI to validate the existing password. (Default is NO) */
@property (nonatomic, assign) BOOL requireCurrentPasscode;

/** If set, the view controller will disable input until this date time has been reached */
@property (nonatomic, strong, nullable) NSDate *disabledInputDate;

/* Create a new instance with the desird light or dark style */
- (instancetype)initWithStyle:(TOPasscodeSettingsViewStyle)style;

@end

NS_ASSUME_NONNULL_END
