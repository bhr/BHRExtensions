//
//  SIShellAccessoryView.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 2/23/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIKeyboardButtonView.h"
#import "SIShellCommandConstructor.h"

extern NSString * const SIShellButtonInfoTitle;
extern NSString * const SIShellButtonInfoType;
extern NSString * const SIShellButtonInfoID;


@protocol SIShellAccessoryViewDelegate;

@interface SIKeyboardAccessoryView : UIView <SIKeyboardButtonViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) id<SIShellAccessoryViewDelegate> delegate;
@property (nonatomic, assign) UIUserInterfaceStyle interfaceStyle;

- (instancetype)initWithInterfaceStyle:(UIUserInterfaceStyle)interfaceStyle NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (void)sendButtonWithType:(SIShellAccessoryButton)buttonType;


/*
 needs to be subclassed
 */
- (NSArray *)buttonsInfo;

/*
 may be subclassed to perform custom behavior, default implementation calls sendButtonWithType:
 */
- (void)tappedShellButtonView:(SIKeyboardButtonView *)buttonView;


@end

@protocol SIShellAccessoryViewDelegate <NSObject>

- (void)shellAccessoryView:(SIKeyboardAccessoryView *)shellAccessoryViewController
			didPressButton:(SIShellAccessoryButton)button;

@optional
- (UIViewController *)viewControllerForAlertAccessoryView:(SIKeyboardAccessoryView *)shellAccessoryViewController;

@end
