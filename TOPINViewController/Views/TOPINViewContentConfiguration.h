//
//  TOPINViewContentConfiguration.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/19/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TOPINViewContentConfiguration : NSObject

/* Circle Button Shape and Layout */
@property (nonatomic, assign) CGFloat circleButtonDiameter;     // The size of each PIN button
@property (nonatomic, assign) CGSize  circleButtonSpacing;      // The vertical/horizontal spacing between buttons
@property (nonatomic, assign) CGFloat circleButtonStrokeWidth;  // The thickness of the border line

/* Circle Button Label */
@property (nonatomic, strong) UIFont *circleButtonTitleLabelFont;       // The font used for the '1' number labels
@property (nonatomic, strong) UIFont *circleButtonLetteringLabelFont;   // The font used for the 'ABC' labels
@property (nonatomic, assign) CGFloat circleButtonLabelSpacing;         // The vertical spacing between the number and lettering labels
@property (nonatomic, assign) CGFloat circleButtonLetteringSpacing;     // The spacing between the 'ABC' characters

/* Circle Row Configuration */
@property (nonatomic, assign) CGFloat circleRowDiameter; // The diameter of each circle representing a PIN number
@property (nonatomic, assign) CGFloat circleRowSpacing; // The spacing between each circle



@end
