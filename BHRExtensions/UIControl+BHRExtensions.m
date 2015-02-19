//
//  UIControl+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/19/15.
//  Copyright (c) 2015 HIRMER.me. All rights reserved.
//

#import "UIControl+BHRExtensions.h"

@implementation UIControl (BHRExtensions)

- (void)removeAllTargets
{
    [self removeTarget:nil
                action:NULL
      forControlEvents:UIControlEventAllEvents];
}

@end
