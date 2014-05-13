//
//  SIShellCommandConstructor.m
//  SimpleSSH
//
//  Created by Benedikt Hirmer on 3/16/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "SIShellCommandConstructor.h"

@implementation SIShellCommandConstructor

+ (NSString *)commandForButton:(SIShellAccessoryButton)buttonType;
{
	switch (buttonType)
	{
		case SIShellAccessoryButtonF1:
			return @"\033OP";
			break;
		case SIShellAccessoryButtonF2:
			return @"\033OQ";
			break;
		case SIShellAccessoryButtonF3:
			return @"\033OR";
			break;
		case SIShellAccessoryButtonF4:
			return @"\033OS";
			break;
		case SIShellAccessoryButtonF5:
			return @"\033[O15~";
			break;
		case SIShellAccessoryButtonF6:
			return @"\033[O17~";
			break;
		case SIShellAccessoryButtonF7:
			return @"\033[O18~";
			break;
		case SIShellAccessoryButtonF8:
			return @"\033[O19~";
			break;
		case SIShellAccessoryButtonF9:
			return @"\033[O20~";
			break;
		case SIShellAccessoryButtonF10:
			return @"\033[O21~";
			break;
		case SIShellAccessoryButtonF11:
			return @"\033[O23~";
			break;
		case SIShellAccessoryButtonF12:
			return @"\033[O24~";
			break;
			
		case SIShellAccessoryButtonArrowUp:
			return @"\033[A";
			break;
		case SIShellAccessoryButtonArrowDown:
			return @"\033[B";
			break;
		case SIShellAccessoryButtonArrowLeft:
			return @"\033[D";
			break;
		case SIShellAccessoryButtonArrowRight:
			return @"\033[C";
			break;
			
		case SIShellAccessoryButtonEsc:
			return @"\033[";
			break;
		case SIShellAccessoryButtonTab:
			return @"\t";
			break;
		case SIShellAccessoryButtonSemiColon:
			return @";";
			break;
		case SIShellAccessoryButtonSlash:
			return @"/";
			break;
			
		default:
			return nil;
			break;
	}
}


+ (NSString *)controlCharacterCommandWithCharacter:(NSString *)character;
{
	NSArray *validControlCharacters = [self _validControlCharacters];
	__block NSString *controlSequence = nil;
	
	[validControlCharacters enumerateObjectsUsingBlock:^(NSDictionary *validCharacterMapping, NSUInteger idx, BOOL *stop)
	{
		NSString *characterKey = [[validCharacterMapping allKeys] lastObject];
		
		if ([characterKey isEqualToString:[character uppercaseString]])
		{
			controlSequence = [validCharacterMapping objectForKey:characterKey];
			*stop = YES;
		}
	}];
	
	return controlSequence;
}

+ (NSArray *)_validControlCharacters
{
	return @[
			 @{@"@": @"\x000"},
			 @{@"A": @"\x001"},
			 @{@"B": @"\x002"},
			 @{@"C": @"\x003"},
			 @{@"D": @"\x004"},
			 @{@"E": @"\x005"},
			 @{@"F": @"\x006"},
			 @{@"G": @"\x007"},
			 @{@"H": @"\x010"},
			 @{@"I": @"\x011"},
			 @{@"J": @"\x012"},
			 @{@"K": @"\x013"},
			 @{@"L": @"\x014"},
			 @{@"M": @"\x015"},
			 @{@"N": @"\x016"},
			 @{@"O": @"\x017"},
			 @{@"P": @"\x020"},
			 @{@"Q": @"\x021"},
			 @{@"R": @"\x022"},
			 @{@"S": @"\x023"},
			 @{@"T": @"\x024"},
			 @{@"U": @"\x025"},
			 @{@"V": @"\x026"},
			 @{@"W": @"\x027"},
			 @{@"X": @"\x030"},
			 @{@"Y": @"\x031"},
			 @{@"Z": @"\x032"},
			 @{@"[": @"\x033"},
			 @{@" ": @"\x034"},
			 @{@"]": @"\x035"},
			 @{@"^": @"\x036"},
			 @{@"_": @"\x037"},
			 ];
}



@end
