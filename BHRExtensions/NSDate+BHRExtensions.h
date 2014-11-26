//
//  NSDate+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BHRExtensions)

- (NSString *)shortDateAndTimeString;

+ (NSDate *)today;
+ (NSDate *)yesterday;
+ (NSDate *)thisWeek;
+ (NSDate *)lastWeek;
+ (NSDate *)last7Days;
+ (NSDate *)thisMonth;
+ (NSDate *)lastMonth;

/**
 *	Returns the date in XML conform string format, e.g. 2010-11-26T07:35:55.000000Z
 */
- (NSString *)ISO8601FRACXMLString;

/**
 * Takes an XML date string and converts it to NSDate
 */
+ (NSDate *)dateWithISO8601FRACXMLString:(NSString *)XMLString;

@end
