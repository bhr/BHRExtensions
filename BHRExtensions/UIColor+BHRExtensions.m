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

@end
