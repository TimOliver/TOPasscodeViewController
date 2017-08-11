//
//  TOPasscodeViewControllerAnimatedTransitioning.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TOPasscodeViewController;

NS_ASSUME_NONNULL_BEGIN

/**
 An class conforming to `UIViewControllerAnimatedTransitioning` that handles the custom animation
 that plays when the passcode view controller is presented on the user's screen.
 */
@interface TOPasscodeViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

/** The parent passcode view controller that this object will be controlling */
@property (nonatomic, weak, readonly) TOPasscodeViewController *passcodeViewController;

/** Whether the controller is being presented or dismissed. The animation is played in reverse when dismissing. */
@property (nonatomic, assign) BOOL dismissing;

/** If the correct passcode was successfully entered, this property can be set to YES. When the view controller
 is dismissing, the keypad view will also play a zooming out animation to give added context to the dismissal. */
@property (nonatomic, assign) BOOL success;

/**
 Creates a new instanc of `TOPasscodeViewControllerAnimatedTransitioning` that will control the provided passcode
 view controller.

 @param passcodeViewController The passcode view controller in which this object will coordinate the animation upon.
 @param dismissing Whether the animation is played to present the view controller, or dismiss it.
 @param success Whether the object needs to play an additional zooming animation denoting the passcode was successfully entered.
 */
- (instancetype)initWithPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
                                    dismissing:(BOOL)dismissing
                                       success:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
