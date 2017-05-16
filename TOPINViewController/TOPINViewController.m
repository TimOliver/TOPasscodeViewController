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

@interface TOPINViewController () <UIViewControllerTransitioningDelegate>

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

- (void)loadView { self.view = [[TOPINView alloc] initWithStyle:self.style]; }

- (void)viewDidLoad
{
    [super viewDidLoad];

}

#pragma mark - Transitioning Delegate -

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINView:self.pinView dismissing:NO];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINView:self.pinView dismissing:YES];
}

#pragma mark - Accessors -
- (TOPINView *)pinView
{
    return (TOPINView *)self.view;
}

@end
