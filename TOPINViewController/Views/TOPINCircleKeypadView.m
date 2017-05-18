//
//  TOPINCircleKeypadView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINCircleKeypadView.h"
#import "TOPINImage.h"

@interface TOPINCircleKeypadView()

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *tappedButtonImage;

@end

@implementation TOPINCircleKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _buttonDiameter = 85.0f;
        _buttonSpacing = (CGSize){25,15};
        _buttonStrokeWidth = 1.5f;
    }

    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) { return; }
}

- (void)setUpButtons
{
    if (self.pinButtons) { return; }

    NSMutableArray *buttons = [NSMutableArray array];
    
}

#pragma mark - Lazy Accessors -
- (UIImage *)buttonImage
{
    if (!_buttonImage) {
        _buttonImage = [TOPINImage PINHollowCircleImageOfDiameter:self.buttonDiameter
                                                      strokeWidth:self.buttonStrokeWidth];
    }

    return _buttonImage;
}

- (UIImage *)tappedButtonImage
{
    if (!_tappedButtonImage) {
        _tappedButtonImage = [TOPINImage PINCircleImageOfDiameter:self.buttonDiameter];
    }

    return _tappedButtonImage;
}

@end
