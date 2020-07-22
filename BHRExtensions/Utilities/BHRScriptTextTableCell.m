//
//  SICommandDetailCommandCell.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRScriptTextTableCell.h"
#import "UIView+BHRExtensions.h"

NSString * const BHRScriptTextTableCellReuseID = @"BHRScriptTextTableCell";

@interface BHRScriptTextTableCell ()

@end

@implementation BHRScriptTextTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
	{
		[self _setupConstraints];
    }
    return self;
}

- (void)_setupConstraints
{
    [self.contentView removeAllSubviews];

    if (self.showImportButton) {
        [self _setupConstraintsForCellWithImportButton];
    }
    else {
        [self _setupConstraintsForCellWithoutImportButton];
    }
}

- (void)_setupConstraintsForCellWithoutImportButton
{
    [self.contentView addSubview:self.textView];
    [self.contentView insertSubview:self.placeholderLabel
                       aboveSubview:self.textView];

    NSDictionary *viewsDict = @{ @"placeholder": self.placeholderLabel ,
                                 @"textView": self.textView };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[textView]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[textView]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDict]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[placeholder]-(>=0)-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDict]];
	
	UILabel *placeholder = self.placeholderLabel;
	UIView *contentView = self.contentView;
	
	[[placeholder.leadingAnchor constraintEqualToAnchor:contentView.layoutMarginsGuide.leadingAnchor] setActive:YES];
	[[contentView.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:placeholder.trailingAnchor] setActive:YES];
}

- (void)_setupConstraintsForCellWithImportButton
{
    [self.contentView addSubview:self.textView];
    [self.contentView insertSubview:self.placeholderLabel
                       aboveSubview:self.textView];
    [self.contentView addSubview:self.importButton];
    [self.contentView addSubview:self.titleLabel];

    NSDictionary *viewsDict = @{ @"title": self.titleLabel,
                                 @"placeholder": self.placeholderLabel ,
                                 @"textView": self.textView ,
                                 @"importButton": self.importButton };

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[title]-(>=0)-[importButton]-15-|"
                                                                             options:NSLayoutFormatAlignAllBaseline
                                                                             metrics:nil
                                                                               views:viewsDict]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[title]-[textView]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[textView]-8-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewsDict]];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textView
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.placeholderLabel
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0f
                                                                  constant:-8.0f]];
    
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

- (void)setShowImportButton:(BOOL)showImportButton
{
    if (_showImportButton != showImportButton)
    {
        _showImportButton = showImportButton;
        [self _setupConstraints];
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

	}
	return _placeholderLabel;
}

- (UITextView *)textView
{
	if (!_textView)
	{
		_textView = [[UITextView alloc] initWithFrame:CGRectZero];
		_textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.contentInset = UIEdgeInsetsZero;

		_textView.backgroundColor = [UIColor clearColor];
		_textView.font = [UIFont fontWithName:@"Menlo" size:14.0f];
		_textView.editable = YES;
		_textView.selectable = YES;
		_textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
		_textView.autocorrectionType = UITextAutocorrectionTypeNo;
	}
	return _textView;
}

- (UIButton *)importButton
{
    if (!_importButton)
    {
        _importButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _importButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_importButton setTitle:NSLocalizedString(@"Import from File", nil)
                       forState:UIControlStateNormal];
    }

    return _importButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]-3];
        _titleLabel.text = NSLocalizedString(@"Script", nil);
    }

    return _titleLabel;
}

@end
