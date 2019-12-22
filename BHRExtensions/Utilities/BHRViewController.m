//
//  BHRViewController.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/2/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRViewController.h"

@interface BHRViewController ()

@end

@implementation BHRViewController

- (instancetype)init
{
	NSString *nibName = NSStringFromClass([self class]);

	if([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"] == nil)
	{
		nibName = nil;
	}

    self = [super initWithNibName:nibName
						   bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}


@end
