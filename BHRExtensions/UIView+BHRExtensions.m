//
//  UIView+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIView+BHRExtensions.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (BHRExtensions)


-(UIImage *)blurredSnapshot
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
	
    // There he is! The new API method
	[self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
	
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	
	UIImage *blurredSnapshotImage;
	
	//	blurredSnapshotImage = [snapshotImage applyDarkEffect];
	blurredSnapshotImage = [snapshotImage applyNeutralEffect];
	//	blurredSnapshotImage = [snapshotImage applyLightEffect];
	//	blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
	
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
	
    return blurredSnapshotImage;
}

- (UIImage *)snapshot
{
	// Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
	
    // There he is! The new API method
	[self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
	
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
	
    UIGraphicsEndImageContext();
	
	return snapshotImage;
}

- (void)addConstraintBasedSubview:(UIView *)view
{
	[self addConstraintBasedSubview:view withInsets:UIEdgeInsetsZero];
}

- (void)addConstraintBasedSubview:(UIView *)view withInsets:(UIEdgeInsets)insets
{
	view.frame = self.bounds;
	[self addSubview:view];
	
	[self setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	NSDictionary *views = @{@"subview": view};
	NSDictionary *metrics = @{
							  @"left": @(insets.left),
							  @"right": @(insets.right),
							  @"top": @(insets.top),
							  @"bottom": @(insets.bottom),
							  };
	
	NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[subview]-right-|"
																   options:0
																   metrics:metrics
																	 views:views];
	[self addConstraints:constraints];
	
	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[subview]-bottom-|"
														  options:0
														  metrics:metrics
															views:views];
	
	[self addConstraints:constraints];
}


#pragma mark -

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
