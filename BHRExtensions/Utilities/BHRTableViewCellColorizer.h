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

/**
 * contentTextColor is used for UITextField, UILabel, or UITextField that doesn't use the restorationIdentifier that contains "labelColor" and that are enabled
 */
@property (nonatomic, copy) UIColor *contentTextColor;

/**
 * labelTextColor is used when the restorationIdentifier of the UITextField, UILabel, or UITextField contains "labelColor"
 */
@property (nonatomic, copy) UIColor *labelTextColor;
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
