//
//  UIButton+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/18/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BHRExtensions)

- (void)setRoundedBorder:(CGFloat)radius
			 borderWidth:(CGFloat)borderWidth
				   color:(UIColor *)color;

@end
