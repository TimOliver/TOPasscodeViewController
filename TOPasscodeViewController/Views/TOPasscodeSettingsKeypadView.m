//
//  TOPasscodeSettingsKeypadView.m
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 6/18/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPasscodeSettingsKeypadView.h"

@interface TOPasscodeSettingsKeypadView ()

@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) NSArray<UIButton *> *keypadButtons;

@end

@implementation TOPasscodeSettingsKeypadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    CGSize viewSize = self.frame.size;
    CGFloat height = 1.0f / [[UIScreen mainScreen] scale];

    self.separatorView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,{viewSize.width, height}}];
    self.separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.separatorView];

    [self applyThemeForStyle:self.style];
}

- (void)setUpKeypadButtons
{
    NSInteger numberOfButtons = 10;
    NSArray *letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL",
                                @"MNO", @"PQRS", @"TUV", @"WXYZ"];


}

- (UIButton *)makeKeypadButtonForNumber:(NSInteger)number letteredTitle:(nullable NSString *)letteredTitle
{
    
}

- (void)applyThemeForStyle:(TOPasscodeSettingsViewStyle)style
{
    BOOL isDark = (style == TOPasscodeSettingsViewStyleDark);

    // Background Color
    UIColor *backgroundColor = nil;
    if (isDark) {
        backgroundColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    }
    else {
        backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:225.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    }
    self.backgroundColor = backgroundColor;

    // Separator lines
    UIColor *separatorColor = nil;
    if (isDark) {
        separatorColor = [UIColor colorWithWhite:0.3f alpha:1.0f];
    }
    else {
        separatorColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    }
    self.separatorView.backgroundColor = separatorColor;
}

@end
