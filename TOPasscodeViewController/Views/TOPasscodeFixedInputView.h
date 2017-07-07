//
//  TOPasscodeFixedInputField.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 7/6/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOPasscodeCircleView;

@interface TOPasscodeFixedInputView : UIView

/* The size of each circle in this view (Default is 16) */
@property (nonatomic, assign) CGFloat circleDiameter;

/* The spacing between each circle (Default is 25.0f) */
@property (nonatomic, assign) CGFloat circleSpacing;

/* The number of circles in this view (Default is 4) */
@property (nonatomic, assign) NSInteger length;

/* The number of highlighted circles */
@property (nonatomic, assign) NSInteger highlightedLength;

/* The circle views managed by this view */
@property (nonatomic, strong, readonly) NSArray<TOPasscodeCircleView *> *circleViews;

/* Init with a set number of circles */
- (instancetype)initWithLength:(NSInteger)length;

/* Set the number of highlighted circles */
- (void)setHighlightedLength:(NSInteger)highlightedLength animated:(BOOL)animated;

@end
