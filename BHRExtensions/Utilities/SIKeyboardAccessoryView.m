//
//  SIShellAccessoryViewController.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIKeyboardAccessoryView.h"
#import "UIColor+BHRExtensions.h"

NSString * const SIShellButtonInfoTitle = @"title";
NSString * const SIShellButtonInfoType = @"type";
NSString * const SIShellButtonInfoID = @"identifier";

@interface SIKeyboardAccessoryView ()

@property (nonatomic, strong) NSArray *buttons;

@end

@implementation SIKeyboardAccessoryView

- (instancetype)initWithInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 32.0f)];

	if (self)
	{
		_interfaceStyle = interfaceStyle;
		[self _sharedInit];
	}
	return self;
}


- (void)_sharedInit
{
	NSMutableArray *buttons = [@[] mutableCopy];


	NSMutableDictionary *viewsDict = [@{} mutableCopy];
	UIView *referenceView = nil;
	NSArray *buttonsInfo = [self buttonsInfo];
	CGFloat itemSpace = [self itemSpace];

	NSMutableString *horizontalFormatString = [NSMutableString stringWithFormat:@"H:|-%f-",itemSpace];

	for (NSDictionary *buttonDictionary in buttonsInfo)
	{
		NSString *buttonTitle = [buttonDictionary objectForKey:SIShellButtonInfoTitle];
		NSString *buttonID = [buttonDictionary objectForKey:SIShellButtonInfoID];

		//if no id was given use title as ID
		if (buttonID == nil)
		{
			buttonID = buttonTitle;
		}

		//view creation
		SIKeyboardButtonView *button = [[SIKeyboardButtonView alloc] initWithInterfaceStyle:self.interfaceStyle];
		button.title = buttonTitle;
		button.delegate = self;
		button.restorationIdentifier = buttonID;

		[buttons addObject:button];
		[self addSubview:button];

		//constraints
		if (referenceView == nil)
		{
			referenceView = button;
		}

		[viewsDict setObject:button
					  forKey:button.restorationIdentifier];

		if ([buttonID isEqualToString:[self separatorID]])
		{
			[horizontalFormatString appendFormat:@"[%@]-(>=%f)-", button.restorationIdentifier, itemSpace];
		}
		else
		{
			[horizontalFormatString appendFormat:@"[%@]-%f-", button.restorationIdentifier, itemSpace];
		}

	}

	[horizontalFormatString appendFormat:@"|"];

	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormatString
																 options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop
																 metrics:nil
																   views:viewsDict]];

	[self addConstraint:[NSLayoutConstraint constraintWithItem:referenceView
													 attribute:NSLayoutAttributeCenterY
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeCenterY
													multiplier:1.0f
													  constant:0.0f]];

	[self addConstraint:[NSLayoutConstraint constraintWithItem:referenceView
													 attribute:NSLayoutAttributeHeight
													 relatedBy:NSLayoutRelationEqual
														toItem:self
													 attribute:NSLayoutAttributeHeight
													multiplier:0.9f
													  constant:0.0f]];

	self.buttons = buttons;
	[self _updateColors];
}

- (void)_updateColors
{
	for (SIKeyboardButtonView *button in self.buttons)
	{
		button.interfaceStyle = self.interfaceStyle;
	}
	
	switch (self.interfaceStyle) {
		case UIUserInterfaceStyleDark:
		{
			self.backgroundColor = [UIColor darkKeyboardBackgroundColor];
		}
			break;
		case UIUserInterfaceStyleLight:
		case UIUserInterfaceStyleUnspecified:
		{
			self.backgroundColor = [UIColor keyboardBackgroundColor];
		}
			break;
	}
}

- (void)setInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle
{
	if (_interfaceStyle != interfaceStyle)
	{
		_interfaceStyle = interfaceStyle;
		[self _updateColors];
	}
}

#pragma mark - Actions

- (void)sendButtonWithType:(SIShellAccessoryButton)buttonType
{
	if ([self.delegate respondsToSelector:@selector(shellAccessoryView:didPressButton:)])
	{
		[self.delegate shellAccessoryView:self
									 didPressButton:buttonType];
	}
}

#pragma mark - KeyboardbuttonDelegate

- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;
{
	NSInteger tappedButtonIndex = [self.buttons indexOfObject:buttonView];
	NSDictionary *buttonInfo = [[self buttonsInfo] objectAtIndex:tappedButtonIndex];

	SIShellAccessoryButton buttonType = [[buttonInfo objectForKey:SIShellButtonInfoType] integerValue];

	[self sendButtonWithType:buttonType];
}

- (NSArray *)buttonsInfo
{
	return nil;
}

- (NSString *)separatorID
{
	return nil;
}

- (CGFloat)itemSpace
{
	return 2.0f;
}

@end


