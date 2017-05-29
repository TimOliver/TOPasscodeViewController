//
//  TOPINViewController.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "TOPINViewController.h"
#import "TOPINView.h"
#import "TOPINViewControllerAnimatedTransitioning.h"
#import "TOPINCircleKeypadView.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TOPINViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong, readwrite) UIVisualEffectView *backgroundEffectView;
@property (nonatomic, strong, readwrite) TOPINView *pinView;
@property (nonatomic, strong) UIButton *biometricButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) LAContext *authContext;

@end

@implementation TOPINViewController

#pragma mark - Instance Creation -

- (instancetype)initWithStyle:(TOPINViewStyle)style
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _style = style;
        [self setUp];
    }

    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUp];
    }

    return self;
}

#pragma mark - View Setup -

- (void)setUp
{
    self.transitioningDelegate = self;

    // Show 'Touch ID' button if it's available
    _authContext = [LAContext new];
    _allowBiometricValidation = [_authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];

    if (TOPINViewStyleIsTranslucent(self.style)) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
}

- (void)setUpBackgroundEffectViewForStyle:(TOPINViewStyle)style
{
    BOOL translucent = TOPINViewStyleIsTranslucent(style);

    // Return if it already exists when it should
    if (translucent && self.backgroundEffectView) { return; }

    // Return if it doesn't exist when it shouldn't
    if (!translucent && !self.backgroundEffectView) { return; }

    // Remove it if we're now opaque
    if (!translucent) {
        [self.backgroundEffectView removeFromSuperview];
        self.backgroundEffectView = nil;
        return;
    }

    // Create it otherwise
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[self blurEffectStyleForStyle:style]];
    self.backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.backgroundEffectView.frame = self.view.bounds;
    self.backgroundEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:self.backgroundEffectView atIndex:0];
}

- (UIBlurEffectStyle)blurEffectStyleForStyle:(TOPINViewStyle)style
{
    switch (self.style) {
        case TOPINViewStyleTranslucentDark: return UIBlurEffectStyleDark;
        case TOPINViewStyleTranslucentLight: return UIBlurEffectStyleLight;
        case TOPINViewStyleTranslucentExtraLight: return UIBlurEffectStyleExtraLight;
        default: return 0;
    }

    return 0;
}

- (void)setUpAccessoryButtons
{
    UIFont *buttonFont = [UIFont systemFontOfSize:16.0f];
    BOOL isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;

    if (!self.leftAccessoryButton && self.allowBiometricValidation && !self.biometricButton) {
        self.biometricButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.biometricButton setTitle:@"Touch ID" forState:UIControlStateNormal];
        [self.biometricButton addTarget:self action:@selector(accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        if (isPad) {
            self.pinView.leftButton = self.biometricButton;
        }
        else {
            [self.view addSubview:self.biometricButton];
        }
    }
    else {
        [self.biometricButton removeFromSuperview];
        self.biometricButton = nil;
    }

    if (!self.rightAccessoryButton && !self.cancelButton) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancelButton setTitle:NSLocalizedString(@"Cancel", @"Cancel") forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = buttonFont;
        [self.cancelButton addTarget:self action:@selector(accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        if (isPad) {
            self.pinView.rightButton = self.cancelButton;
        }
        else {
            [self.view addSubview:self.cancelButton];
        }
    }
    else {
        [self.cancelButton removeFromSuperview];
        self.cancelButton = nil;
    }

    [self updateAccessoryButtonFontsForWidth:self.view.bounds.size.width];
}

#pragma mark - View Management -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpBackgroundEffectViewForStyle:self.style];
    [self setUpAccessoryButtons];
    [self applyThemeForStyle:self.style];
}

- (void)viewDidLayoutSubviews
{
    CGSize bounds = self.view.bounds.size;

    // Update the accessory button sizes
    [self updateAccessoryButtonFontsForWidth:bounds.width];

    // Re-layout the accessory buttons
    [self layoutAccessoryButtonsForWidth:bounds.width];

    // Resize the pin view to scale to the new size
    [self.pinView sizeToFitWidth:bounds.width];

    // Re-center the pin view
    self.pinView.center = self.view.center;
}

#pragma mark - View Styling -
- (void)applyThemeForStyle:(TOPINViewStyle)style
{
    BOOL isDark = TOPINViewStyleIsDark(style);

    // Apply the tint color to the accessory buttons
    UIColor *accessoryTintColor = self.accessoryButtonTintColor;
    if (!accessoryTintColor) {
        accessoryTintColor = isDark ? [UIColor whiteColor] : nil;
    }

    self.biometricButton.tintColor = accessoryTintColor;
    self.cancelButton.tintColor = accessoryTintColor;
    self.leftAccessoryButton.tintColor = accessoryTintColor;
    self.rightAccessoryButton.tintColor = accessoryTintColor;
}

- (void)updateAccessoryButtonFontsForWidth:(CGFloat)width
{
    CGFloat pointSize = 17.0f;
    if (width < TOPINViewContentSizeMedium) {
        pointSize = 14.0f;
    }
    else if (width < TOPINViewWContentSizeDefault) {
        pointSize = 16.0f;
    }

    UIFont *accessoryFont = [UIFont systemFontOfSize:pointSize];

    self.biometricButton.titleLabel.font = accessoryFont;
    self.cancelButton.titleLabel.font = accessoryFont;
    self.leftAccessoryButton.titleLabel.font = accessoryFont;
    self.rightAccessoryButton.titleLabel.font = accessoryFont;
}

- (void)layoutAccessoryButtonsForWidth:(CGFloat)width
{
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone) { return; }

    CGFloat verticalInset = 54.0f;
    if (width < TOPINViewContentSizeMedium) {
        verticalInset = 37.0f;
    }
    else if (width < TOPINViewWContentSizeDefault) {
        verticalInset = 43.0f;
    }

    CGFloat inset = self.pinView.keypadButtonInset;
    CGPoint point = (CGPoint){0.0f, self.view.bounds.size.height - verticalInset};

    UIButton *leftButton = self.leftAccessoryButton ? self.leftAccessoryButton : self.biometricButton;
    if (leftButton) {
        [leftButton sizeToFit];
        point.x = self.pinView.frame.origin.x + inset;
        leftButton.center = point;
    }

    UIButton *rightButton = self.rightAccessoryButton ? self.rightAccessoryButton : self.cancelButton;
    if (rightButton) {
        [rightButton sizeToFit];
        point.x = CGRectGetMaxX(self.pinView.frame) - inset;
        rightButton.center = point;
    }
}

#pragma mark - Interactions -
- (void)accessoryButtonTapped:(id)sender
{
    if (sender == self.cancelButton) {
        if ([self.delegate respondsToSelector:@selector(didTapCancelInPINViewController:)]) {
            [self.delegate didTapCancelInPINViewController:self];
        }
    }
    else if (sender == self.biometricButton) {
        if ([self.delegate respondsToSelector:@selector(didInitiateBiometricValidationRequestInPINViewController:)]) {
            [self.delegate didInitiateBiometricValidationRequestInPINViewController:self];
        }
    }
}

#pragma mark - Transitioning Delegate -
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINViewController:self dismissing:NO];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[TOPINViewControllerAnimatedTransitioning alloc] initWithPINViewController:self dismissing:YES];
}

#pragma mark - Public Accessors -
- (TOPINView *)pinView
{
    if (_pinView) { return _pinView; }

    _pinView = [[TOPINView alloc] initWithStyle:self.style];
    _pinView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [_pinView sizeToFit];
    _pinView.center = self.view.center;
    [self.view addSubview:_pinView];
    return _pinView;
}

- (void)setStyle:(TOPINViewStyle)style
{
    if (style == _style) { return; }
    _style = style;

    self.pinView.style = style;
    [self setUpBackgroundEffectViewForStyle:style];
}

- (void)setAllowBiometricValidation:(BOOL)allowBiometricValidation
{
    if (_allowBiometricValidation == allowBiometricValidation) {
        return;
    }

    if (allowBiometricValidation) {
        _allowBiometricValidation = [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    }
    else {
        _allowBiometricValidation = NO;
    }
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    self.pinView.titleLabelColor = titleLabelColor;
}

- (UIColor *)titleLabelColor { return self.pinView.titleLabelColor; }

- (void)setInputProgressViewTintColor:(UIColor *)inputProgressViewTintColor
{
    self.pinView.inputProgressViewTintColor = inputProgressViewTintColor;
}

- (UIColor *)inputProgressViewTintColor { return self.pinView.inputProgressViewTintColor; }

- (void)setkeypadButtonBackgroundTintColor:(UIColor *)keypadButtonBackgroundTintColor
{
    self.pinView.keypadButtonBackgroundColor = keypadButtonBackgroundTintColor;
}

- (UIColor *)keypadButtonBackgroundTintColor { return self.pinView.keypadButtonBackgroundColor; }

- (void)setKeypadButtonTextColor:(UIColor *)keypadButtonTextColor
{
    self.pinView.keypadButtonTextColor = keypadButtonTextColor;
}

- (UIColor *)keypadButtonTextColor { return self.pinView.keypadButtonTextColor; }

- (void)setKeypadButtonHighlightedTextColor:(UIColor *)keypadButtonHighlightedTextColor
{
    self.pinView.keypadButtonHighlightedTextColor = keypadButtonHighlightedTextColor;
}

- (UIColor *)keypadButtonHighlightedTextColor { return self.pinView.keypadButtonHighlightedTextColor; }

- (void)setAccessoryButtonTintColor:(UIColor *)accessoryButtonTintColor
{
    if (accessoryButtonTintColor == _accessoryButtonTintColor) { return; }
    _accessoryButtonTintColor = accessoryButtonTintColor;
    [self applyThemeForStyle:self.style];
}

@end
