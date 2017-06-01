//
//  ViewController.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "ViewController.h"
#import "TOPasscodeViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Enable mipmaps so the rescaled image will look properly sampled
    self.imageView.layer.minificationFilter = kCAFilterTrilinear;
}

- (IBAction)showButtonTapped:(id)sender
{
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark];
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.presentedViewController) {
        return [self.presentedViewController preferredStatusBarStyle];
    }

    return UIStatusBarStyleLightContent;
}
@end
