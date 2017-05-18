//
//  TOPINViewController.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINViewController.h"
#import "TOPINView.h"
#import "TOPINViewControllerAnimatedTransitioning.h"

#import "TOPINImage.h"
#import "TOPINCircleButton.h"

@interface TOPINViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong, readwrite) UIVisualEffectView *backgroundEffectView;
@property (nonatomic, strong, readwrite) TOPINView *pinView;

@end

@implementation TOPINViewController

- (instancetype)initWithStyle:(TOPINViewStyle)style
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _style = style;
        [self setUp];
    }

    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    self.transitioningDelegate = self;

    if (TOPINViewStyleIsTranslucent(self.style)) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpBackgroundEffectViewForStyle:self.style];

    UIImage *circleImage = [TOPINImage PINHollowCircleImageOfDiameter:85.0f strokeWidth:1.5f];
    UIImage *circleHighlightImage = [TOPINImage PINCircleImageOfDiameter:85.0f];
    UIVibrancyEffect *effect = [UIVibrancyEffect effectForBlurEffect:self.backgroundEffectView.effect];

    TOPINCircleButton *button = [[TOPINCircleButton alloc] initWithNumberString:@"1" letteringString:@"ABC"];
    button.backgroundImage = circleImage;
    button.hightlightedBackgroundImage = circleHighlightImage;
    button.vibrancyEffect = effect;
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)setUpPINViewForStyle:(TOPINViewStyle)style
{
    if (self.pinView) { return; }

    self.pinView = [[TOPINView alloc] initWithFrame:(CGRect){0,0,320,400}];
    self.pinView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.pinView sizeToFit];
    self.pinView.center = self.view.center;
    [self.view addSubview:self.pinView];
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
    self.backgroundEffectView.frame = self.view.bounds;
    self.backgroundEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.backgroundEffectView atIndex:0];
}

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

#pragma mark - Transitioning Delegate -
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINViewController:self dismissing:NO];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINViewController:self dismissing:YES];
}

#pragma mark - Accessors -
- (TOPINView *)pinView
{
    return (TOPINView *)self.view;
}

@end
