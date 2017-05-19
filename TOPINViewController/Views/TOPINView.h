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

@interface TOPINView : UIView

/* The visual style of the view */
@property (nonatomic, assign) TOPINViewStyle style;

/* The scaling of the subviews for the given width */
@property (nonatomic, assign) TOPINViewContentSize contentSize;
@property (nonatomic, assign) BOOL automaticallyAdjustContentSize;

/* Customizable Accessory Views */
@property (nonatomic, strong) UIView   *titleView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

/* The default views always shown in this view */
@property (nonatomic, readonly) TOPINCircleRowView *circleRowView;
@property (nonatomic, readonly) TOPINCircleKeypadView *keypadView;
@property (nonatomic, readonly) UILabel *titleLabel;

- (instancetype)initWithFrame:(CGRect)frame style:(TOPINViewStyle)style;

@end

NS_ASSUME_NONNULL_END
