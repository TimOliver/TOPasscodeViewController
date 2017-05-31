//
//  TOPasscodeCircleRowView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeNumberInputView.h"
#import "TOPasscodeCircleView.h"
#import "TOPasscodeCircleImage.h"

@interface TOPasscodeNumberInputView ()
@property (nonatomic, strong) NSMutableArray<TOPasscodeCircleView *> *circleViews;

@property (nonatomic, strong) UIImage *circleImage;
@property (nonatomic, strong) UIImage *highlightedCircleImage;

@end

@implementation TOPasscodeNumberInputView

#pragma mark - View Set-up -

- (instancetype)initWithRequiredLength:(NSInteger)length
{
    if (self = [self initWithFrame:CGRectZero]) {
        _requiredLength = length;
        [self setUpCircleViewsOfCount:_requiredLength];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _requiredLength = 4;
        _circleDiameter = 16.0f;
        _circleSpacing = 25.0f;
        [self sizeToFit];
        [self updateCircleImagesForDiameter:_circleDiameter];
        [self setUpCircleViewsOfCount:_requiredLength];
    }

    return self;
}

#pragma mark - View Layout -

- (void)sizeToFit
{
    // Resize the view to encompass the circles
    CGRect frame = self.frame;
    frame.size.width = (_circleDiameter * _requiredLength) + (_circleSpacing * (_requiredLength - 1)) + 2.0f;
    frame.size.height = _circleDiameter + 2.0f;
    self.frame = frame;
}

- (void)layoutSubviews
{
    CGRect frame = CGRectZero;
    frame.size = (CGSize){self.circleDiameter + 2.0f, self.circleDiameter + 2.0f};

    for (TOPasscodeCircleView *circleView in self.circleViews) {
        circleView.frame = frame;
        frame.origin.x += self.circleDiameter + self.circleSpacing;
    }
}

#pragma mark - Circle View Management -
- (void)updateCircleImagesForDiameter:(CGFloat)diameter
{
    self.circleImage = [TOPasscodeCircleImage hollowCircleImageOfSize:diameter strokeWidth:1.0f padding:1.0f];
    self.highlightedCircleImage = [TOPasscodeCircleImage circleImageOfSize:diameter inset:0.5f padding:1.0f];

    for (TOPasscodeCircleView *circleView in self.circleViews) {
        circleView.circleImage = self.circleImage;
        circleView.highlightedCircleImage = self.highlightedCircleImage;
    }
}

- (void)setUpCircleViewsOfCount:(NSInteger)numberOfCircles
{
    if (self.circleViews == nil) {
        self.circleViews = [NSMutableArray array];
    }

    // Remove any extraneous circle views
    while (self.circleViews.count > numberOfCircles) {
        TOPasscodeCircleView *lastView = self.circleViews.lastObject;
        [lastView removeFromSuperview];
        [self.circleViews removeLastObject];
    }

    // Add any circles needed
    CGRect frame = (CGRect){CGPointZero, {self.circleDiameter, self.circleDiameter}};
    while (self.circleViews.count < numberOfCircles) {
        TOPasscodeCircleView *newCircleView = [[TOPasscodeCircleView alloc] initWithFrame:frame];
        newCircleView.circleImage = self.circleImage;
        newCircleView.highlightedCircleImage = self.highlightedCircleImage;
        [self.contentView addSubview:newCircleView];
        [self.circleViews addObject:newCircleView];
    }

    [self setNeedsLayout];
}

#pragma mark - Text Input Protocol -

#pragma mark - Public Accessors -

- (void)setCircleSpacing:(CGFloat)circleSpacing
{
    if (circleSpacing == _circleSpacing) { return; }
    _circleSpacing = circleSpacing;
    [self sizeToFit];
}

- (void)setCircleDiameter:(CGFloat)circleDiameter
{
    if (_circleDiameter == circleDiameter) { return; }
    _circleDiameter = circleDiameter;

    [self updateCircleImagesForDiameter:circleDiameter];
    [self sizeToFit];
}

- (void)setRequiredLength:(NSInteger)requiredLength
{
    if (_requiredLength == requiredLength) { return; }
    _requiredLength = requiredLength;
    [self setUpCircleViewsOfCount:requiredLength];
    [self sizeToFit];
}

@end
