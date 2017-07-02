//
//  TOPasscodeSettingsWarningLabel.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/28/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsWarningLabel.h"

@interface TOPasscodeSettingsWarningLabel ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation TOPasscodeSettingsWarningLabel

@synthesize backgroundColor = __backgroundColor;

#pragma mark - View Setup -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    _textPadding = CGSizeMake(12.0f, 4.0f);

    self.tintColor = [UIColor colorWithRed:214.0f/255.0f green:63.0f/255.0f blue:63.0f/255.0f alpha:1.0f];

    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:15.0f];
    [self setTextForCount:0];
    [self.label sizeToFit];
    [self addSubview:self.label];
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self setBackgroundImageIfNeeded];
}

#pragma mark - View Layout -

- (void)sizeToFit
{
    [super sizeToFit];
    CGRect frame = self.frame;
    CGRect labelFrame = self.label.frame;

    labelFrame = CGRectInset(labelFrame, -self.textPadding.width, -self.textPadding.height);
    frame.size = labelFrame.size;
    frame.origin.x = CGRectGetMidX(frame) - (CGRectGetWidth(labelFrame) * 0.5f);
    frame.origin.y = CGRectGetMidY(frame) - (CGRectGetHeight(labelFrame) * 0.5f);
    self.frame = frame;
}

- (void)layoutSubviews
{
    CGRect frame = self.frame;
    CGRect labelFrame = self.label.frame;

    labelFrame.origin.x = (CGRectGetWidth(frame) - CGRectGetWidth(labelFrame)) * 0.5f;
    labelFrame.origin.y = (CGRectGetWidth(frame) - CGRectGetWidth(labelFrame)) * 0.5f;
    self.label.frame = labelFrame;
}

#pragma mark - View State Handling -

- (void)setTextForCount:(NSInteger)count
{
    NSString *text = nil;
    if (count == 1) {
        text = NSLocalizedString(@"1 Failed Passcode Attempt", @"");
    }
    else {
        text = [NSString stringWithFormat:NSLocalizedString(@"%@ Failed Passcode Attempts", @""), count];
    }
    self.label.text = text;

    [self sizeToFit];
}

#pragma mark - Background Image Managements -

- (void)setBackgroundImageIfNeeded
{
    // Don't bother if we're not in a view
    if (self.superview == nil) { return; }

    // Compare the view height and don't proceed if
    if (lround(self.image.size.height) == lround(self.frame.size.height)) { return; }

    // Create the image
    self.image = [[self class] roundedBackgroundImageWithHeight:self.frame.size.height];
}

+ (UIImage *)roundedBackgroundImageWithHeight:(CGFloat)height
{
    UIImage *image = nil;
    CGRect frame = CGRectZero;
    frame.size.width = height + 1.0;
    frame.size.height = height;

    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
    {
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:height * 0.5f];
        [[UIColor blackColor] setFill];
        [path fill];

        image = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();

    CGFloat halfHeight = height * 0.5f;
    UIEdgeInsets insets = UIEdgeInsetsMake(halfHeight, halfHeight, halfHeight, halfHeight);
    image = [image resizableImageWithCapInsets:insets];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return image;
}

@end
