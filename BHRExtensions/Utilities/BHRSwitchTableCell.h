//
//  SISwitchTableViewCell.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/6/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BHRSwitchTableCellReuseID;

@interface BHRSwitchTableCell : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwitch *switchObject;

@end
