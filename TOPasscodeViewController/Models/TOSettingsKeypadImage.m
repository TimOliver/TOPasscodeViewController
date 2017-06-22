//
//  TOSettingsKeypadImage.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/20/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOSettingsKeypadImage.h"

@implementation TOSettingsKeypadImage

+ (UIImage *)buttonImageWithCornerRadius:(CGFloat)radius
                         foregroundColor:(UIColor *)foregroundColor
                               edgeColor:(UIColor *)edgeColor
                           edgeThickness:(CGFloat)thickness
{
    CGFloat width = (radius * 2.0f) + 1.0f;
    CGFloat height = width + thickness;

    CGRect frame = (CGRect){CGPointZero, {width, height}};

    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        NSShadow* shadow = [[NSShadow alloc] init];
        shadow.shadowColor  = edgeColor;
        shadow.shadowOffset = CGSizeMake(0, thickness);
        shadow.shadowBlurRadius = 0;

        CGRect buttonFrame = frame;
        buttonFrame.size.height -= thickness;

        CGContextSaveGState(context);
        {
            CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
            UIBezierPath *buttonPath = [UIBezierPath bezierPathWithRoundedRect:buttonFrame cornerRadius:radius];
            [foregroundColor setFill];
            [buttonPath fill];
        }
        CGContextRestoreGState(context);

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    UIEdgeInsets insets = UIEdgeInsetsMake(radius, radius, radius + thickness, radius);
    image = [image resizableImageWithCapInsets:insets];

    return image;
}

+ (UIImage *)deleteIcon
{
    UIImage *image = nil;

    CGRect frame = CGRectMake(0, 0, 24.0f, 18.0f);
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
    {
        //// DeleteIcon
        {
            //// Border Drawing
            UIBezierPath* borderPath = [UIBezierPath bezierPath];
            [borderPath moveToPoint: CGPointMake(20.59, 1.2)];
            [borderPath addLineToPoint: CGPointMake(20.73, 1.22)];
            [borderPath addCurveToPoint: CGPointMake(22.73, 2.89) controlPoint1: CGPointMake(21.66, 1.51) controlPoint2: CGPointMake(22.39, 2.12)];
            [borderPath addCurveToPoint: CGPointMake(23, 5.59) controlPoint1: CGPointMake(23, 3.61) controlPoint2: CGPointMake(23, 4.27)];
            [borderPath addLineToPoint: CGPointMake(23, 12.41)];
            [borderPath addCurveToPoint: CGPointMake(22.76, 14.99) controlPoint1: CGPointMake(23, 13.73) controlPoint2: CGPointMake(23, 14.39)];
            [borderPath addLineToPoint: CGPointMake(22.73, 15.11)];
            [borderPath addCurveToPoint: CGPointMake(20.73, 16.78) controlPoint1: CGPointMake(22.39, 15.88) controlPoint2: CGPointMake(21.66, 16.49)];
            [borderPath addCurveToPoint: CGPointMake(17.3, 17) controlPoint1: CGPointMake(19.87, 17) controlPoint2: CGPointMake(18.89, 17)];
            [borderPath addLineToPoint: CGPointMake(9.22, 17)];
            [borderPath addCurveToPoint: CGPointMake(7.89, 16.74) controlPoint1: CGPointMake(9.22, 17) controlPoint2: CGPointMake(8.31, 16.94)];
            [borderPath addCurveToPoint: CGPointMake(5.83, 15) controlPoint1: CGPointMake(7.23, 16.4) controlPoint2: CGPointMake(6.76, 15.93)];
            [borderPath addLineToPoint: CGPointMake(3.01, 12.17)];
            [borderPath addCurveToPoint: CGPointMake(1.32, 10.21) controlPoint1: CGPointMake(2.07, 11.24) controlPoint2: CGPointMake(1.61, 10.77)];
            [borderPath addLineToPoint: CGPointMake(1.26, 10.11)];
            [borderPath addCurveToPoint: CGPointMake(1.26, 7.75) controlPoint1: CGPointMake(0.91, 9.36) controlPoint2: CGPointMake(0.91, 8.5)];
            [borderPath addCurveToPoint: CGPointMake(3.01, 5.69) controlPoint1: CGPointMake(1.61, 7.09) controlPoint2: CGPointMake(2.07, 6.62)];
            [borderPath addLineToPoint: CGPointMake(5.67, 3.03)];
            [borderPath addCurveToPoint: CGPointMake(7.63, 1.34) controlPoint1: CGPointMake(6.6, 2.09) controlPoint2: CGPointMake(7.07, 1.63)];
            [borderPath addLineToPoint: CGPointMake(7.73, 1.28)];
            [borderPath addCurveToPoint: CGPointMake(9.1, 1.03) controlPoint1: CGPointMake(8.16, 1.08) controlPoint2: CGPointMake(8.63, 1)];
            [borderPath addLineToPoint: CGPointMake(17.3, 1)];
            [borderPath addCurveToPoint: CGPointMake(20.59, 1.2) controlPoint1: CGPointMake(18.89, 1) controlPoint2: CGPointMake(19.87, 1)];
            [borderPath closePath];
            [UIColor.blackColor setStroke];
            borderPath.lineWidth = 2;
            [borderPath stroke];


            //// Cross Drawing
            UIBezierPath* crossPath = [UIBezierPath bezierPath];
            [crossPath moveToPoint: CGPointMake(11.7, 5.1)];
            [crossPath addCurveToPoint: CGPointMake(11.69, 5.09) controlPoint1: CGPointMake(11.74, 5.14) controlPoint2: CGPointMake(11.69, 5.09)];
            [crossPath addLineToPoint: CGPointMake(11.7, 5.1)];
            [crossPath closePath];
            [crossPath moveToPoint: CGPointMake(12.48, 8.8)];
            [crossPath addCurveToPoint: CGPointMake(12.49, 8.79) controlPoint1: CGPointMake(12.51, 8.82) controlPoint2: CGPointMake(12.5, 8.8)];
            [crossPath addLineToPoint: CGPointMake(12.48, 8.8)];
            [crossPath closePath];
            [crossPath moveToPoint: CGPointMake(11.13, 4.63)];
            [crossPath addCurveToPoint: CGPointMake(11.69, 5.09) controlPoint1: CGPointMake(11.32, 4.73) controlPoint2: CGPointMake(11.46, 4.86)];
            [crossPath addCurveToPoint: CGPointMake(11.83, 5.23) controlPoint1: CGPointMake(11.73, 5.13) controlPoint2: CGPointMake(11.78, 5.18)];
            [crossPath addCurveToPoint: CGPointMake(11.87, 5.26) controlPoint1: CGPointMake(11.86, 5.26) controlPoint2: CGPointMake(11.87, 5.26)];
            [crossPath addCurveToPoint: CGPointMake(11.83, 5.23) controlPoint1: CGPointMake(11.69, 5.09) controlPoint2: CGPointMake(11.74, 5.14)];
            [crossPath addCurveToPoint: CGPointMake(13.94, 7.34) controlPoint1: CGPointMake(12.29, 5.69) controlPoint2: CGPointMake(13.69, 7.09)];
            [crossPath addCurveToPoint: CGPointMake(13.94, 7.34) controlPoint1: CGPointMake(13.89, 7.39) controlPoint2: CGPointMake(13.92, 7.36)];
            [crossPath addCurveToPoint: CGPointMake(16.7, 4.67) controlPoint1: CGPointMake(16.37, 4.91) controlPoint2: CGPointMake(16.52, 4.76)];
            [crossPath addCurveToPoint: CGPointMake(17.77, 4.83) controlPoint1: CGPointMake(17.08, 4.49) controlPoint2: CGPointMake(17.49, 4.56)];
            [crossPath addCurveToPoint: CGPointMake(18.02, 5.93) controlPoint1: CGPointMake(18.11, 5.17) controlPoint2: CGPointMake(18.18, 5.58)];
            [crossPath addCurveToPoint: CGPointMake(17.45, 6.61) controlPoint1: CGPointMake(17.9, 6.15) controlPoint2: CGPointMake(17.75, 6.3)];
            [crossPath addCurveToPoint: CGPointMake(15.33, 8.73) controlPoint1: CGPointMake(17.45, 6.61) controlPoint2: CGPointMake(16.31, 7.75)];
            [crossPath addCurveToPoint: CGPointMake(18.01, 11.5) controlPoint1: CGPointMake(17.76, 11.15) controlPoint2: CGPointMake(17.92, 11.31)];
            [crossPath addCurveToPoint: CGPointMake(17.84, 12.62) controlPoint1: CGPointMake(18.2, 11.9) controlPoint2: CGPointMake(18.13, 12.33)];
            [crossPath addCurveToPoint: CGPointMake(16.69, 12.88) controlPoint1: CGPointMake(17.49, 12.98) controlPoint2: CGPointMake(17.05, 13.05)];
            [crossPath addCurveToPoint: CGPointMake(15.98, 12.28) controlPoint1: CGPointMake(16.46, 12.76) controlPoint2: CGPointMake(16.3, 12.6)];
            [crossPath addCurveToPoint: CGPointMake(13.88, 10.18) controlPoint1: CGPointMake(15.98, 12.28) controlPoint2: CGPointMake(14.85, 11.15)];
            [crossPath addCurveToPoint: CGPointMake(11.12, 12.85) controlPoint1: CGPointMake(11.45, 12.6) controlPoint2: CGPointMake(11.3, 12.75)];
            [crossPath addCurveToPoint: CGPointMake(10.05, 12.68) controlPoint1: CGPointMake(10.74, 13.03) controlPoint2: CGPointMake(10.32, 12.96)];
            [crossPath addCurveToPoint: CGPointMake(9.8, 11.58) controlPoint1: CGPointMake(9.71, 12.34) controlPoint2: CGPointMake(9.64, 11.93)];
            [crossPath addCurveToPoint: CGPointMake(10.23, 11.04) controlPoint1: CGPointMake(9.89, 11.4) controlPoint2: CGPointMake(10.02, 11.26)];
            [crossPath addCurveToPoint: CGPointMake(10.37, 10.91) controlPoint1: CGPointMake(10.28, 11) controlPoint2: CGPointMake(10.32, 10.96)];
            [crossPath addCurveToPoint: CGPointMake(12.49, 8.79) controlPoint1: CGPointMake(10.81, 10.47) controlPoint2: CGPointMake(12.15, 9.13)];
            [crossPath addCurveToPoint: CGPointMake(9.81, 6.01) controlPoint1: CGPointMake(10.06, 6.36) controlPoint2: CGPointMake(9.9, 6.2)];
            [crossPath addCurveToPoint: CGPointMake(9.71, 5.71) controlPoint1: CGPointMake(9.74, 5.89) controlPoint2: CGPointMake(9.72, 5.8)];
            [crossPath addCurveToPoint: CGPointMake(9.97, 4.9) controlPoint1: CGPointMake(9.66, 5.42) controlPoint2: CGPointMake(9.76, 5.11)];
            [crossPath addCurveToPoint: CGPointMake(11.13, 4.63) controlPoint1: CGPointMake(10.33, 4.54) controlPoint2: CGPointMake(10.76, 4.46)];
            [crossPath closePath];
            [UIColor.blackColor setFill];
            [crossPath fill];
        }
    }
    UIGraphicsEndImageContext();

    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
