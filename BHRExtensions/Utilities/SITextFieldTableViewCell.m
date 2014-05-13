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
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField]|"
																			 options:0
																			 metrics:nil
																			   views:@{ @"textField": self.textField }]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[textField]-8-|"
																			 options:0
																			 metrics:nil
																			   views:@{ @"textField": self.textField }]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

		[self.contentView addSubview:_textField];
	}

	return _textField;
}

@end
