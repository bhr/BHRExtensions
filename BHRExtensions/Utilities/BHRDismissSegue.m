//
//  BHRDismissSegue.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRDismissSegue.h"

@implementation BHRDismissSegue

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
