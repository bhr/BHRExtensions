//
//  SIShellAccessoryView.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/22/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIShellAccessoryView.h"

@interface SIKeyboardAccessoryView ()

@property (nonatomic, strong) NSArray *buttons;

@end

@interface SIShellAccessoryView ()

@property (nonatomic, strong) SIKeyboardButtonView *controlButtonView;

@end

@implementation SIShellAccessoryView

- (NSArray *)buttonsInfo
{
	NSString *titleKey = SIShellButtonInfoTitle;
	NSString *typeKey = SIShellButtonInfoType;
	NSString *identifierKey = SIShellButtonInfoID;
	
	// Return grouped buttons - each group is an array of button dictionaries
	return @[
		// Group 1: Control keys
		@[
			@{
				titleKey: NSLocalizedString(@"esc", @"KeyboardAccessoryViewButtonTitleEscapeKey"),
				typeKey: @(SIShellAccessoryButtonEsc),
			},
			@{
				titleKey: NSLocalizedString(@"tab", @"KeyboardAccessoryViewButtonTitleTabKey"),
				typeKey: @(SIShellAccessoryButtonTab),
			},
			@{
				titleKey: NSLocalizedString(@"ctrl", @"KeyboardAccessoryViewButtonTitleControlKey"),
				typeKey: @(SIShellAccessoryButtonControl),
			},
			@{
				titleKey: NSLocalizedString(@"fn", @"KeyboardAccessoryViewButtonTitleFunctionKey"),
				typeKey: @(SIShellAccessoryButtonFn),
			},
		],
		// Group 2: Punctuation
		@[
			@{
				titleKey: @"/",
				identifierKey: @"slash",
				typeKey: @(SIShellAccessoryButtonSlash),
			},
			@{
				titleKey: @";",
				identifierKey: @"semicolon",
				typeKey: @(SIShellAccessoryButtonSemiColon),
			},
		],
		// Group 3: Arrow keys
		@[
			@{
				titleKey: @"▲",
				identifierKey: @"up",
				typeKey: @(SIShellAccessoryButtonArrowUp),
			},
			@{
				titleKey: @"▼",
				identifierKey: @"down",
				typeKey: @(SIShellAccessoryButtonArrowDown),
			},
			@{
				titleKey: @"◀",
				identifierKey: @"left",
				typeKey: @(SIShellAccessoryButtonArrowLeft),
			},
			@{
				titleKey: @"▶",
				identifierKey: @"right",
				typeKey: @(SIShellAccessoryButtonArrowRight),
			},
		],
	];
}

- (SIKeyboardButtonView *)_createButtonFromDictionary:(NSDictionary *)buttonDictionary
{
    NSString *buttonTitle = [buttonDictionary objectForKey:SIShellButtonInfoTitle];
    NSString *buttonID = [buttonDictionary objectForKey:SIShellButtonInfoID];
    SIShellAccessoryButton buttonType = [[buttonDictionary objectForKey:SIShellButtonInfoType] unsignedIntegerValue];
    
    // skip "none" button
    if (buttonType == SIShellAccessoryButtonNone) {
        return nil;
    }
    
    //if no id was given use title as ID
    if (buttonID == nil) {
        buttonID = buttonTitle;
    }
    
    //view creation
    SIKeyboardButtonView *button = [[SIKeyboardButtonView alloc] initWithInterfaceStyle:self.interfaceStyle];
    button.title = buttonTitle;
    button.delegate = self;
    button.restorationIdentifier = buttonID;
    
    // Store reference to control button for special handling
    if (buttonType == SIShellAccessoryButtonControl) {
        self.controlButtonView = button;
    }
    
    return button;
}

#pragma mark - 

- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;
{
	// Find the button info by searching through all groups
	NSArray *buttonGroups = [self buttonsInfo];
	NSDictionary *buttonInfo = nil;
	
	for (NSArray *group in buttonGroups) {
		for (NSDictionary *info in group) {
			NSString *buttonTitle = [info objectForKey:SIShellButtonInfoTitle];
			NSString *buttonID = [info objectForKey:SIShellButtonInfoID];
			
			if (buttonID == nil) {
				buttonID = buttonTitle;
			}
			
			if ([buttonID isEqualToString:buttonView.restorationIdentifier]) {
				buttonInfo = info;
				break;
			}
		}
        if (buttonInfo) {
            break;
        }
	}
	
    if (!buttonInfo) {
        return;
    }
	
	SIShellAccessoryButton buttonType = [[buttonInfo objectForKey:SIShellButtonInfoType] integerValue];
	
	if (buttonType == SIShellAccessoryButtonControl ||
		buttonType == SIShellAccessoryButtonFn)
	{
		if (buttonType == SIShellAccessoryButtonControl) {
			self.controlButtonView = buttonView;
		}
		
		buttonView.selected = !buttonView.selected;
	}
	if (buttonType == SIShellAccessoryButtonFn)
	{
		[self _updateFunctionKeysViewWithButtonView:buttonView];
	}
	else
	{
		[self sendButtonWithType:buttonType];
	}
}

- (void)_updateFunctionKeysViewWithButtonView:(SIKeyboardButtonView *)fnButtonView
{
	if (fnButtonView.selected == NO)
	{
		return;
	}
	
	fnButtonView.selected = NO;
	
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	for (NSInteger idx = 1; idx < 13; idx++)
	{
		NSString *string = [NSString stringWithFormat:NSLocalizedString(@"F%ld", "FButtonTitle"), (long)idx];
		[alertController addAction:[UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
			[self _fnButtonWithIndex:idx];
		}]];
	}
	
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"CancelButtonTitle") style:UIAlertActionStyleCancel handler:nil]];
	
	alertController.popoverPresentationController.sourceView = fnButtonView;
	alertController.popoverPresentationController.sourceRect = fnButtonView.bounds;
	
	UIViewController *viewController = nil;
	if ([self.delegate respondsToSelector:@selector(viewControllerForAlertAccessoryView:)])
	{
		viewController = [self.delegate viewControllerForAlertAccessoryView:self];
	}
	[viewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - ActionSheetDelegate

- (SIShellAccessoryButton)_fnButtonWithIndex:(NSInteger)index
{
	return 1000 + index;
}

- (NSString *)separatorID
{
	return @"semicolon";
}

- (void)deselectControlButtonView;
{
	self.controlButtonView.selected = NO;
}

@end
