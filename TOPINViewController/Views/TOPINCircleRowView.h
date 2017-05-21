//
//  TOPINCircleRowView.h
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOPINCircleRowView : UIView

@property (nonatomic, assign) NSInteger numberOfCircles;
@property (nonatomic, assign) NSInteger numberOfHighlightedCircles;

- (void)setNumberOfHighlightedCircles:(NSInteger)numberOfHighlightedCircles animated:(BOOL)animated;

@end
