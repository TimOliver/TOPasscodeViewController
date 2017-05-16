//
//  TOPINView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINView.h"

@interface TOPINView ()

@property (nonatomic, strong, readwrite) UIVisualEffectView *backgroundEffectView;
@property (nonatomic, strong, readwrite) NSArray<TOPINCircleButton *> *pinButtons;
@property (nonatomic, strong, readwrite) TOPINCircleRowView *circleRowView;

@end

@implementation TOPINView

- (instancetype)initWithStyle:(TOPINViewStyle)style
{
    if (self = [super initWithFrame:(CGRect){0,0,320,640}]) {
        _style = style;
        [self setUpViewsForStyle:_style];
        [self applyThemeForStyle:_style];
    }

    return self;
}

- (void)setUpViewsForStyle:(TOPINViewStyle)style
{
    [self setUpBackgroundEffectViewForStyle:style];
}

- (void)setUpBackgroundEffectViewForStyle:(TOPINViewStyle)style
{
    BOOL translucent = TOPINViewStyleIsTranslucent(style);

    // Return if it already exists when it should
    if (translucent && self.backgroundEffectView) { return; }

    // Return if it doesn't exist when it shouldn't
    if (!translucent && !self.backgroundEffectView) { return; }

    if (!translucent) {
        [self.backgroundEffectView removeFromSuperview];
        self.backgroundEffectView = nil;
        return;
    }

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[self blurEffectStyleForStyle:style]];
    self.backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.backgroundEffectView.frame = self.bounds;
    self.backgroundEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.backgroundEffectView atIndex:0];
}

- (void)applyThemeForStyle:(TOPINViewStyle)style
{
    BOOL translucent = TOPINViewStyleIsTranslucent(style);

    if (translucent) {
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Internal Style Management -
- (UIBlurEffectStyle)blurEffectStyleForStyle:(TOPINViewStyle)style
{
    switch (self.style) {
        case TOPINViewStyleTranslucentDark: return UIBlurEffectStyleDark;
        case TOPINViewStyleTranslucentLight: return UIBlurEffectStyleLight;
        case TOPINViewStyleTranslucentExtraLight: return UIBlurEffectStyleExtraLight;
        default: return 0;
    }

    return 0;
}

@end
