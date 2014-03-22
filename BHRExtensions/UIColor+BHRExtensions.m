//
//  UIColor+BHRExtensions.m
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIColor+BHRExtensions.h"

@implementation UIColor (BHRExtensions)

- (UIColor *)colorByAddingBrightness:(CGFloat)brightnessOffset
{
	CGFloat hue = 0.0f;
	CGFloat saturation = 0.0f;
	CGFloat brightness = 0.0f;
	CGFloat alpha = 0.0f;
	
	BOOL succeeded = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	if (succeeded)
	{
		brightness += brightnessOffset;
		
		return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}
	
	CGFloat white = 0.0f;
	
	succeeded = [self getWhite:&white alpha:&alpha];
	
	if (succeeded)
	{
		white += brightnessOffset;
		
		return [UIColor colorWithWhite:white alpha:alpha];
	}
	
	return nil;
}

- (UIColor *)colorByAddingAlpha:(CGFloat)alphaOffset
{
	CGFloat hue = 0.0f;
	CGFloat saturation = 0.0f;
	CGFloat brightness = 0.0f;
	CGFloat alpha = 0.0f;
	
	BOOL succeeded = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
	
	if (succeeded)
	{
		alpha += alphaOffset;
		
		return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
	}
	
	CGFloat white = 0.0f;
	
	succeeded = [self getWhite:&white alpha:&alpha];
	
	if (succeeded)
	{
		alpha += alphaOffset;
		
		return [UIColor colorWithWhite:white alpha:alpha];
	}
	
	return nil;
}

+ (UIColor*)defaultSystemTintColor
{
	static UIColor* systemTintColor = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		UIView* view = [[UIView alloc] init];
		systemTintColor = view.tintColor;
	});
	return systemTintColor;
}

+ (UIColor *)keyboardBackgroundColor
{
	return [UIColor colorWithHue:0.600 saturation:0.029 brightness:0.887 alpha:1.000];
}

- (BOOL)isWhiteColor
{
	CGFloat white = 0.f;
	CGFloat alpha = 0.f;
	BOOL success = [self getWhite:&white alpha:&alpha];
	
	if (success &&
		white == 1.0f &&
		alpha == 1.0f)
	{
		return YES;
	}
	return NO;
}

@end
