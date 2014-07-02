//
//  PIMHostCellColorizer.m
//  PIMonitor
//
//  Created by Benedikt Hirmer on 5/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRTableViewCellColorizer.h"

@implementation BHRTableViewCellColorizer

- (void)colorizeCell:(UITableViewCell *)cell
{
	if (self.selectionColor)
	{
		UIView * selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
		selectedBackgroundView.backgroundColor = self.selectionColor;
		cell.selectedBackgroundView = selectedBackgroundView;
	}

	if (self.textColor)
	{
		cell.textLabel.textColor = self.textColor;
	}

	for (UITextField *textField in [cell.contentView subviews])
	{
		if ([textField respondsToSelector:@selector(textColor)])
		{
			if (!textField.enabled && self.disabledTextColor) {
				textField.textColor = self.disabledTextColor;
			}
			else if (self.textColor) {
				textField.textColor = self.textColor;
			}
		}

		if ([textField isKindOfClass:[UITextField class]])
		{
			if ([textField respondsToSelector:@selector(placeholder)] &&
				self.placeholderColor)
			{
				NSString *placeholderString = textField.placeholder;

				if (!placeholderString) {
					placeholderString = @"";
				}

				NSDictionary *placeholderAttributes = @{ NSFontAttributeName: textField.font,
														 NSForegroundColorAttributeName: self.placeholderColor };
				NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:placeholderString
																				  attributes:placeholderAttributes];
				[textField setAttributedPlaceholder:placeholder];
			}
		}

		if (self.backgroundColor)
		{
			textField.backgroundColor = self.backgroundColor;
		}
	}

	if (self.backgroundColor)
	{
		UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
		backgroundView.backgroundColor = self.backgroundColor;
		cell.backgroundView = backgroundView;
		cell.backgroundColor = self.backgroundColor;
	}
}

@end
