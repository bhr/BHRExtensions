//
//  UIImage+Extensions.m
//  VirtualUIElements
//
//  Created by Benedikt Hirmer on 26.01.13.
//  Copyright (c) 2013 Institute of Ergonomics. All rights reserved.
//

#import "UIImage+BHRExtensions.h"

@implementation UIImage (BHRExtensions)

//Makes pics blurry?!
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
	
	UIImage *sourceImage = self;
	UIImage *newImage = nil;
	
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (!CGSizeEqualToSize(imageSize, targetSize)) {
		
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor < heightFactor)
			scaleFactor = widthFactor;
        else
			scaleFactor = heightFactor;
		
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
		
        if (widthFactor < heightFactor) {
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
			thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
	}
	
	
	// this is actually the interesting part:
	
	UIGraphicsBeginImageContext(targetSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	if(newImage == nil) NSLog(@"could not scale image");
	
	
	return newImage ;
}

+ (UIImage *)imageRetinaWithContentsOfFile:(NSString *)file
{
	UIImage *image = nil;
	
	if ([UIScreen instancesRespondToSelector:@selector(scale)] &&
		[[UIScreen mainScreen] scale] == 2.0)
	{
		NSString *path2x;
		NSString *newLastPathComponent;
		
		newLastPathComponent = [NSString stringWithFormat:@"%@@2x.%@", [[file lastPathComponent] stringByDeletingPathExtension], [file pathExtension]];
		path2x = [[file stringByDeletingLastPathComponent] stringByAppendingPathComponent:newLastPathComponent];
		
		if ([[NSFileManager defaultManager] fileExistsAtPath:path2x])
		{
			image = [[UIImage alloc] initWithCGImage:[[UIImage imageWithData:[NSData dataWithContentsOfFile:path2x]] CGImage]
											   scale:2.0
										 orientation:UIImageOrientationUp];
		}
	}
	
	if (image == nil) {
		image =  [UIImage imageWithContentsOfFile:file];
	}
	
	return image;
}

@end