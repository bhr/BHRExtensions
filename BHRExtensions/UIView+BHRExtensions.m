//
//  UIView+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIView+BHRExtensions.h"

@implementation UIView (BHRExtensions)

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder)
	{
        [self resignFirstResponder];
        return YES;
    }
	
    for (UIView *subView in self.subviews)
	{
        if ([subView findAndResignFirstResponder]) {
            return YES;
		}
    }
	
    return NO;
}

@end
