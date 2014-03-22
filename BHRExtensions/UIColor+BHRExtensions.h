//
//  UIColor+BHRExtensions.h
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BHRExtensions)

- (UIColor *)colorByAddingBrightness:(CGFloat)brightnessOffset;
- (UIColor *)colorByAddingAlpha:(CGFloat)alphaOffset;

+ (UIColor *)defaultSystemTintColor;
+ (UIColor *)keyboardBackgroundColor;

- (BOOL)isWhiteColor;

@end
