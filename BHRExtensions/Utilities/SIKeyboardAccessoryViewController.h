//
//  SIShellAccessoryViewController.h
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


@protocol SIShellAccessoryViewControllerDelegate;

@interface SIKeyboardAccessoryViewController : UIViewController <SIKeyboardButtonViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) id<SIShellAccessoryViewControllerDelegate> delegate;

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

@protocol SIShellAccessoryViewControllerDelegate <NSObject>

- (void)shellAccessoryViewController:(SIKeyboardAccessoryViewController *)shellAccessoryViewController
					  didPressButton:(SIShellAccessoryButton)button;

@optional
- (UIView *)viewShownFromForAccessoryViewController:(SIKeyboardAccessoryViewController *)shellAccessoryViewController;

@end