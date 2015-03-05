//
//  SIDetailTextFieldTableViewCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 4/4/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRTitleAndValueTableCell.h"

NSString * const BHRTitleAndValueTableCellReuseID = @"BHRTitleAndValueTableCell";

@interface BHRTitleAndValueTableCell ()

@property (nonatomic, strong) NSLayoutConstraint *leftLayoutMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightLayoutMarginConstraint;

@end

@implementation BHRTitleAndValueTableCell

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

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label]-(8)-[valueTextField]"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[label]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];


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

    self.leftLayoutMarginConstraint = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                                   attribute:NSLayoutAttributeLeading
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeLeading
                                                                  multiplier:1.0f
                                                                    constant:self.layoutMargins.left];
    [self.contentView addConstraint:self.leftLayoutMarginConstraint];

    self.rightLayoutMarginConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                    attribute:NSLayoutAttributeTrailing
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.valueTextField
                                                                    attribute:NSLayoutAttributeTrailing
                                                                   multiplier:1.0f
                                                                     constant:self.layoutMargins.right];
    [self.contentView addConstraint:self.rightLayoutMarginConstraint];

	[self.valueTextField setContentHuggingPriority:222 forAxis:UILayoutConstraintAxisHorizontal];
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
		_valueTextField.textAlignment = NSTextAlignmentRight;
		
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

- (void)layoutMarginsDidChange
{
    [super layoutMarginsDidChange];

    self.leftLayoutMarginConstraint.constant = self.layoutMargins.left;
    self.rightLayoutMarginConstraint.constant = self.layoutMargins.right;
}

@end
