//
//  BHRRoundedRectButton.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/8/15.
//  Copyright (c) 2015 HIRMER.me. All rights reserved.
//

#import "BHRRoundedRectButton.h"
#import "UIImage+BHRExtensions.h"

@implementation BHRRoundedRectButton


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 4.f;
    [self _updateColors];

    self.titleLabel.font = [UIFont systemFontOfSize:13.f];
}

//=====================================================
#pragma mark -
#pragma mark Helper
//=====================================================

- (void)_updateColors
{
    self.layer.borderColor = [self.tintColor CGColor];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

    UIImage *backgroundImage = [UIImage solidColorImageWithColor:self.tintColor];
    [self setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        [super setHighlighted:highlighted];
    }
    else
    {
        //Hack for having always the button highlighted - even when pressing button only shortly
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
                           [super setHighlighted:highlighted];
                       });
    }
}

//=====================================================
#pragma mark -
#pragma mark Overrides
//=====================================================

- (CGSize)intrinsicContentSize
{
    CGSize intrinsincSize = [super intrinsicContentSize];
    intrinsincSize.width += 8.f;

    return intrinsincSize;
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    [self _updateColors];
}


@end
