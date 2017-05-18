//
//  TOPINView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINView.h"

@interface TOPINView ()

@property (nonatomic, strong, readwrite) NSArray<TOPINCircleButton *> *pinButtons;
@property (nonatomic, strong, readwrite) TOPINCircleRowView *circleRowView;

@end

@implementation TOPINView

- (instancetype)initWithStyle:(TOPINViewStyle)style
{
    if (self = [super initWithFrame:(CGRect){0,0,320,640}]) {
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
