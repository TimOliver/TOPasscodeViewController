//
//  TOPINCircleKeypadView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TOPINCircleButton;

@interface TOPINCircleKeypadView : UIView

/** The vibrancy effect to be applied to each button background */
@property (nonatomic, strong, nullable) UIVibrancyEffect *vibrancyEffect;

/** The size of each input button (Default is 81) */
@property (nonatomic, assign) CGFloat buttonDiameter;

/** The stroke width of the buttons (Default is 1.5) */
@property (nonatomic, assign) CGFloat buttonStrokeWidth;

/** The spacing between the buttons. Default is (CGSize){25,15} */
@property (nonatomic, assign) CGSize buttonSpacing;

/** Show the 'ABC' lettering under the numbers */
@property (nonatomic, assign) BOOL showLettering;

/** Accessory views placed on either side of the '0' button */
@property (nonatomic, strong, nullable) UIView *leftAccessoryView;
@property (nonatomic, strong, nullable) UIView *rightAccessoryView;

/** The controls making up each of the button views */
@property (nonatomic, readonly) NSArray<TOPINCircleButton *> *pinButtons;

@end

NS_ASSUME_NONNULL_END
