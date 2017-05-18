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

+ (UIImage *)PINCircleImageOfSize:(CGFloat)size inset:(CGFloat)inset;
+ (UIImage *)PINHollowCircleImageOfSize:(CGFloat)size strokeWidth:(CGFloat)strokeWidth;

@end

NS_ASSUME_NONNULL_END
