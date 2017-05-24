//
//  TOPINImage.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINImage.h"

@implementation TOPINImage

+ (UIImage *)PINCircleImageOfSize:(CGFloat)size inset:(CGFloat)inset padding:(CGFloat)padding
{
    UIImage *image = nil;
    CGSize imageSize = (CGSize){size + (padding * 2), size + (padding * 2)};

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0f);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetShouldAntialias(context, NO);

        CGRect rect = (CGRect){padding + inset, padding + inset, size - (inset * 2), size - (inset * 2)};
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:rect];
        [[UIColor blackColor] setFill];
        [ovalPath fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

+ (UIImage *)PINHollowCircleImageOfSize:(CGFloat)size strokeWidth:(CGFloat)strokeWidth padding:(CGFloat)padding
{
    UIImage *image = nil;
    CGSize canvasSize = (CGSize){size + (padding * 2), size + (padding * 2)};
    CGSize circleSize = (CGSize){size, size};

    UIGraphicsBeginImageContextWithOptions(canvasSize, NO, 0.0f);
    {
        CGRect circleRect = (CGRect){{padding, padding}, circleSize};
        circleRect = CGRectInset(circleRect, (strokeWidth * 0.5f), (strokeWidth * 0.5f));

        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:circleRect];
        [[UIColor blackColor] setStroke];
        path.lineWidth = strokeWidth;
        [path stroke];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
