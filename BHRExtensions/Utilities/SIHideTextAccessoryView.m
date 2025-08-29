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
	
    // Return grouped buttons - first group is empty (flexible space), second group contains the hide button
    return @[
        // Group 1: Empty group for flexible space (binds hide button to the right)
        @[],
        // Group 2: Hide button
        @[
            @{
                titleKey: NSLocalizedStringFromTable(@"hide", @"BHRExtensionsLocalizable", @"KeyboardAccessoryViewButtonTitleHide"),
                typeKey: @(SIShellAccessoryButtonHideKeyboard),
            },
        ],
    ];
    
}

- (NSString *)separatorID
{
	return @"none";
}

@end
