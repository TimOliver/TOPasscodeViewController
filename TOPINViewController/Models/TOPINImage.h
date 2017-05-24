//
//  TOPINImage.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPINImage : UIImage

+ (UIImage *)PINCircleImageOfSize:(CGFloat)size inset:(CGFloat)inset padding:(CGFloat)padding;
+ (UIImage *)PINHollowCircleImageOfSize:(CGFloat)size strokeWidth:(CGFloat)strokeWidth padding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
