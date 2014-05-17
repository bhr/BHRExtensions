//
//  SICommandDetailCommandCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRScriptTextCell.h"

NSString * const BHRScriptTextCellReuseID = @"scriptTextCell";

@interface BHRScriptTextCell ()

@end

@implementation BHRScriptTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		[self _setUpConstraints];
    }
    return self;
}

- (void)_setUpConstraints
{
	NSDictionary *viewsDict = @{ @"placeholder": self.placeholderLabel ,
								 @"textView": self.textView };

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[textView]-8-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textView]-8-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[placeholder]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[placeholder]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

	if (selected)
	{
	    [self.textView becomeFirstResponder];
	}
}


- (UILabel *)placeholderLabel
{
	if (!_placeholderLabel)
	{
		_placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;

		_placeholderLabel.font = [UIFont fontWithName:@"Menlo-Italic" size:14.0f];
		_placeholderLabel.textColor = [UIColor lightGrayColor];

		[self.contentView addSubview:_placeholderLabel];
	}
	return _placeholderLabel;
}

- (UITextView *)textView
{
	if (!_textView)
	{
		_textView = [[UITextView alloc] initWithFrame:CGRectZero];
		_textView.translatesAutoresizingMaskIntoConstraints = NO;

		_textView.backgroundColor = [UIColor clearColor];
		_textView.font = [UIFont fontWithName:@"Menlo" size:14.0f];
		_textView.editable = YES;
		_textView.selectable = YES;
		_textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_textView.autocorrectionType = UITextAutocorrectionTypeNo;

		[self.contentView addSubview:_textView];
	}
	return _textView;
}

@end
