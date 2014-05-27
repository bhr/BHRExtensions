//
//  SICommandDetailCommandAccessoryViewController.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/2/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIHideTextAccessoryViewController.h"

@interface SIHideTextAccessoryViewController ()

@end

@implementation SIHideTextAccessoryViewController


- (NSArray *)buttonsInfo
{
	NSString *titleKey = SIShellButtonInfoTitle;
	NSString *typeKey = SIShellButtonInfoType;
	
	return @[
			 @{
				 titleKey: [self separatorID],
				 typeKey: @(SIShellAccessoryButtonHideKeyboard),
				 },
			 ];
	
}

- (NSString *)separatorID
{
	return NSLocalizedStringFromTable(@"hide", @"BHRExtensionsLocalizable", nil);
}

@end
