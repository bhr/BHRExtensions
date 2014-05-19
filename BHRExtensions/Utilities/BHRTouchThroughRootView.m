//
//  BHRTouchThroughRootView.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/19/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRTouchThroughRootView.h"

@implementation BHRTouchThroughRootView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];

	if ([self.delegate respondsToSelector:@selector(touchThroughRootView:shouldPassTouchesForView:)])
	{
		BOOL shouldPassTouches = [self.delegate touchThroughRootView:self
											shouldPassTouchesForView:view];
		if (shouldPassTouches)
		{
			return nil;
		}
	}

    return view;
}

@end
