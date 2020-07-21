//
//  NSMutableAttributedString+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/25/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSMutableAttributedString+BHRExtensions.h"

@implementation NSMutableAttributedString (BHRExtensions)

- (void)bhr_deleteAllOccurrencesOfString:(NSString *)string
{
	[self bhr_replaceOccurrencesOfString:string withString:@""];
}


- (void)bhr_replaceOccurrencesOfString:(NSString *)string withString:(NSString *)replacementString
{
	NSRange searchStringRange;
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
