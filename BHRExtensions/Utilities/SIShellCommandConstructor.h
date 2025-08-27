//
//  SIShellCommandConstructor.h
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/16/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum SIShellAccessoryButton : NSUInteger {
	SIShellAccessoryButtonHideShell = 0,
	SIShellAccessoryButtonHideKeyboard,
	SIShellAccessoryButtonSlash,
	SIShellAccessoryButtonSemiColon,
	
	SIShellAccessoryButtonArrowUp,
	SIShellAccessoryButtonArrowDown,
	SIShellAccessoryButtonArrowLeft,
	SIShellAccessoryButtonArrowRight,
	
	SIShellAccessoryButtonControl,
	SIShellAccessoryButtonEsc,
	SIShellAccessoryButtonFn,
	SIShellAccessoryButtonTab,
	
	SIShellAccessoryButtonF1 = 1000,
	SIShellAccessoryButtonF2,
	SIShellAccessoryButtonF3,
	SIShellAccessoryButtonF4,
	SIShellAccessoryButtonF5,
	SIShellAccessoryButtonF6,
	SIShellAccessoryButtonF7,
	SIShellAccessoryButtonF8,
	SIShellAccessoryButtonF9,
	SIShellAccessoryButtonF10,
	SIShellAccessoryButtonF11,
	SIShellAccessoryButtonF12,
    
    SIShellAccessoryButtonNone = 9999,
	
} SIShellAccessoryButton;

@interface SIShellCommandConstructor : NSObject


+ (NSString *)commandForButton:(SIShellAccessoryButton)buttonType;

+ (NSString *)controlCharacterCommandWithCharacter:(NSString *)character;

@end
