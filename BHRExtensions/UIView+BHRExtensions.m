//
//  UIView+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 2/27/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIView+BHRExtensions.h"

@implementation UIView (BHRExtensions)


- (UIImage *)blurredSnapshotWithEffect:(UIImageBlurEffect)effect
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);

    // There he is! The new API method
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];

    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();

    UIImage *blurredSnapshotImage;

    //	blurredSnapshotImage = [snapshotImage applyDarkEffect];
    blurredSnapshotImage = [snapshotImage applyEffect:effect];
    //	blurredSnapshotImage = [snapshotImage applyLightEffect];
    //	blurredSnapshotImage = [snapshotImage applyExtraLightEffect];

    // Be nice and clean your mess up
    UIGraphicsEndImageContext();

    return blurredSnapshotImage;
}


- (UIImage *)blurredSnapshot
{
    return [self blurredSnapshotWithEffect:UIImageBlurEffectNeutral];
}

- (UIImage *)snapshot
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);

    // There he is! The new API method
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];

    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return snapshotImage;
}

- (void)insertConstraintBasedSubview:(UIView *)view belowSubView:(UIView *)otherView
{
    [self insertSubview:view belowSubview:otherView];
    [self addConstraintsForSubview:view toFitWithInsets:UIEdgeInsetsZero];
}

- (void)insertConstraintBasedSubview:(UIView *)view atIndex:(NSUInteger)index
{
    [self insertSubview:view atIndex:index];
    [self addConstraintsForSubview:view toFitWithInsets:UIEdgeInsetsZero];
}

- (void)insertConstraintBasedSubview:(UIView *)view aboveSubView:(UIView *)otherView
{
    [self insertSubview:view aboveSubview:otherView];
    [self addConstraintsForSubview:view toFitWithInsets:UIEdgeInsetsZero];
}

- (void)addConstraintBasedSubview:(UIView *)view
{
    [self addConstraintBasedSubview:view withInsets:UIEdgeInsetsZero];
}

- (void)addConstraintBasedSubview:(UIView *)view withInsets:(UIEdgeInsets)insets
{
    [self addSubview:view];
    [self addConstraintsForSubview:view toFitWithInsets:insets];
}

- (void)addConstraintsForSubview:(UIView *)view toFitWithInsets:(UIEdgeInsets)insets
{
    view.frame = self.bounds;
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];

    NSArray *constraints = [self constraintsForSubview:view
                                       toFitWithInsets:insets];
    [self addConstraints:constraints];
}

- (NSArray *)constraintsForSubview:(UIView *)view toFitWithInsets:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray array];

    NSDictionary *views = @{@"subview": view};
    NSDictionary *metrics = @{
                              @"left": @(insets.left),
                              @"right": @(insets.right),
                              @"top": @(insets.top),
                              @"bottom": @(insets.bottom),
                              };

    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[subview]-right-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[subview]-bottom-|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
    return constraints;
}

#pragma mark -

- (BOOL)findAndResignFirstResponder
{
    if (self.isFirstResponder)
    {
        [self resignFirstResponder];
        return YES;
    }

    for (UIView *subView in self.subviews)
    {
        if ([subView findAndResignFirstResponder]) {
            return YES;
        }
    }

    return NO;
}

- (UIView *)subviewWithRestorationIdentifier:(NSString *)restorationIdentifier
{
    for (UIView *subview in self.subviews)
    {
        if ([subview.restorationIdentifier isEqualToString:restorationIdentifier])
        {
            return subview;
        }
    }

    return nil;
}

- (void)removeAllSubviews
{
    for (UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
}

- (void)printSubviewsWithIndentation:(int)indentation
{
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *currentSubview, NSUInteger idx, BOOL *stop)
     {
         NSMutableString *currentViewDescription = [[NSMutableString alloc] init];

         for (int j = 0; j <= indentation; j++)
         {
             [currentViewDescription appendString:@"   "];
         }

         [currentViewDescription appendFormat:@"[%lu]: %@ - frame: %@, bounds: %@", idx, NSStringFromClass([currentSubview class]), NSStringFromCGRect([currentSubview frame]), NSStringFromCGRect([currentSubview bounds])];

         NSLog(@"%@", currentViewDescription);
         
         [currentSubview printSubviewsWithIndentation:indentation+1];
     }];
}

@end
