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
	
	return @[
		@{
			titleKey: NSLocalizedString(@"esc", nil),
			typeKey: @(SIShellAccessoryButtonEsc),
		},
		@{
			titleKey: NSLocalizedString(@"tab", nil),
			typeKey: @(SIShellAccessoryButtonTab),
		},
		@{
			titleKey: NSLocalizedString(@"ctrl", nil),
			typeKey: @(SIShellAccessoryButtonControl),
		},
		@{
			titleKey: NSLocalizedString(@"fn", nil),
			typeKey: @(SIShellAccessoryButtonFn),
		},
		@{
			titleKey: NSLocalizedString(@"/", nil),
			identifierKey: @"slash",
			typeKey: @(SIShellAccessoryButtonSlash),
		},
		@{
			titleKey: NSLocalizedString(@";", nil),
			identifierKey: @"semicolon",
			typeKey: @(SIShellAccessoryButtonSemiColon),
		},
		@{
			titleKey: NSLocalizedString(@"▲", nil),
			identifierKey: @"up",
			typeKey: @(SIShellAccessoryButtonArrowUp),
		},
		@{
			titleKey: NSLocalizedString(@"▼", nil),
			identifierKey: @"down",
			typeKey: @(SIShellAccessoryButtonArrowDown),
		},
		@{
			titleKey: NSLocalizedString(@"◀", nil),
			identifierKey: @"left",
			typeKey: @(SIShellAccessoryButtonArrowLeft),
		},
		@{
			titleKey: NSLocalizedString(@"▶", nil),
			identifierKey: @"right",
			typeKey: @(SIShellAccessoryButtonArrowRight),
		},
	];
	
}

#pragma mark - 

- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;
{
	NSInteger tappedButtonIndex = [self.buttons indexOfObject:buttonView];
	NSDictionary *buttonInfo = [[self buttonsInfo] objectAtIndex:tappedButtonIndex];
	
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
	
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
	
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
