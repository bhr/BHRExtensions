//
//  UIViewController+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/29/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BHRExtensions)

+ (UIViewController*)topViewController;
- (UIViewController*)topVisibleViewController;

/**
 * Adds a constraint based child view controller filling out the whole space by respecting topLayoutGuide and bottomLayoutGuide
 */
- (void)addConstraintBasedChildViewController:(UIViewController *)childViewController;

@end
