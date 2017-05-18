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

+ (UIImage *)PINCircleImageOfDiameter:(CGFloat)diameter;
+ (UIImage *)PINHollowCircleImageOfDiameter:(CGFloat)diameter strokeWidth:(CGFloat)strokeWidth;

@end

NS_ASSUME_NONNULL_END
