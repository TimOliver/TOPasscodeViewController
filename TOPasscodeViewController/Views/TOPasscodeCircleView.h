//
//  TOPasscodeCircleView.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPasscodeCircleView : UIView

/* The circle patterns used for neutral and highlighted states. */
@property (nonatomic, strong) UIImage *circleImage;
@property (nonatomic, strong) UIImage *highlightedCircleImage;

/* Whether the highlighted view is visible. */
@property (nonatomic, assign) BOOL isHighlighted;

/* Animate the circle to be highlighted */
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end
