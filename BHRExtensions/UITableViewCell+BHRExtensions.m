//
//  UITableViewCell+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 7/25/20.
//  Copyright © 2020 HIRMER.me. All rights reserved.
//

#import "UITableViewCell+BHRExtensions.h"

@implementation UITableViewCell (BHRExtensions)

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate
{
	[self _setTextFieldDelegate:delegate forSubviews:self.contentView.subviews];
}

- (void)_setTextFieldDelegate:(id<UITextFieldDelegate>)delegate  forSubviews:(NSArray<UIView *> *)subviews
{
	for (UIView *subview in subviews) {
		if (![subview isKindOfClass:UITextField.class] && ![subview isKindOfClass:UITextView.class]) {
			[self _setTextFieldDelegate:delegate forSubviews:subview.subviews];
			continue;
		}
		UITextField *textField = (UITextField *)subview;
		textField.delegate = delegate;
	}
}

@end
