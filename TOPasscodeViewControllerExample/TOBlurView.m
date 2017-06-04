//
//  TOBlurView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/3/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOBlurView.h"

@implementation TOBlurView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    }

    return self;
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect
{
    if (self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]]) {

    }

    return self;
}

- (void)addSubview:(UIView *)view
{
    if ([NSStringFromClass([view class]) rangeOfString:@"Backdrop"].location == NSNotFound) {
        return;
    }

    [super addSubview:view];
}


@end
