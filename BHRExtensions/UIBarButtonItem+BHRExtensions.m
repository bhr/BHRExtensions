//
//  UIBarButtonItem+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/19/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIBarButtonItem+BHRExtensions.h"

@implementation UIBarButtonItem (BHRExtensions)

- (void)addGestureRecognizer:(UIGestureRecognizer *)recognizer
{
	UIView *view = [self valueForKey:@"view"];
	[view addGestureRecognizer:recognizer];
}

@end
