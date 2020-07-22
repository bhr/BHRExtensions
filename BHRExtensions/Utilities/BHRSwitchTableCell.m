//
//  SISwitchTableViewCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRSwitchTableCell.h"

NSString * const BHRSwitchTableCellReuseID = @"BHRSwitchTableCell";


@implementation BHRSwitchTableCell

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
	NSDictionary *viewsDict = @{ @"label": self.label,
								 @"switchObject": self.switchObject };

	UILabel *label = self.label;
	UISwitch *switchObject = self.switchObject;
	UIView *contentView = self.contentView;
	
	[[label.leadingAnchor constraintEqualToAnchor:contentView.layoutMarginsGuide.leadingAnchor] setActive:YES];
	[[switchObject.leadingAnchor constraintGreaterThanOrEqualToSystemSpacingAfterAnchor:label.trailingAnchor multiplier:1.0] setActive:YES];
	[[contentView.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:switchObject.trailingAnchor] setActive:YES];

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[label]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[switchObject]-(>=0)-|"
																			 options:0
																			 metrics:nil
																			   views:viewsDict]];

	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
																 attribute:NSLayoutAttributeCenterY
																 relatedBy:NSLayoutRelationEqual
																	toItem:self.label
																 attribute:NSLayoutAttributeCenterY
																multiplier:1.0f
																  constant:0.0f]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
																 attribute:NSLayoutAttributeCenterY
																 relatedBy:NSLayoutRelationEqual
																	toItem:self.switchObject
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

- (UILabel *)label
{
	if (!_label)
	{
		_label = [[UILabel alloc] initWithFrame:CGRectZero];
		_label.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_label];
	}

	return _label;
}

- (UISwitch *)switchObject
{
	if (!_switchObject)
	{
		_switchObject = [[UISwitch alloc] initWithFrame:CGRectZero];
		_switchObject.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_switchObject];
	}

	return _switchObject;
}

@end
