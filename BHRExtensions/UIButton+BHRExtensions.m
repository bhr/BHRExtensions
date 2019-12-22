//
//  UIButton+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/18/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIButton+BHRExtensions.h"

@implementation UIButton (BHRExtensions)

- (void)setRoundedBorder:(CGFloat)radius
			 borderWidth:(CGFloat)borderWidth
				   color:(UIColor *)color
{
    CALayer * l = [self layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:radius];
    // You can even add a border
    [l setBorderWidth:borderWidth];
    [l setBorderColor:[color CGColor]];
}

@end
