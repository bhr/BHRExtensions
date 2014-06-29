//
//  NSAttributedString+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/29/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSAttributedString+BHRExtensions.h"
#import "UIColor+BHRExtensions.h"

@implementation NSAttributedString (BHRExtensions)

- (NSAttributedString *)stringbyReplacingTextColor:(UIColor *)existingColor
										 withColor:(UIColor *)newColor
{
	NSMutableAttributedString *adjustedAttributedString = [[NSMutableAttributedString alloc] init];

	[self enumerateAttributesInRange:NSMakeRange(0, [[self string] length])
										 options:0
									  usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
	 {
		 NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];

		 UIColor *textColor = [newTextAttributes objectForKey:NSForegroundColorAttributeName];

		 if ([textColor isEqualToColor:existingColor])
		 {
			 textColor = newColor;
			 [newTextAttributes setObject:textColor forKey:NSForegroundColorAttributeName];
		 }

		 NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[[self string] substringWithRange:range]
																								 attributes:newTextAttributes];
		 [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

	 }];

	return [adjustedAttributedString copy];
}

@end
