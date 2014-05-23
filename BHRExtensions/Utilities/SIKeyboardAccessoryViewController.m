//
//  SIShellAccessoryViewController.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIKeyboardAccessoryViewController.h"
#import "UIColor+BHRExtensions.h"

NSString * const SIShellButtonInfoTitle = @"title";
NSString * const SIShellButtonInfoType = @"type";
NSString * const SIShellButtonInfoID = @"identifier";

@interface SIKeyboardAccessoryViewController ()

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, assign) UIKeyboardAppearance appearance;

@end

@implementation SIKeyboardAccessoryViewController

- (instancetype)initWithKeyboardAppearance:(UIKeyboardAppearance)appearance
{
    self = [super init];
    if (self)
	{
		_appearance = appearance;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	self.view.frame = CGRectMake(0.0f, 0.0f, 320.0f, 32.0f);

	if (self.appearance == UIKeyboardAppearanceDark)
	{
		self.view.backgroundColor = [UIColor darkKeyboardBackgroundColor];
	}
	else
	{
		self.view.backgroundColor = [UIColor keyboardBackgroundColor];
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
		[self.view addSubview:button];
		
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
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormatString
																	  options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop
																	  metrics:nil
																		views:viewsDict]];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:referenceView
														  attribute:NSLayoutAttributeCenterY
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterY
														 multiplier:1.0f
														   constant:0.0f]];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:referenceView
														  attribute:NSLayoutAttributeHeight
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeHeight
														 multiplier:0.9f
														   constant:0.0f]];
	
	self.buttons = buttons;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)sendButtonWithType:(SIShellAccessoryButton)buttonType
{
	if ([self.delegate respondsToSelector:@selector(shellAccessoryViewController:didPressButton:)])
	{
		[self.delegate shellAccessoryViewController:self
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


