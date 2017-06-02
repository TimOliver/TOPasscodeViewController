//
//  TOPasscodeViewControllerAnimatedTransitioning.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeViewControllerAnimatedTransitioning.h"
#import "TOPasscodeViewController.h"
#import "TOPasscodeView.h"

@interface TOPasscodeViewControllerAnimatedTransitioning ()
@property (nonatomic, weak) TOPasscodeViewController *passcodeViewController;
@end

@implementation TOPasscodeViewControllerAnimatedTransitioning

- (instancetype)initWithPasscodeViewController:(TOPasscodeViewController *)passcodeViewController dismissing:(BOOL)dismissing
{
    if (self = [super init]) {
        _passcodeViewController = passcodeViewController;
        _dismissing = dismissing;
    }

    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    BOOL isPhone = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    UIView *containerView = transitionContext.containerView;
    UIVisualEffectView *backgroundView = self.passcodeViewController.backgroundEffectView;
    UIVisualEffect *backgroundEffect = backgroundView.effect;
    TOPasscodeView *passcodeView = self.passcodeViewController.passcodeView;
    // Set the initial properties when presenting
    if (!self.dismissing) {
        backgroundView.effect = nil;

        self.passcodeViewController.view.frame = containerView.bounds;
        [containerView addSubview:self.passcodeViewController.view];
    }

    CGFloat alpha = self.dismissing ? 1.0f : 0.0f;
    passcodeView.contentAlpha = alpha;

    // Animate the accessory views
    if (isPhone) {
        self.passcodeViewController.leftAccessoryButton.alpha = alpha;
        self.passcodeViewController.rightAccessoryButton.alpha = alpha;
        self.passcodeViewController.cancelButton.alpha = alpha;
        self.passcodeViewController.biometricButton.alpha  = alpha;
    }

    id animationBlock = ^{
        backgroundView.effect = self.dismissing ? nil : backgroundEffect;

        CGFloat toAlpha = self.dismissing ? 0.0f : 1.0f;
        passcodeView.contentAlpha = toAlpha;
        if (isPhone) {
            self.passcodeViewController.leftAccessoryButton.alpha = toAlpha;
            self.passcodeViewController.rightAccessoryButton.alpha = toAlpha;
            self.passcodeViewController.cancelButton.alpha = toAlpha;
            self.passcodeViewController.biometricButton.alpha  = toAlpha;
        }
    };

    id completedBlock = ^(BOOL completed) {
        backgroundView.effect = backgroundEffect;
        [transitionContext completeTransition:completed];
    };

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
//         usingSpringWithDamping:1.0f
//          initialSpringVelocity:0.3f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animationBlock
                     completion:completedBlock];
}

@end
