//
//  BHRSmallTitleTextFieldTableCell.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 10/21/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRSmallTitleAndValueTableCell.h"

NSString * const BHRSmallTitleAndValueTableCellReuseID = @"BHRSmallTitleAndValueTableCell";

@implementation BHRSmallTitleAndValueTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self)
	{
		[self _setUpConstraints];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		[self _setUpConstraints];
	}
	return self;
}

- (void)_setUpConstraints
{
	NSDictionary *viewsDict = @{ @"label": self.titleLabel,
								 @"valueTextField": self.valueTextField };

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[valueTextField]-20-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=4)-[label]-0-[valueTextField]-(>=8)-|"
																			 options:NSLayoutFormatAlignAllLeading
																			 metrics:nil
																			   views:viewsDict]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];

	if (selected)
	{
		[self.valueTextField becomeFirstResponder];
	}

}

#pragma mark -

- (UITextField *)valueTextField
{
	if (!_valueTextField)
	{
		_valueTextField = [[UITextField alloc] initWithFrame:CGRectZero];
		_valueTextField.translatesAutoresizingMaskIntoConstraints = NO;

		_valueTextField.autocorrectionType = UITextAutocorrectionTypeNo;
		_valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_valueTextField.textAlignment = NSTextAlignmentLeft;
		_valueTextField.textColor = UIColor.labelColor;
		
		[self.contentView addSubview:_valueTextField];
	}

	return _valueTextField;
}

- (UILabel *)titleLabel
{
	if (!_titleLabel)
	{
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_titleLabel.font = [UIFont systemFontOfSize:11.0f];
		_titleLabel.textColor = UIColor.secondaryLabelColor;
		
		[self.contentView addSubview:_titleLabel];
	}

	return _titleLabel;
}

@end
