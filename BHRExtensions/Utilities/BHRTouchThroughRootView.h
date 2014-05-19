//
//  BHRTouchThroughRootView.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/19/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHRTouchThroughRootViewDelegate;

@interface BHRTouchThroughRootView : UIView

@property (nonatomic, weak) id<BHRTouchThroughRootViewDelegate> delegate;

/**
 * Enables to pass touches through to an overlaying view
 *
 * Usage:	Place Touch Through Root View as root view where the views that need to be unblocked should be
 *
 * Illustration of Sample View Hierarchy:
 * UIView
 *		|- UIScrolView
 *		|- BHRTouchThroughRootView
 *			|- UIView (with content)
 *
 * Here, BHRTouchThroughRootView enables UIScrollView to receive scroll events!
 *
 *
 * Via the delegate you can enable/disable passing touches to the upper view (in the example the UIScrollView).
 */

@end


@protocol BHRTouchThroughRootViewDelegate <NSObject>

- (BOOL)touchThroughRootView:(BHRTouchThroughRootView *)touchThroughRootView
	shouldPassTouchesForView:(UIView *)view;

@end