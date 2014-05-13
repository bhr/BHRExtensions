//
//  SIDetailTextFieldTableViewCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 4/4/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIDetailTextFieldTableViewCell.h"

NSString * const SIDetailTextFieldTableViewCellReuseId = @"detailTextFieldCell";

@implementation SIDetailTextFieldTableViewCell

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
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]-(8)-[switchObject]-20-|"
																			 options:0
																			 metrics:nil
																			   views:@{ @"label": self.titleLabel,
																						@"switchObject": self.valueTextField }]];

	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
																 attribute:NSLayoutAttributeCenterY
																 relatedBy:NSLayoutRelationEqual
																	toItem:self.titleLabel
																 attribute:NSLayoutAttributeCenterY
																multiplier:1.0f
																  constant:0.0f]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
																 attribute:NSLayoutAttributeCenterY
																 relatedBy:NSLayoutRelationEqual
																	toItem:self.valueTextField
																 attribute:NSLayoutAttributeCenterY
																multiplier:1.0f
																  constant:0.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
		[self.contentView addSubview:_titleLabel];
	}

	return _titleLabel;
}

@end
