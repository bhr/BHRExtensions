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
@property (nonatomic, assign) UIKeyboardAppearance appearance;

@end

@implementation SIKeyboardAccessoryView

- (instancetype)initWithKeyboardAppearance:(UIKeyboardAppearance)appearance
{
	self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 32.0f)];

	if (self)
	{
		_appearance = appearance;
		[self _sharedInit];
	}
	return self;
}


- (void)_sharedInit
{
	if (self.appearance == UIKeyboardAppearanceDark)
	{
		self.backgroundColor = [UIColor darkKeyboardBackgroundColor];
	}
	else
	{
		self.backgroundColor = [UIColor keyboardBackgroundColor];
	}

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
		SIKeyboardButtonView *button = [[SIKeyboardButtonView alloc] initWithAppearance:self.appearance];
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


