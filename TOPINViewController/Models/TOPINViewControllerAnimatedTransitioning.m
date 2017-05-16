//
//  TOPINViewControllerAnimatedTransitioning.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINViewControllerAnimatedTransitioning.h"
#import "TOPINView.h"

@interface TOPINViewControllerAnimatedTransitioning ()

@property (nonatomic, weak) TOPINView *pinView;

@end

@implementation TOPINViewControllerAnimatedTransitioning

- (instancetype)initWithPINView:(TOPINView *)pinView dismissing:(BOOL)dismissing
{
    if (self = [super init]) {
        _pinView = pinView;
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
    UIVisualEffectView *backgroundView = self.pinView.backgroundEffectView;
    UIVisualEffect *backgroundEffect = backgroundView.effect;

    if (!self.dismissing) {
        backgroundView.effect = nil;

        self.pinView.frame = containerView.bounds;
        [containerView addSubview:self.pinView];
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
