//
//  TOPINViewControllerExampleTests.m
//  TOPINViewControllerExampleTests
//
//  Created by Tim Oliver on 5/15/17.
//  Copyright © 2017 Timothy Oliver. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TOPasscodeViewController.h"

@interface TOPasscodeViewControllerExampleTests : XCTestCase

@end

@implementation TOPasscodeViewControllerExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPresentingViewController
{
    UIViewController *parentViewController = [[UIViewController alloc] init];
    TOPasscodeViewController *controller = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark passcodeType:TOPasscodeTypeFourDigits];
    [parentViewController presentViewController:controller animated:NO completion:nil];
    XCTAssertNotNil(controller);
}

@end
