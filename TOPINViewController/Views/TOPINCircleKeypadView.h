//
//  TOPINCircleKeypadView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TOPINCircleButton;

@interface TOPINCircleKeypadView : UIView

@property (nonatomic, readonly) NSArray<TOPINCircleButton *> *pinButtons;

@end
