//
//  NSString+BHExtensions.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 27.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (BHRExtensions)

- (NSString *)stringByDissolvingCamelCase;


- (BOOL)startsWith:(NSString *)string;


/**
 * Deprecated
 */
- (CGFloat)fontSizeForSize:(CGSize)size
					  font:(UIFont *)font;

@end
