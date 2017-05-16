//
//  TOPINViewController.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPINViewControllerConstants.h"

@class TOPINView;

NS_ASSUME_NONNULL_BEGIN

@interface TOPINViewController : UIViewController

@property (nonatomic, readonly) TOPINView *pinView;
@property (nonatomic, assign) TOPINViewStyle style;

- (instancetype)initWithStyle:(TOPINViewStyle)style;

@end

NS_ASSUME_NONNULL_END
