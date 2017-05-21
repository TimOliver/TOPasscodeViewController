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
@class TOPINViewContentLayout;

@interface TOPINView : UIView

/* The visual style of the view */
@property (nonatomic, assign) TOPINViewStyle style;

/* The text in the title view (Default is 'Enter Passcode') */
@property (nonatomic, copy) NSString *titleText;

/* Customizable Accessory Views */
@property (nonatomic, strong) UIView   *titleView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

/* The default views always shown in this view */
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) TOPINCircleRowView *circleRowView;
@property (nonatomic, readonly) TOPINCircleKeypadView *keypadView;

/* The default layout object controlling the
 sizing and placement of all this view's child elements. */
@property (nonatomic, strong, null_resettable) TOPINViewContentLayout *defaultContentLayout;

/* As needed, additional layout objects that will be checked and used in priority over
 the default content layout. */
@property (nonatomic, strong, nullable) NSArray<TOPINViewContentLayout *> *contentLayouts;


- (instancetype)initWithFrame:(CGRect)frame style:(TOPINViewStyle)style;

@end

NS_ASSUME_NONNULL_END
