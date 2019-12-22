//
//  SICommandDetailCommandCell.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BHRScriptTextTableCellReuseID;

@interface BHRScriptTextTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *importButton;
@property (nonatomic, assign) BOOL showImportButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end
