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
@class TOPINCircleKeypadView;

@interface TOPINView : UIView <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) TOPINViewStyle style;

@property (nonatomic, readonly) TOPINCircleRowView *circleRowView;
@property (nonatomic, readonly) TOPINCircleKeypadView *keypadView;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIButton *leftButton;
@property (nonatomic, readonly) UIButton *rightButton;

- (instancetype)initWithStyle:(TOPINViewStyle)style;

@end

NS_ASSUME_NONNULL_END
