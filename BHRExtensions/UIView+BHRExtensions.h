//
//  UIView+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BHRExtensions)

- (UIImage *)blurredSnapshot;
- (UIImage *)snapshot;

- (void)addConstraintBasedSubview:(UIView *)view;
- (void)addConstraintBasedSubview:(UIView *)view withInsets:(UIEdgeInsets)insets;

- (BOOL)findAndResignFirstResponder;

@end
