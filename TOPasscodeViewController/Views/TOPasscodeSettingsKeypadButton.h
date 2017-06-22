//
//  TOPasscodeSettingsKeypadButton.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/21/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOPasscodeButtonLabel;

@interface TOPasscodeSettingsKeypadButton : UIButton

/** Background Images */
@property (nonatomic, strong) UIImage *buttonBackgroundImage;
@property (nonatomic, strong) UIImage *buttonTappedBackgroundImage;

/* Inset of the label view from the bottom to account for the bevel */
@property (nonatomic, assign) CGFloat bottomInset;

/* The button label containing the number and lettering */
@property (nonatomic, readonly) TOPasscodeButtonLabel *buttonLabel;

+ (TOPasscodeSettingsKeypadButton *)button;

@end
