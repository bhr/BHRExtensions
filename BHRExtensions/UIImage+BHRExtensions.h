//
//  UIImage+Extensions.h
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BHRExtensions)

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;

+ (UIImage *)imageRetinaWithContentsOfFile:(NSString *)file;

@end
