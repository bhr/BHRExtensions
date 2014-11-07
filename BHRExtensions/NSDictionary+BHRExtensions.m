//
//  NSDictionary+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 11/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSDictionary+BHRExtensions.h"

@implementation NSDictionary (BHRExtensions)

- (NSString *)urlEncodedParameters
{
	NSMutableString *encodedParameters = [NSMutableString string];
	NSString *currentObject;
	NSString *currentKey;
	NSUInteger index = 0;

	for (NSString *oneKey in self)
	{
		currentObject = [self[oneKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		currentKey = [oneKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

		if (index > 0)
		{
			[encodedParameters appendString:@"&"];
		}

		[encodedParameters appendFormat:@"%@=%@",currentKey,currentObject];
		index++;
	}

	return [NSString stringWithString:encodedParameters];
}

@end
