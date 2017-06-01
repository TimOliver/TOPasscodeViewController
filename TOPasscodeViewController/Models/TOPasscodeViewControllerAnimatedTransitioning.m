//
//  TOPasscodeViewControllerAnimatedTransitioning.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeViewControllerAnimatedTransitioning.h"
#import "TOPasscodeViewController.h"

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
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIVisualEffectView *backgroundView = self.passcodeViewController.backgroundEffectView;
    UIVisualEffect *backgroundEffect = backgroundView.effect;

    if (!self.dismissing) {
        backgroundView.effect = nil;

        self.passcodeViewController.view.frame = containerView.bounds;
        [containerView addSubview:self.passcodeViewController.view];
    }

    id animationBlock = ^{
        backgroundView.effect = self.dismissing ? nil : backgroundEffect;
    };

    id completedBlock = ^(BOOL completed) {
        backgroundView.effect = backgroundEffect;
        [transitionContext completeTransition:completed];
    };

    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.3f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:animationBlock
                     completion:completedBlock];
}

@end
