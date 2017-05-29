//
//  ViewController.m
//  TOPINViewControllerExample
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import "ViewController.h"
#import "TOPINViewController.h"

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
    TOPINViewController *pinViewController = [[TOPINViewController alloc] init];
    [self presentViewController:pinViewController animated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
