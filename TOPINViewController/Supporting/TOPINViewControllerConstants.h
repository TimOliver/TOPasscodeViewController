//
//  TOPINViewControllerConstants.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

typedef NS_ENUM(NSInteger, TOPINViewStyle) {
    TOPINViewStyleTranslucentDark,
    TOPINViewStyleTranslucentExtraDark,
    TOPINViewStyleTranslucentLight,
    TOPINViewStyleTranslucentExtraLight,
    TOPINViewStyleOpaqueDark,
    TOPINViewStyleOpaqueLight
};

static inline BOOL TOPINViewStyleIsTranslucent(TOPINViewStyle style) {
    return style <= TOPINViewStyleTranslucentExtraLight;
}

static inline BOOL TOPINViewStyleIsDark(TOPINViewStyle style) {
    return style == TOPINViewStyleTranslucentDark || style == TOPINViewStyleOpaqueDark;
}
