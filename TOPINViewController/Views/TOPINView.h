//
//  TOPINView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPINViewControllerConstants.h"

@class TOPINCircleButton;

@interface TOPINView : UIView

@property (nonatomic, strong) UIVisualEffectView *backgroundView;
@property (nonatomic, strong) NSArray<TOPINCircleButton *> *pinButtons;


- (instancetype)initWithStyle:(TOPINViewStyle)style;

@end
