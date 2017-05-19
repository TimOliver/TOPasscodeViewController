//
//  TOPINView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINView.h"

@interface TOPINView ()

@property (nonatomic, strong, readwrite) TOPINCircleRowView *circleRowView;
@property (nonatomic, strong, readwrite) TOPINCircleKeypadView *keypadView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation TOPINView

- (instancetype)initWithFrame:(CGRect)frame style:(TOPINViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        _style = style;
        [self setUpViewForStyle:_style];
        [self applyThemeForStyle:_style];
    }

    return self;
}

- (void)setUpViewForStyle:(TOPINViewStyle)style
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)applyThemeForStyle:(TOPINViewStyle)style
{
    
}

#pragma mark - Internal Style Management -


@end
