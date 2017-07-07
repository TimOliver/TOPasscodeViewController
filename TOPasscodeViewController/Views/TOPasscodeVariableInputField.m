//
//  TOPasscodeVariableInputField.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 7/6/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeVariableInputField.h"

@implementation TOPasscodeVariableInputField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _outlineThickness = 1.5f;
        _outlineCornerRadius = 15.0f;
        _circleDiameter = 13.0f;
        _circleSpacing = 10.0f;
        _outlinePadding = (CGSize){10,10};
        _maximumVisibleLength = 10.0f;
    }

    return self;
}



@end
