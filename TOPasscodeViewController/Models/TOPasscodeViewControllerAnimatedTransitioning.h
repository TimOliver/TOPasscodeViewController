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

@interface TOPasscodeViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak, readonly) TOPasscodeViewController *passcodeViewController;
@property (nonatomic, assign) BOOL dismissing;
@property (nonatomic, assign) BOOL passcodeSuccess; //Play a different animation if the password succeeeded

- (instancetype)initWithPasscodeViewController:(TOPasscodeViewController *)passcodeViewController dismissing:(BOOL)dismissing success:(BOOL)success;

@end

NS_ASSUME_NONNULL_END
