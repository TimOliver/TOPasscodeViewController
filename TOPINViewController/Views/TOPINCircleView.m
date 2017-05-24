//
//  TOPINCircleView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINCircleView.h"

@interface TOPINCircleView ()
@property (nonatomic, strong) UIImageView *bottomView;
@property (nonatomic, strong) UIImageView *topView;
@end

@implementation TOPINCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.bottomView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.bottomView.userInteractionEnabled = NO;
        self.bottomView.contentMode = UIViewContentModeCenter;
        self.bottomView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.bottomView];

        self.topView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.topView.userInteractionEnabled = NO;
        self.topView.contentMode = UIViewContentModeCenter;
        self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.topView.alpha = 0.0f;
        [self addSubview:self.topView];
    }

    return self;
}

- (void)setIsHighlighted:(BOOL)isHighlighted
{
    [self setHighlighted:isHighlighted animated:NO];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted == self.isHighlighted) { return; }

    _isHighlighted = highlighted;

    void (^animationBlock)() = ^{
        self.topView.alpha = highlighted ? 1.0f : 0.0f;
    };

    if (!animated) {
        animationBlock();
        return;
    }

    [UIView animateWithDuration:0.5f animations:animationBlock];
}

- (void)setCircleImage:(UIImage *)circleImage
{
    _circleImage = circleImage;
    self.bottomView.image = circleImage;
}

- (void)setHighlightedCircleImage:(UIImage *)highlightedCircleImage
{
    _highlightedCircleImage = highlightedCircleImage;
    self.topView.image = highlightedCircleImage;
}

@end
