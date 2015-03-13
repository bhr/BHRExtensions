//
//  UIView+BHROrientation.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/15.
//  Copyright (c) 2015 HIRMER.me. All rights reserved.
//

#import "UIView+BHROrientation.h"

@implementation UIView (BHROrientation)

+ (ViewOrientation)viewOrientationForSize:(CGSize)size {
    return (size.width > size.height) ? ViewOrientationLandscape : ViewOrientationPortrait;
}

- (ViewOrientation)viewOrientation {
    return [[self class] viewOrientationForSize:self.bounds.size];
}

- (BOOL)isViewOrientationPortrait {
    return [self viewOrientation] == ViewOrientationPortrait;
}

- (BOOL)isViewOrientationLandscape {
    return [self viewOrientation] == ViewOrientationLandscape;
}

@end
