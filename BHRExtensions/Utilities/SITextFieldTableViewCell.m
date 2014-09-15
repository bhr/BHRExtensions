//
//  SIHostDetailNameCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SITextFieldTableViewCell.h"

NSString * const SITextFieldTableViewCellReuseId = @"textFieldCell";


@implementation SITextFieldTableViewCell

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
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[textField]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:@{ @"textField": self.textField }]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[textField]-(8)-|"
																			 options:0
																			 metrics:nil
																			   views:@{ @"textField": self.textField }]];

	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textField
																 attribute:NSLayoutAttributeCenterY
																 relatedBy:NSLayoutRelationEqual
																	toItem:self.contentView
																 attribute:NSLayoutAttributeCenterY
																multiplier:1.0f
																  constant:0.0f]];
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
		_textField.clearButtonMode = UITextFieldViewModeWhileEditing;

		[self.contentView addSubview:_textField];
	}

	return _textField;
}

@end
