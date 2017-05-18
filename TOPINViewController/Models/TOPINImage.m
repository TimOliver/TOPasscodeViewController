//
//  TOPINImage.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINImage.h"

@implementation TOPINImage

+ (UIImage *)PINCircleImageOfDiameter:(CGFloat)diameter
{
    UIImage *image = nil;
    CGSize size = (CGSize){diameter, diameter};

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    {
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){CGPointZero, size}];
        [[UIColor blackColor] setFill];
        [ovalPath fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)PINHollowCircleImageOfDiameter:(CGFloat)diameter strokeWidth:(CGFloat)strokeWidth
{
    UIImage *image = nil;
    CGSize size = (CGSize){diameter, diameter};

    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGPathRef pathRef = [UIBezierPath bezierPathWithOvalInRect:(CGRect){CGPointZero, size}].CGPath;

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
