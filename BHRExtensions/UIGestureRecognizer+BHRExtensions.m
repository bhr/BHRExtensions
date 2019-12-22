//
//  UIGestureRecognizer+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 11/5/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIGestureRecognizer+BHRExtensions.h"

@implementation UIGestureRecognizer (BHRExtensions)

- (void)cancel
{
	self.enabled = NO;
	self.enabled = YES;
}

@end
