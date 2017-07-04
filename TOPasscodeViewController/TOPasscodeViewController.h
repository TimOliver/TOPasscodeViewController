//
//  TOPasscodeViewController.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOPasscodeViewControllerConstants.h"
#import "TOPasscodeView.h"

NS_ASSUME_NONNULL_BEGIN

@class TOPasscodeViewController;

@protocol TOPasscodeViewControllerDelegate <NSObject>

@optional

/** 
 Return YES if the user entered the expected PIN code. Return NO if it was incorrect.
 (For security reasons, it is safer to fetch the saved PIN code only when this method is called, and
  then discard it immediately. This is why the view controller does not directly store it.)
*/
- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code;

/** The user tapped the 'Cancel' button. Any dismissing of confidential content should be done in here. */
- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController;

/** The user successfully entered the correct code, as validated by `isCorrectCode:` */
- (void)didInputCorrectPasscodeInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController;

/** When available, the user tapped the 'Touch ID' button, or the view controller itself automatically initiated
    the Touch ID request on display. This method is where you should implement your
    own Touch ID validation logic. For security reasons, this controller does not implement the Touch ID logic itself. */

- (void)didPerformBiometricValidationRequestInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController;

/** Called when the pin view was resized as a result of the view controller being resized.
    You can use this to resize your custom header view if necessary.
 */
- (void)passcodeViewController:(TOPasscodeViewController *)passcodeViewController didResizePasscodeViewToWidth:(CGFloat)width;

@end

@interface TOPasscodeViewController : UIViewController

/** A delegate object, in charge of verifying the PIN code entered by the user */
@property (nonatomic, weak, nullable) id<TOPasscodeViewControllerDelegate> delegate;

/** The base style of the PIN view controller. Can be configured further. */
@property (nonatomic, assign) TOPasscodeViewStyle style;

/** The type of passcode that is expected to be entered. */
@property (nonatomic, assign) TOPasscodeType passcodeType;

/** Will show a 'Touch ID' button for that the user can tap to initiate Touch ID verification. (Default is NO) */
@property (nonatomic, assign) BOOL allowBiometricValidation;

/** If Touch ID is available, automatically ask for it upon presentation (Default is YES) */
@property (nonatomic, assign) BOOL automaticallyPromptForBiometricValidation;

/** Optionally change the color of the title text label. */
@property (nonatomic, strong, nullable) UIColor *titleLabelColor;

/** Optionally change the tint color of the UI element that indicates input progress (eg the row of circles) */
@property (nonatomic, strong, nullable) UIColor *inputProgressViewTintColor;

/** If the style isn't translucent, changes the tint color of the keypad circle button outlines. */
@property (nonatomic, strong, nullable) UIColor *keypadButtonBackgroundTintColor;

/** The color of the text elements in each keypad button */
@property (nonatomic, strong, nullable) UIColor *keypadButtonTextColor;

/** Optionally, the text color of the keypad button text when tapped. Animates back to the base color. */
@property (nonatomic, strong, nullable) UIColor *keypadButtonHighlightedTextColor;

/** The tint button of the accessory button views at the bottom of the keypad (ie 'Cance' etc) */
@property (nonatomic, strong, nullable) UIColor *accessoryButtonTintColor;

/** Controls the transluceny of the PIN background when the style has been set to translucent. */
@property (nonatomic, readonly) UIVisualEffectView *backgroundEffectView;

/** Opaque, background view when the style is opaque */
@property (nonatomic, readonly) UIView *backgroundView;

/** The keypad and accessory views that are displayed in the center of this view */
@property (nonatomic, readonly) TOPasscodeView *passcodeView;

/** The Touch ID button, visible if biometrics is enabled and `leftAccessoryButton` is nil. */
@property (nonatomic, readonly) UIButton *biometricButton;

/** The Cancel, visible if `rightAccessoryButton` is nil. */
@property (nonatomic, readonly) UIButton *cancelButton;

/** The left accessory button. Setting this will override the 'Touch ID' button. */
@property (nonatomic, strong, nullable) UIButton *leftAccessoryButton;

/** The right accessory button. Setting this will override the 'Cancel' button. */
@property (nonatomic, strong, nullable) UIButton *rightAccessoryButton;

/** Create a new instance of this view controller with the preset style. */
- (instancetype)initWithStyle:(TOPasscodeViewStyle)style;

@end

NS_ASSUME_NONNULL_END
