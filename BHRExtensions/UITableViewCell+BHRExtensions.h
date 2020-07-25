//
//  UITableViewCell+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 7/25/20.
//  Copyright © 2020 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (BHRExtensions)

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
