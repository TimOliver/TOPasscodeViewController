//
//  SettingsViewController.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/4/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPasscodeViewControllerConstants.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic, copy) NSString *passcode;
@property (nonatomic, assign) TOPasscodeType passcodeType;
@property (nonatomic, assign) TOPasscodeViewStyle style;
@property (nonatomic, assign) BOOL showButtonLettering;
@property (nonatomic, strong) UIImage *wallpaperImage;

@property (nonatomic, copy) void (^doneButtonTappedHandler)(void);
@property (nonatomic, copy) void (^wallpaperChangedHandler)(UIImage *wallpaper);

@end
