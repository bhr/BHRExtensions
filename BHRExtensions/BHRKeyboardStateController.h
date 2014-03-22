//
//  SIKeyboardStateController.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/22/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHRKeyboardStateController : NSObject

/**
 * Constraint to be modified when keyboard shows/hides
 */
- (instancetype)initWithConstraint:(NSLayoutConstraint *)constraint;

@end
