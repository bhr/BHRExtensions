//
//  SIShellButtonView.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/16/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SIKeyboardButtonViewDelegate;

@interface SIKeyboardButtonView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<SIKeyboardButtonViewDelegate>delegate;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL selected;

@end

@protocol SIKeyboardButtonViewDelegate <NSObject>

- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;

@end