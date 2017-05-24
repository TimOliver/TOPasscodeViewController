//
//  TOPINCircleRowView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPINCircleRowView : UIVisualEffectView

/* The size of each circle in this view (Default is 16) */
@property (nonatomic, assign) CGFloat circleDiameter;

/* The spacing between each circle (Default is 25.0f) */
@property (nonatomic, assign) CGFloat circleSpacing;

/* The number of circles in this view (Default is 4) */
@property (nonatomic, assign) NSInteger numberOfCircles;

/* From the left, the number of circles that are highlighted. */
@property (nonatomic, assign) NSInteger numberOfHighlightedCircles;

/* Init with a number of circles */
- (instancetype)initWithNumberOfCircles:(NSInteger)numberOfCircles;

/* Set the number of highlighted circles with a crossfade animation */
- (void)setNumberOfHighlightedCircles:(NSInteger)numberOfHighlightedCircles animated:(BOOL)animated;

@end
