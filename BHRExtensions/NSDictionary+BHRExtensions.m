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
        id value = self[oneKey];

        if ([value isKindOfClass:[NSArray class]])
        {
            NSString *arrayString = [(NSArray *)value componentsJoinedByString:@","];
            value = [arrayString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        else if ([value isKindOfClass:[NSDictionary class]])
        {
            NSMutableString *valueString = [NSMutableString string];

            [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop)
            {
                 [valueString appendString:[NSString stringWithFormat:@"%@+%@,", key, obj]];
            }];

            if ([valueString length] > 0)
            {
                [valueString deleteCharactersInRange:NSMakeRange([valueString length] - 1, 1)];
            }

            value = valueString;
        }

        currentObject = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
