//
//  NSMutableAttributedString+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/25/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (BHRExtensions)

- (void)deleteAllOccurrencesOfString:(NSString *)string;
- (void)replaceOccurrencesOfString:(NSString *)string withString:(NSString *)replacementString;

@end
