//
//  TOPINCircleKeypadView.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/17/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINCircleKeypadView.h"
#import "TOPINImage.h"
#import "TOPINCircleButton.h"

@interface TOPINCircleKeypadView()

@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *tappedButtonImage;

@property (nonatomic, strong, readwrite) NSArray<TOPINCircleButton *> *pinButtons;

@end

@implementation TOPINCircleKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _buttonDiameter = 81.0f;
        _buttonSpacing = (CGSize){25,15};
        _buttonStrokeWidth = 1.5f;
        _showLettering = YES;
        [self sizeToFit];
    }

    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) { return; }
    [self setUpButtons];
}

- (void)setUpButtons
{
    if (self.pinButtons) { return; }

    NSInteger numberOfButtons = 10;
    NSArray *letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL",
                                @"MNO", @"PQRS", @"TUV", @"WXYZ"];

    NSMutableArray *buttons = [NSMutableArray array];
    for (NSInteger i = 0; i < numberOfButtons; i++) {
        // Work out the button number text
        NSInteger buttonNumber = i + 1;
        if (buttonNumber == 10) { buttonNumber = 0; }
        NSString *numberString = [NSString stringWithFormat:@"%ld", (long)buttonNumber];

        // Work out the lettering text
        NSString *letteringString = nil;
        if (self.showLettering && i > 0 && i-1 < letteredTitles.count) {
            letteringString = letteredTitles[i-1];
        }

        TOPINCircleButton *circleButton = [[TOPINCircleButton alloc] initWithNumberString:numberString letteringString:letteringString];
        circleButton.backgroundImage = self.buttonImage;
        circleButton.hightlightedBackgroundImage = self.tappedButtonImage;
        circleButton.vibrancyEffect = self.vibrancyEffect;
        [self addSubview:circleButton];

        [buttons addObject:circleButton];
    }

    self.pinButtons = [NSArray arrayWithArray:buttons];
}

- (void)sizeToFit
{
    CGRect frame = self.frame;
    frame.size.width = (self.buttonDiameter * 3) + (self.buttonSpacing.width * 2);
    frame.size.height = (self.buttonDiameter * 4) + (self.buttonSpacing.height * 3);
    self.frame = frame;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    NSInteger i = 0;
    CGPoint origin = CGPointZero;
    for (TOPINCircleButton *button in self.pinButtons) {
        CGRect frame = button.frame;
        frame.origin = origin;
        button.frame = frame;

        CGFloat horizontalOffset = frame.size.width + self.buttonSpacing.width;
        origin.x += horizontalOffset;

        i++;
        if (i % 3 == 0) {
            origin.x = 0.0f;
            origin.y = origin.y + frame.size.height + self.buttonSpacing.height;
        }
    }

    TOPINCircleButton *lastButton = self.pinButtons.lastObject;
    CGRect frame = lastButton.frame;
    frame.origin.x += (frame.size.width + self.buttonSpacing.width);
    lastButton.frame = frame;
}

#pragma mark - Lazy Accessors -
- (UIImage *)buttonImage
{
    if (!_buttonImage) {
        _buttonImage = [TOPINImage PINHollowCircleImageOfSize:self.buttonDiameter strokeWidth:self.buttonStrokeWidth padding:1.0f];
    }

    return _buttonImage;
}

- (UIImage *)tappedButtonImage
{
    if (!_tappedButtonImage) {
        _tappedButtonImage = [TOPINImage PINCircleImageOfSize:self.buttonDiameter inset:self.buttonStrokeWidth * 0.5f padding:1.0f];
    }

    return _tappedButtonImage;
}

@end
