//
//  TOPINViewControllerAnimatedTransitioning.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINViewControllerAnimatedTransitioning.h"
#import "TOPINViewController.h"

@interface TOPINViewControllerAnimatedTransitioning ()
@property (nonatomic, weak) TOPINViewController *pinViewController;
@end

@implementation TOPINViewControllerAnimatedTransitioning

- (instancetype)initWithPINViewController:(TOPINViewController *)pinViewController dismissing:(BOOL)dismissing
{
    if (self = [super init]) {
        _pinViewController = pinViewController;
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
    UIVisualEffectView *backgroundView = self.pinViewController.backgroundEffectView;
    UIVisualEffect *backgroundEffect = backgroundView.effect;

    if (!self.dismissing) {
        backgroundView.effect = nil;

        self.pinViewController.view.frame = containerView.bounds;
        [containerView addSubview:self.pinViewController.view];
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
                        options:0
                     animations:animationBlock
                     completion:completedBlock];
}

@end
