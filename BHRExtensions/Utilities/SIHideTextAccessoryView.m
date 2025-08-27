//
//  SICommandDetailCommandAccessoryViewController.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/2/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIHideTextAccessoryView.h"

@interface SIHideTextAccessoryView ()

@end

@implementation SIHideTextAccessoryView


- (NSArray *)buttonsInfo
{
	NSString *titleKey = SIShellButtonInfoTitle;
	NSString *typeKey = SIShellButtonInfoType;
	
    return @[
        @{
            titleKey: [self separatorID],
            typeKey: @(SIShellAccessoryButtonNone),
        },
        @{
            titleKey: NSLocalizedStringFromTable(@"hide", @"BHRExtensionsLocalizable", @"KeyboardAccessoryViewButtonTitleHide"),
            typeKey: @(SIShellAccessoryButtonHideKeyboard),
        },
    ];
    
}

- (NSString *)separatorID
{
	return @"none";
}

@end
