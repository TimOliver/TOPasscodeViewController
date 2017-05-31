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

#import <AudioToolbox/AudioToolbox.h>

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
- (BOOL)canBecomeFirstResponder { return YES; }

- (BOOL)hasText { return self.passcode.length > 0; }

- (void)insertText:(NSString *)text
{
    [self appendPasscodeCharacters:text animated:NO];
}
- (void)deleteBackward
{
    [self deletePasscodeCharactersOfCount:1 animated:YES];
}

- (UIKeyboardType)keyboardType { return UIKeyboardTypeNumberPad; }

#pragma mark - Text Input -
- (void)setPasscode:(NSString *)passcode animated:(BOOL)animated
{
    if (passcode == self.passcode) { return; }
    _passcode = @"";

    NSInteger length = MIN(passcode.length, self.requiredLength);

    for (NSInteger i = 0; i < length; i++) {
        NSInteger intValue = [[passcode substringWithRange:NSMakeRange(i, 1)] integerValue];
        _passcode = [_passcode stringByAppendingFormat:@"%ld", intValue];
    }

    [self updateHighlightedCirclesWithCount:_passcode.length animated:animated];
}

- (void)appendPasscodeCharacters:(NSString *)characters animated:(BOOL)animated
{
    if (characters == nil) { return; }
    if (_passcode == nil) { _passcode = @""; }

    [self setPasscode:[_passcode stringByAppendingString:characters] animated:animated];
}

- (void)deletePasscodeCharactersOfCount:(NSInteger)deleteCount animated:(BOOL)animated
{
    if (deleteCount <= 0 || self.passcode.length <= 0) { return; }
    [self setPasscode:[self.passcode substringToIndex:(self.passcode.length - 1)] animated:animated];
}

- (void)updateHighlightedCirclesWithCount:(NSInteger)count animated:(BOOL)animated
{
    NSInteger i = 0;
    for (TOPasscodeCircleView *circleView in self.circleViews) {
        [circleView setHighlighted:(i < count) animated:animated];
        i++;
    }
}

- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact
{
    [self setPasscode:nil animated:animated];

    if (impact) {
        // https://stackoverflow.com/questions/41444274/how-to-check-if-haptic-engine-uifeedbackgenerator-is-supported
        AudioServicesPlaySystemSoundWithCompletion(1521, nil);
    }

    if (!animated) { return; }

    CGPoint center = self.center;
    CGPoint offset = center;
    offset.x -= self.frame.size.width * 0.3f;

    // Play the view sliding out and then springing back in
    id completionBlock = ^(BOOL finished) {
        [UIView animateWithDuration:1.0f
                              delay:0.0f
             usingSpringWithDamping:0.15f
              initialSpringVelocity:10.0f
                            options:0 animations:^{
                                self.center = center;
                            }completion:nil];
    };

    [UIView animateWithDuration:0.05f animations:^{
        self.center = offset;
    }completion:completionBlock];
}

#pragma mark - Public Accessors -

- (void)setPasscode:(NSString *)passcode
{
    [self setPasscode:passcode animated:NO];
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

- (void)setRequiredLength:(NSInteger)requiredLength
{
    if (_requiredLength == requiredLength) { return; }
    _requiredLength = requiredLength;
    [self setUpCircleViewsOfCount:requiredLength];
    [self sizeToFit];
}

@end
