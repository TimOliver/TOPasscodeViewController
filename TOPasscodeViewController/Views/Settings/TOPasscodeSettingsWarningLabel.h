//
//  TOPasscodeSettingsWarningLabel.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/28/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPasscodeSettingsWarningLabel : UIImageView

/** The number of incorrect password attempts to display */
@property (nonatomic, assign) NSInteger numberOfWarnings;

/** The font of the text */
@property (nonatomic, strong) UIFont *textFont;

/** The background color of the view */
@property (nonatomic, strong) UIColor *backgroundColor;

/** Set the padding around the label */
@property (nonatomic, assign) CGSize textPadding;

@end
