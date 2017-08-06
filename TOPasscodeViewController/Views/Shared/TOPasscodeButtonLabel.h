//
//  TOKeypadNumberLabel.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/10/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPasscodeButtonLabel : UIView

// Draws the lettering label to the side
@property (nonatomic, assign) BOOL horizontalLayout;

// The strings of both labels
@property (nonatomic, copy) NSString *numberString;
@property (nonatomic, copy, nullable) NSString *letteringString;

// The color of both labels
@property (nonatomic, strong) UIColor *textColor;

// The label views
@property (nonatomic, readonly) UILabel *numberLabel;
@property (nonatomic, readonly) UILabel *letteringLabel;

// The fonts for each label (In case they are nil)
@property (nonatomic, strong) UIFont *numberLabelFont;
@property (nonatomic, strong) UIFont *letteringLabelFont;

// Has initial default values   
@property (nonatomic, assign) CGFloat letteringCharacterSpacing;
@property (nonatomic, assign) CGFloat letteringVerticalSpacing;
@property (nonatomic, assign) CGFloat letteringHorizontalSpacing;

// Whether the number label is centered vertically or not (NO by default)
@property (nonatomic, assign) BOOL verticallyCenterNumberLabel;

@end

NS_ASSUME_NONNULL_END
