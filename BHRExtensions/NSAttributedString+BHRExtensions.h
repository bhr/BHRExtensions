//
//  NSAttributedString+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/29/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (BHRExtensions)

- (NSAttributedString *)stringBySanitizingTypes;

- (NSAttributedString *)stringbyReplacingTextColor:(UIColor *)existingColor
										 withColor:(UIColor *)newColor;

- (NSAttributedString *)stringbyReplacingFontWithFont:(UIFont *)newFont;

@end
