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

    [self _colorizeView:cell];


    if (self.contentTextColor)
    {
        cell.textLabel.textColor = self.contentTextColor;
        cell.detailTextLabel.textColor = self.contentTextColor;
    }

    if (self.labelTextColor)
    {
        cell.detailTextLabel.textColor = self.labelTextColor;
    }

	if (self.backgroundColor)
	{
		UIView *backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
		backgroundView.backgroundColor = self.backgroundColor;
		cell.backgroundView = backgroundView;
		cell.backgroundColor = self.backgroundColor;
	}
}

- (void)_colorizeView:(UIView *)view
{
    for (UITextField *textField in [view subviews])
    {
        if ([self.ignoredClasses containsObject:[textField class]])
        {
            continue;
        }
        
        if ([textField respondsToSelector:@selector(textColor)])
        {
            NSString *restorationIdentifier = textField.restorationIdentifier;
            BOOL useLabelColor = [[restorationIdentifier lowercaseString] containsString:@"labelcolor"];
            if (!textField.enabled && self.disabledTextColor) {
                textField.textColor = self.disabledTextColor;
            }
            else if (useLabelColor && self.labelTextColor) {
                textField.textColor = self.labelTextColor;
            }
            else if (self.contentTextColor) {
                textField.textColor = self.contentTextColor;
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

        if ([textField isKindOfClass:[UITextView class]] && self.backgroundColor)
        {
            UITextView *textView = (UITextView *)textField;
            textView.backgroundColor = self.backgroundColor;
        }

        //going recursively into UITextFields leads to wrong coloring of placeholders after cells reload
        if (![textField isKindOfClass:[UITextField class]] && ![textField isKindOfClass:[UITextView class]])
        {
            //recursive call
            [self _colorizeView:textField];
        }
    }
}

@end
