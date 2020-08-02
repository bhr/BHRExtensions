//
//  LGAdditions.h
//  LGGradingMobile
//
//  Created by Benedikt Hirmer on 1/10/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRAdditions : NSObject

@end

CGMutablePathRef CGPathCreatePathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians);
CGRect CGRectWithScale(CGRect rect, CGFloat scale);
CGSize CGSizeScaledProportionallyToSize(CGSize originalSize, CGSize targetSize);

CGRect CGRectEdgeInset(CGRect rect, UIEdgeInsets insets);
CGRect CGRectSquareInRect(CGRect rect);

NSString *NSStringFromBOOL(BOOL boolean);
NSString *EmptyStringIfNil(id object);
id NSNullIfNil(id object);
NSString *NSStringEmptyIfNil(id object);

//MATH

CGFloat clampf(CGFloat x, CGFloat low, CGFloat high);
CGFloat DegreeToRadians(CGFloat degreeValue);
CGFloat RadiansToDegrees(CGFloat radiansValue);
CGFloat Square(CGFloat value);
CGFloat RotateValueAtPositionWithMax(CGFloat value, CGFloat flipPosition, CGFloat max);

CGFloat HorizontalDistanceFromRectToPoint(CGRect rect, CGPoint point);

NS_INLINE void dispatch_on_main_async(dispatch_block_t dispatchBlock) {
	if ([NSThread isMainThread]) {
		dispatchBlock();
		return;
	}
	
	dispatch_async(dispatch_get_main_queue(), ^{
		dispatchBlock();
	});
}

NS_INLINE void dispatch_on_main_sync(dispatch_block_t dispatchBlock) {
	if ([NSThread isMainThread]) {
		dispatchBlock();
		return;
	}
	
	dispatch_sync(dispatch_get_main_queue(), ^{
		dispatchBlock();
	});
}
