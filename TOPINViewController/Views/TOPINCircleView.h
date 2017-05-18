//
//  TOPINCircleView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPINCircleView : UIView

@property (nonatomic, strong) UIImage *circleImage;
@property (nonatomic, strong) UIImage *highlightedCircleImage;

@property (nonatomic, assign) BOOL isHighlighted;

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@end
