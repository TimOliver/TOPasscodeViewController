//
//  TOPasscodeCircleRowView.h
//  TOPasscodeViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOPasscodeNumberInputView : UIVisualEffectView <UIKeyInput>

/* The size of each circle in this view (Default is 16) */
@property (nonatomic, assign) CGFloat circleDiameter;

/* The spacing between each circle (Default is 25.0f) */
@property (nonatomic, assign) CGFloat circleSpacing;

/* The number of circles in this view (Default is 4) */
@property (nonatomic, assign) NSInteger requiredLength;

/* The current passcode entered into this view */
@property (nonatomic, copy) NSString *passcode;

/* If this view is directly receiving input, this can change the `UIKeyboard` appearance. */
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;

/* Init with the target length needed for this passcode */
- (instancetype)initWithRequiredLength:(NSInteger)length;

/* Replace the passcode with this one, and animate the transition */
- (void)setPasscode:(NSString *)passcode animated:(BOOL)animated;

/* Add additional characters to the end of the passcode, and animate if desired. */
- (void)appendPasscodeCharacters:(NSString *)characters animated:(BOOL)animated;

/* Delete a number of characters from the end, animated if desired. */
- (void)deletePasscodeCharactersOfCount:(NSInteger)deleteCount animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
