//
//  SIHostDetailNameCell.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BHRTextFieldTableCellReuseID;

@interface BHRTextFieldTableCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

@end
