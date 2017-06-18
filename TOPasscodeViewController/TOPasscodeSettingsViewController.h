//
//  TOPasscodeSettingsViewController.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/8/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPasscodeViewControllerConstants.h"

typedef NS_ENUM(NSInteger, TOPasscodeSettingsViewState) {
    TOPasscodeSettingsViewStateEnterNewPassword,
    TOPasscodeSettingsViewStateConfirmNewPassword,
    TOPasscodeSettingsViewStateEnterCurrentPassword
};

NS_ASSUME_NONNULL_BEGIN

@interface TOPasscodeSettingsViewController : UIViewController

/* Set the visual style of the view controller (light or dark) */
@property (nonatomic, assign) TOPasscodeSettingsViewStyle style;

/* Before setting a new passcode, show a UI to validate the existing password. (Default is YES) */
@property (nonatomic, assign) BOOL requireCurrentPasscode;

/* Create a new instance with the desird light or dark style */
- (instancetype)initWithStyle:(TOPasscodeSettingsViewStyle)style;

@end

NS_ASSUME_NONNULL_END
