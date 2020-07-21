//
//  NSMutableAttributedString+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/25/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (BHRExtensions)

- (void)bhr_deleteAllOccurrencesOfString:(NSString *)string;
- (void)bhr_replaceOccurrencesOfString:(NSString *)string withString:(NSString *)replacementString;

@end

NS_ASSUME_NONNULL_END
