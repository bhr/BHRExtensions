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
#import "UIViewController+BHRExtensions.h"

@implementation BHRCoreDataErrorManager


#pragma mark - Actions

- (void)showErrorAlert
{
	dispatch_async(dispatch_get_main_queue(), ^{
		NSString *title = NSLocalizedString(@"Unresolved error!", nil);
		NSString *message = NSLocalizedString(@"An unresolved error occurred when trying to save your changes. \n\nPlease restart the app and try again.", nil);
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
		
		NSString *actionTitle = [NSString stringWithFormat:NSLocalizedString(@"Quit %@", nil), [UIApplication appName]];
		[alertController addAction:[UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			abort();
		}]];
		
		[UIViewController.topViewController presentViewController:alertController animated:YES completion:nil];
	});
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
