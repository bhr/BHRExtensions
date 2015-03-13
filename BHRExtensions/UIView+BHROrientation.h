//
//  UIView+BHROrientation.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/15.
//  Copyright (c) 2015 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

// These macros should only be used if you MUST know the interface orientation for the device itself, for example when displaying a new UIWindow.
// This should be very rare; generally you should only look at the immediate parent view's size (or "view orientation" using the category below).
#define StatusBarOrientationIsPortrait      UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])
#define StatusBarOrientationIsLandscape     UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])

typedef NS_ENUM(NSUInteger, BHRViewOrientation) {
    BHRViewOrientationPortrait,
    BHRViewOrientationLandscape
};


@interface UIView (BHROrientation)

/** Returns the "orientation" of size. width > height is considered "landscape", otherwise "portrait" */
+ (BHRViewOrientation)orientationForSize:(CGSize)size;

/** Returns the "orientation" of a view based on its size. width > height is considered "landscape", otherwise "portrait" */
- (BHRViewOrientation)orientation;

/** Returns YES if height >= width */
- (BOOL)isPortraitOrienation;

/** Returns YES if width > height */
- (BOOL)isLandscapeOrienation;

@end


