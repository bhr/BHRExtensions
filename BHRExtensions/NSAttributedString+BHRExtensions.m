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
	
	
	[self enumerateAttributesInRange:NSMakeRange(0, self.length)
										 options:0
									  usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
	 {
		 NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];

		 UIColor *textColor = newTextAttributes[NSForegroundColorAttributeName];

		 if (textColor == nil ||
			 [textColor isEqualToColor:existingColor])
		 {
			 textColor = newColor;
			 newTextAttributes[NSForegroundColorAttributeName] = textColor;
		 }

         NSString *string = [self string];

         //adjust length if strings length is less than range
         //note: this shouldn't happen but did happen, so we resolve it manually
         if (NSMaxRange(range) > [string length])
         {
             range.length -= (NSMaxRange(range) - [string length]);
         }

		 NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[string substringWithRange:range]
																								 attributes:newTextAttributes];
		 [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

	 }];

	return [adjustedAttributedString copy];
}


- (NSAttributedString *)stringbyReplacingFontWithFont:(UIFont *)newFont
{
	NSMutableAttributedString *adjustedAttributedString = [[NSMutableAttributedString alloc] init];

	[self enumerateAttributesInRange:NSMakeRange(0, [[self string] length])
							 options:0
						  usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
	 {
		 NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];

		 UIFont *currentFont = newTextAttributes[NSFontAttributeName];

		 if (currentFont == nil)
		 {
			 currentFont = newFont;
			 newTextAttributes[NSFontAttributeName] = currentFont;
		 }

		 NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[[self string] substringWithRange:range]
																								 attributes:newTextAttributes];
		 [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

	 }];

	return [adjustedAttributedString copy];
}

@end
