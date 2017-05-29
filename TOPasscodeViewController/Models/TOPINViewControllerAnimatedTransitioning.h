//
//  TOPINViewControllerAnimatedTransitioning.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TOPINViewController;

NS_ASSUME_NONNULL_BEGIN

@interface TOPINViewControllerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak, readonly) TOPINViewController *pinViewController;
@property (nonatomic, assign) BOOL dismissing;

- (instancetype)initWithPINViewController:(TOPINViewController *)pinViewController dismissing:(BOOL)dismissing;

@end

NS_ASSUME_NONNULL_END
