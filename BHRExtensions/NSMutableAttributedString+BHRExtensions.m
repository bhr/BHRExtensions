//
//  NSMutableAttributedString+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/25/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSMutableAttributedString+BHRExtensions.h"

@implementation NSMutableAttributedString (BHRExtensions)

- (void)deleteAllOccurrencesOfString:(NSString *)string
{
	[self replaceOccurrencesOfString:string withString:nil];
}


- (void)replaceOccurrencesOfString:(NSString *)string withString:(NSString *)replacementString
{
	if (replacementString == nil)
	{
		replacementString = @"";
	}

	NSRange searchStringRange;

	if (string == nil)
	{
		return;
	}

	do
	{
		searchStringRange = [[self string] rangeOfString:string];

		if (searchStringRange.location != NSNotFound)
		{
			[self replaceCharactersInRange:searchStringRange
								withString:replacementString];
		}
	}
	while (searchStringRange.location != NSNotFound);
}

@end
