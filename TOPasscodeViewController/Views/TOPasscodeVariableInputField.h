//
//  TOPasscodeVariableInputField.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 7/6/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPasscodeVariableInputField : UIImageView

/* The thickness of the stroke around the view (Default is 1.5) */
@property (nonatomic, assign) CGFloat outlineThickness;

/* The corner radius of the stroke (Default is 15) */
@property (nonatomic, assign) CGFloat outlineCornerRadius;

/* The size of each circle bullet point representing a passcoded character (Default is 10) */
@property (nonatomic, assign) CGFloat circleDiameter;

/* The spacing between each circle (Default is 15) */
@property (nonatomic, assign) CGFloat circleSpacing;

/* The padding between the circles and the outer outline (Default is {10,10}) */
@property (nonatomic, assign) CGSize outlinePadding;

/* The maximum number of circles to show (This will indicate the view's width) (Default is 10) */
@property (nonatomic, assign) NSInteger maximumVisibleLength;

/* Set the number of characters entered into this view (May be larger than `maximumVisibleLength`) */
@property (nonatomic, assign) NSInteger length;

/* Set the number of characters represented by this field, animated if desired */
- (void)setLength:(NSInteger)length animated:(BOOL)animated;

@end
