//
//  TOPINCircleRowView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINCircleRowView.h"
#import "TOPINCircleView.h"
#import "TOPINImage.h"

@interface TOPINCircleRowView ()
@property (nonatomic, strong) NSMutableArray<TOPINCircleView *> *circles;

@property (nonatomic, strong) UIImage *circleImage;
@property (nonatomic, strong) UIImage *highlightedCircleImage;

@end

@implementation TOPINCircleRowView

#pragma mark - View Set-up -

- (instancetype)initWithNumberOfCircles:(NSInteger)numberOfCircles
{
    if (self = [self initWithFrame:CGRectZero]) {
        _numberOfCircles = numberOfCircles;
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _numberOfCircles = 4;
        _circleDiameter = 16.0f;
        _circleSpacing = 25.0f;
        [self sizeToFit];
        [self updateCircleImagesForDiameter:_circleDiameter];
        [self setUpCircleViewsOfCount:_numberOfCircles];
    }

    return self;
}

#pragma mark - View Layout -

- (void)sizeToFit
{
    // Resize the view to encompass the circles
    CGRect frame = self.frame;
    frame.size.width = (_circleDiameter * _numberOfCircles) + (_circleSpacing * (_numberOfCircles - 1)) + 2.0f;
    frame.size.height = _circleDiameter + 2.0f;
    self.frame = frame;
}

- (void)layoutSubviews
{
    CGRect frame = CGRectZero;
    frame.size = (CGSize){self.circleDiameter + 2.0f, self.circleDiameter + 2.0f};

    for (TOPINCircleView *circleView in self.circles) {
        circleView.frame = frame;
        frame.origin.x += self.circleDiameter + self.circleSpacing;
    }
}

#pragma mark - Circle View Management -
- (void)updateCircleImagesForDiameter:(CGFloat)diameter
{
    self.circleImage = [TOPINImage PINHollowCircleImageOfSize:diameter strokeWidth:1.0f padding:1.0f];
    self.highlightedCircleImage = [TOPINImage PINCircleImageOfSize:diameter inset:0.5f padding:1.0f];

    for (TOPINCircleView *circleView in self.circles) {
        circleView.circleImage = self.circleImage;
        circleView.highlightedCircleImage = self.highlightedCircleImage;
    }
}

- (void)setUpCircleViewsOfCount:(NSInteger)numberOfCircles
{
    if (self.circles == nil) {
        self.circles = [NSMutableArray array];
    }

    // Remove any extraneous circle views
    while (self.circles.count > numberOfCircles) {
        TOPINCircleView *lastView = self.circles.lastObject;
        [lastView removeFromSuperview];
        [self.circles removeLastObject];
    }

    // Add any circles needed
    CGRect frame = (CGRect){CGPointZero, {self.circleDiameter, self.circleDiameter}};
    while (self.circles.count < numberOfCircles) {
        TOPINCircleView *newCircleView = [[TOPINCircleView alloc] initWithFrame:frame];
        newCircleView.circleImage = self.circleImage;
        newCircleView.highlightedCircleImage = self.highlightedCircleImage;
        [self.contentView addSubview:newCircleView];
        [self.circles addObject:newCircleView];
    }

    [self setNeedsLayout];
}

#pragma mark - Public Accessors -
- (void)setNumberOfHighlightedCircles:(NSInteger)numberOfHighlightedCircles
{
    [self setNumberOfHighlightedCircles:numberOfHighlightedCircles animated:NO];
}

- (void)setNumberOfHighlightedCircles:(NSInteger)numberOfHighlightedCircles animated:(BOOL)animated
{
    if (_numberOfHighlightedCircles == numberOfHighlightedCircles) {
        return;
    }

    _numberOfHighlightedCircles = numberOfHighlightedCircles;
    
    NSInteger i = 0;
    for (TOPINCircleView *circleView in self.circles) {
        [circleView setHighlighted:(i < _numberOfHighlightedCircles) animated:animated];
        i++;
    }
}

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

- (void)setNumberOfCircles:(NSInteger)numberOfCircles
{
    if (_numberOfCircles == numberOfCircles) { return; }
    _numberOfCircles = numberOfCircles;
    [self setUpCircleViewsOfCount:numberOfCircles];
    [self sizeToFit];
}

@end
