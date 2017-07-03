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

/** Called when the user was prompted to input their current passcode.
 Return YES if passcode was right and NO otherwise.

 Returning NO will cause a warning label to appear
 */
- (BOOL)passcodeSettingsViewControllerDidAttemptCurrentPasscode:(NSString *)passcode;

/** Called when the user has successfully set a new passcode. At this point, you should save over
    the old passcode with the new one. */
- (void)passcodeSettingsViewControllerDidChangeToNewPasscode:(NSString *)passcode ofType:(TOPasscodeType)type;

@end

// ----------------------------------------------------------------------

@interface TOPasscodeSettingsViewController : UIViewController

/** Set the visual style of the view controller (light or dark) */
@property (nonatomic, assign) TOPasscodeSettingsViewStyle style;

/** Before setting a new passcode, show a UI to validate the existing password. (Default is YES) */
@property (nonatomic, assign) BOOL requireCurrentPasscode;

/** If set, the view controller will disable input until this date time has been reached */

/* Create a new instance with the desird light or dark style */
- (instancetype)initWithStyle:(TOPasscodeSettingsViewStyle)style;

@end

NS_ASSUME_NONNULL_END
