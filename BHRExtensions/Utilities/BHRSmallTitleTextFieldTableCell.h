//
//  BHRSmallTitleTextFieldTableCell.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 10/21/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BHRSmallTitleTextFieldTableCellReuseId;

@interface BHRSmallTitleTextFieldTableCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *valueTextField;

@end
