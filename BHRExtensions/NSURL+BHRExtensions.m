//
//  NSURL+BHRExtensions.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/20/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSURL+BHRExtensions.h"

@implementation NSURL (BHRExtensions)

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
+ (NSURL *)bhr_applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 Returns the AppSupportFolder
 */
+ (NSURL *)bhr_applicationSupportDirectory
{
	NSString *applicationSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,
																				 NSUserDomainMask,
																				 YES) objectAtIndex:0];
	BOOL isDir = NO;
	NSError *error = nil;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
	if (![fileManager fileExistsAtPath:applicationSupportDirectory
                           isDirectory:&isDir] && isDir == NO) {
		[fileManager createDirectoryAtPath:applicationSupportDirectory
               withIntermediateDirectories:NO
                                attributes:nil
                                     error:&error];
	}
    return [NSURL fileURLWithPath:applicationSupportDirectory];
}

@end
