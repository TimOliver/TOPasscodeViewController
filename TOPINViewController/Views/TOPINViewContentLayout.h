//
//  TOPINViewContentConfiguration.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/19/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TOPINViewContentLayout : NSObject

/* The width of the PIN view in which this layout object is sizing the content to fit. */
@property (nonatomic, assign) CGFloat pinViewWidth;

/* The title View at the very top */
@property (nonatomic, assign) CGFloat titleViewBottomSpacing;   // Space from the bottom of the title view to the title label

/* The Title Label Explaining the PIN View */
@property (nonatomic, assign) CGFloat titleLabelBottomSpacing;  // Space from the title label to the circles row
@property (nonatomic, strong) UIFont *titleLabelFont;           // The font of the title label

/* Circle Row Configuration */
@property (nonatomic, assign) CGFloat circleRowDiameter; // The diameter of each circle representing a PIN number
@property (nonatomic, assign) CGFloat circleRowSpacing;  // The spacing between each circle
@property (nonatomic, assign) CGFloat circleRowBottomSpacing; // Space between the view used to indicate input

/* Circle Button Shape and Layout */
@property (nonatomic, assign) CGFloat circleButtonDiameter;     // The size of each PIN button
@property (nonatomic, assign) CGSize  circleButtonSpacing;      // The vertical/horizontal spacing between buttons
@property (nonatomic, assign) CGFloat circleButtonStrokeWidth;  // The thickness of the border line

/* Circle Button Label */
@property (nonatomic, strong) UIFont *circleButtonTitleLabelFont;       // The font used for the '1' number labels
@property (nonatomic, strong) UIFont *circleButtonLetteringLabelFont;   // The font used for the 'ABC' labels
@property (nonatomic, assign) CGFloat circleButtonLabelSpacing;         // The vertical spacing between the number and lettering labels
@property (nonatomic, assign) CGFloat circleButtonLetteringSpacing;     // The spacing between the 'ABC' characters

/* Default layout configurations for the various sizes */
+ (TOPINViewContentLayout *)defaultScreenContentLayout;       /* Default layout values. Designed for iPhone 6 Plus and above. */
+ (TOPINViewContentLayout *)mediumScreenContentLayout;        /* For medium screen sizes, like iPhone 6, or 1/4 view on iPad Pro. */
+ (TOPINViewContentLayout *)smallScreenContentLayout;  /* For the smallest screens, like iPhone SE, and 1/4 on standard size iPads/ */

@end
