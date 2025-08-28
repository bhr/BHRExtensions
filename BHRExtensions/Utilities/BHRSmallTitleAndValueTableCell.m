//
//  BHRSmallTitleTextFieldTableCell.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 10/21/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRSmallTitleAndValueTableCell.h"

NSString * const BHRSmallTitleAndValueTableCellReuseID = @"BHRSmallTitleAndValueTableCell";

@interface BHRSmallTitleAndValueTableCell ()

@property (nonatomic, strong) UIView *containerView;

@end

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

	
	[[self.containerView.leftAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.leftAnchor] setActive:YES];
	[[self.contentView.layoutMarginsGuide.rightAnchor constraintEqualToAnchor:self.containerView.rightAnchor] setActive:YES];
	
	[[self.containerView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
	[[self.containerView.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor] setActive:YES];
	[[self.contentView.layoutMarginsGuide.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.containerView.bottomAnchor] setActive:YES];
	
	[[self.titleLabel.leftAnchor constraintEqualToAnchor:self.containerView.leftAnchor] setActive:YES];
	[[self.containerView.rightAnchor constraintEqualToAnchor:self.titleLabel.rightAnchor] setActive:YES];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]-4-[valueTextField]|"
																			 options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing
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
        _valueTextField.spellCheckingType = UITextSpellCheckingTypeNo;
		_valueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_valueTextField.textAlignment = NSTextAlignmentLeft;
		_valueTextField.textColor = UIColor.labelColor;
		
		[self.containerView addSubview:_valueTextField];
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
		
		[self.containerView addSubview:_titleLabel];
	}

	return _titleLabel;
}

- (UIView *)containerView
{
	if (!_containerView)
	{
		_containerView = [[UIView alloc] init];
		_containerView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_containerView];
	}
	
	return _containerView;
}

@end
