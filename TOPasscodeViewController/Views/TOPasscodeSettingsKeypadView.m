//
//  TOPasscodeSettingsKeypadView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/18/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsKeypadView.h"

@implementation TOPasscodeSettingsKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor redColor];
}

@end
