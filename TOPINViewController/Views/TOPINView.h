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
@property (nonatomic, strong, nullable) UIView   *titleView;
@property (nonatomic, strong, nullable) UIButton *leftButton;
@property (nonatomic, strong, nullable) UIButton *rightButton;

/* The default views always shown in this view */
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) TOPINCircleRowView *circleRowView;
@property (nonatomic, readonly) TOPINCircleKeypadView *keypadView;

/* Overrides for theming the various elements. */
@property (nonatomic, strong, nullable) UIColor *titleLabelColor;
@property (nonatomic, strong, nullable) UIColor *inputProgressViewTintColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonBackgroundColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonTextColor;
@property (nonatomic, strong, nullable) UIColor *keypadButtonHighlightedTextColor;

/* Horizontal inset from edge of keypad view to button center */
@property (nonatomic, readonly) CGFloat keypadButtonInset;

/* The default layout object controlling the
 sizing and placement of all this view's child elements. */
@property (nonatomic, strong, null_resettable) TOPINViewContentLayout *defaultContentLayout;

/* As needed, additional layout objects that will be checked and used in priority over the default content layout. */
@property (nonatomic, strong, nullable) NSArray<TOPINViewContentLayout *> *contentLayouts;

/* Create a new instance with one of the style types */
- (instancetype)initWithStyle:(TOPINViewStyle)style;

/* Resize the view and all subviews for the optimum size to fit a super view of the suplied width. */
- (void)sizeToFitWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
