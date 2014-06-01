//
//  BHRCoreDataErrorManager.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/1/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRCoreDataErrorManager.h"
#import <UIKit/UIKit.h>
#import "UIApplication+BHRVersionInfo.h"

@implementation BHRCoreDataErrorManager


#pragma mark - Actions

- (void)showErrorAlert
{
	dispatch_async(dispatch_get_main_queue(), ^
				   {
					   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Unresolved error!", nil)
																	   message:NSLocalizedString(@"An unresolved error occurred when trying to save your changes. \n\nPlease restart the app and try again.", nil)
																	  delegate:self
															 cancelButtonTitle:[NSString stringWithFormat:NSLocalizedString(@"Quit %@", nil), [UIApplication appName]]
															 otherButtonTitles:nil];
					   [alert show];
				   });
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([[alertView title] isEqualToString:NSLocalizedString(@"Unresolved error!", nil)])
	{
		abort();
	}
}


#pragma mark - Singleton

static BHRCoreDataErrorManager *sharedManager = nil;

+ (BHRCoreDataErrorManager *)sharedManager
{
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		sharedManager = [[self alloc] init];
	});

	return sharedManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
        if (sharedManager == nil) {
            return [super allocWithZone:zone];
        }
    }

    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
