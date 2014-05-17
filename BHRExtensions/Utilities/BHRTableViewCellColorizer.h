//
//  PIMHostCellColorizer.h
//  PIMonitor
//
//  Created by Benedikt Hirmer on 5/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BHRTableViewCellColorizer : NSObject

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *disabledTextColor;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIColor *selectionColor;
@property (nonatomic, strong) UIColor *backgroundColor;

- (void)colorizeCell:(UITableViewCell *)cell;

@end
