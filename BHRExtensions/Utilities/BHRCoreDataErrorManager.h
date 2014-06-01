//
//  BHRCoreDataErrorManager.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/1/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BHRCoreDataErrorManager : NSObject

- (void)showErrorAlert;

+ (BHRCoreDataErrorManager *)sharedManager;

@end
