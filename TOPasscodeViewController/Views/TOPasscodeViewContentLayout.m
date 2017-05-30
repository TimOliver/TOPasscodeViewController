//
//  TOPasscodeViewContentConfiguration.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/19/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeViewContentLayout.h"

@implementation TOPasscodeViewContentLayout

+ (TOPasscodeViewContentLayout *)defaultScreenContentLayout
{
    TOPasscodeViewContentLayout *contentLayout = [[TOPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 414.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 34.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 34.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 22.0f];

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 15.5f;
    contentLayout.circleRowSpacing = 30.0f;
    contentLayout.circleRowBottomSpacing = 61.0f;

    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 81.0f;
    contentLayout.circleButtonSpacing = (CGSize){25.0f, 20.0f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:37.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont monospacedDigitSystemFontOfSize:9.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 6.0f;
    contentLayout.circleButtonLetteringSpacing = 3.0f;

    return contentLayout;
}

+ (TOPasscodeViewContentLayout *)mediumScreenContentLayout
{
    TOPasscodeViewContentLayout *contentLayout = [[TOPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 375.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 27.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 27.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 20.0f];

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 12.5f;
    contentLayout.circleRowSpacing = 26.0f;
    contentLayout.circleRowBottomSpacing = 53.0f;

    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 75.0f;
    contentLayout.circleButtonSpacing = (CGSize){28.0f, 15.0f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:36.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont monospacedDigitSystemFontOfSize:8.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 5.0f;
    contentLayout.circleButtonLetteringSpacing = 2.5f;

    return contentLayout;
}

+ (TOPasscodeViewContentLayout *)smallScreenContentLayout
{
    TOPasscodeViewContentLayout *contentLayout = [[TOPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 320.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 23.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 23.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 17.0f];

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 11.5f;
    contentLayout.circleRowSpacing = 22.0f;
    contentLayout.circleRowBottomSpacing = 44.0f;

    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 64.0f;
    contentLayout.circleButtonSpacing = (CGSize){22.0f, 10.5f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:32.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont monospacedDigitSystemFontOfSize:7.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 4.5f;
    contentLayout.circleButtonLetteringSpacing = 2.0f;

    return contentLayout;
}

@end
