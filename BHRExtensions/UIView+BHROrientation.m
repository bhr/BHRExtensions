//
//  UIView+BHROrientation.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/15.
//  Copyright (c) 2015 HIRMER.me. All rights reserved.
//

#import "UIView+BHROrientation.h"

@implementation UIView (BHROrientation)

+ (BHRViewOrientation)orientationForSize:(CGSize)size {
    return (size.width > size.height) ? BHRViewOrientationLandscape : BHRViewOrientationPortrait;
}

- (BHRViewOrientation)orientation {
    return [[self class] orientationForSize:self.bounds.size];
}

- (BOOL)isPortraitOrienation {
    return [self orientation] == BHRViewOrientationPortrait;
}

- (BOOL)isLandscapeOrienation {
    return [self orientation] == BHRViewOrientationLandscape;
}

@end
