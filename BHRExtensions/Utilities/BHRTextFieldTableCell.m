//
//  SIHostDetailNameCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRTextFieldTableCell.h"

NSString * const BHRTextFieldTableCellReuseID = @"BHRTextFieldTableCell";


@implementation BHRTextFieldTableCell

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
	[[self.textField.leftAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leftAnchor] setActive:YES];
	[[self.contentView.layoutMarginsGuide.rightAnchor constraintEqualToAnchor:self.textField.rightAnchor] setActive:YES];
	
	[[self.textField.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
	[[self.textField.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor] setActive:YES];
	[[self.contentView.layoutMarginsGuide.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.textField.bottomAnchor] setActive:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

	if (selected)
	{
		[self.textField becomeFirstResponder];
	}
}

#pragma mark - 

- (UITextField *)textField
{
	if (!_textField)
	{
		_textField = [[UITextField alloc] initWithFrame:CGRectZero];
		_textField.translatesAutoresizingMaskIntoConstraints = NO;

		_textField.autocorrectionType = UITextAutocorrectionTypeNo;
		_textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.spellCheckingType = UITextSpellCheckingTypeNo;
		_textField.clearButtonMode = UITextFieldViewModeWhileEditing;

		[self.contentView addSubview:_textField];
	}

	return _textField;
}

@end
