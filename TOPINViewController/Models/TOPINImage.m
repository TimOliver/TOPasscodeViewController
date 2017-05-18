//
//  TOPINImage.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINImage.h"

@implementation TOPINImage

+ (UIImage *)PINCircleImageOfSize:(CGFloat)size inset:(CGFloat)inset
{
    UIImage *image = nil;
    CGSize imageSize = (CGSize){size, size};

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    {
        CGRect rect = (CGRect){inset, inset, size - (inset * 2), size - (inset * 2)};
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        [[UIColor blackColor] setFill];
        [ovalPath fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)PINHollowCircleImageOfSize:(CGFloat)size strokeWidth:(CGFloat)strokeWidth
{
    UIImage *image = nil;
    CGSize imageSize = (CGSize){size, size};

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPathRef pathRef = [UIBezierPath bezierPathWithOvalInRect:(CGRect){CGPointZero, imageSize}].CGPath;

        CGContextAddPath(context, pathRef);
        CGContextClip(context);

        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, strokeWidth * 2.0f);

        CGContextAddPath(context, pathRef);
        CGContextStrokePath(context);

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
