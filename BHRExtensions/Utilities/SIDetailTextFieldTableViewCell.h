//
//  SIDetailTextFieldTableViewCell.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 4/4/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const SIDetailTextFieldTableViewCellReuseId;

@interface SIDetailTextFieldTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *valueTextField;

@end
