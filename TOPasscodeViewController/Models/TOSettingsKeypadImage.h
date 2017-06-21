//
//  TOSettingsKeypadImage.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/20/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSettingsKeypadImage : UIImage

+ (UIImage *)buttonImageWithCornerRadius:(CGFloat)radius foregroundColor:(UIColor *)foregroundColor edgeColor:(UIColor *)edgeColor;
+ (UIImage *)deleteIcon;

@end

NS_ASSUME_NONNULL_END
