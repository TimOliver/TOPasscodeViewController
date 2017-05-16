//
//  TOPINView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPINViewControllerConstants.h"

NS_ASSUME_NONNULL_BEGIN

@class TOPINCircleButton;
@class TOPINCircleRowView;

@interface TOPINView : UIView <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) TOPINViewStyle style;

@property (nonatomic, readonly) UIVisualEffectView *backgroundEffectView;
@property (nonatomic, readonly) NSArray<TOPINCircleButton *> *pinButtons;
@property (nonatomic, readonly) TOPINCircleRowView *circleRowView;


- (instancetype)initWithStyle:(TOPINViewStyle)style;

@end

NS_ASSUME_NONNULL_END
