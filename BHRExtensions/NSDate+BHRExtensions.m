//
//  NSDate+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSDate+BHRExtensions.h"

@implementation NSDate (BHRExtensions)

- (NSString *)shortDateAndTimeString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	dateFormatter.dateStyle = NSDateFormatterShortStyle;
	dateFormatter.timeStyle = NSDateFormatterShortStyle;
	
	return [dateFormatter stringFromDate:self];
}

@end
