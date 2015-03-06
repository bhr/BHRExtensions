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

@property (nonatomic, copy) UIColor *textColor;
@property (nonatomic, copy) UIColor *disabledTextColor;
@property (nonatomic, copy) UIColor *placeholderColor;
@property (nonatomic, copy) UIColor *selectionColor;
@property (nonatomic, copy) UIColor *backgroundColor;

/**
 * ignores tha class and all its subviews
 */
@property (nonatomic, copy) NSArray *ignoredClasses;

- (void)colorizeCell:(UITableViewCell *)cell;

@end
