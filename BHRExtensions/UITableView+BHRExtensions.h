//
//  UITableView+BHRExtensions.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BHRExtensions)

- (void)selectNextResponderForView:(UIView *)view;
- (NSIndexPath *)nextIndexForPath:(NSIndexPath *) indexPath;

- (NSArray *)allIndexPaths;

@end
