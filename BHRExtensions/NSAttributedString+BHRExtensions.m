//
//  NSAttributedString+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 6/29/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSAttributedString+BHRExtensions.h"
#import "UIColor+BHRExtensions.h"
#import <CoreText/CoreText.h>

NSArray<NSString *> *ColorAttributeKeys(void) {
    static NSArray<NSString *> *keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keys = @[
            NSForegroundColorAttributeName,
            NSBackgroundColorAttributeName,
            NSStrokeColorAttributeName,
            NSUnderlineColorAttributeName,
            NSStrikethroughColorAttributeName
        ];
    });
    return keys;
}

BOOL UIColorComponentsEqual(UIColor *c1, UIColor *c2) {
    CGFloat r1, g1, b1, a1;
    CGFloat r2, g2, b2, a2;
    
    [c1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [c2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    CGFloat epsilon = 0.01;
    return (fabs(r1 - r2) < epsilon &&
            fabs(g1 - g2) < epsilon &&
            fabs(b1 - b2) < epsilon &&
            fabs(a1 - a2) < epsilon);
}

@implementation NSAttributedString (BHRExtensions)

+ (UIColor *)uiColorForValue:(id)value
{
    if (!value) {
        return value;
    }
    
    if ([value isKindOfClass:[UIColor class]]) {
        return value;
    }
    
    if (CFGetTypeID((__bridge CFTypeRef)(value)) == CGColorGetTypeID()) {
        return [UIColor colorWithCGColor:(__bridge CGColorRef _Nonnull)(value)];
    }
    
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Unexpected color value"
                                 userInfo:@{ @"value": value }];

}

UIFont *UIFontFromCTFont(CTFontRef ctFont) {
    if (!ctFont) return nil;

    CFStringRef fontName = CTFontCopyPostScriptName(ctFont); // or CTFontCopyFullName()
    CGFloat fontSize = CTFontGetSize(ctFont);
    
    UIFont *uiFont = [UIFont fontWithName:(__bridge_transfer NSString *)fontName size:fontSize];
    return uiFont;
}

+ (UIFont *)uiFontForValue:(id)value
{
    if (!value) {
        return value;
    }
    
    if ([value isKindOfClass:[UIFont class]]) {
        return value;
    }
    
    if (CFGetTypeID((__bridge CFTypeRef)(value)) == CTFontGetTypeID()) {
        return UIFontFromCTFont((__bridge CTFontRef)(value));
    }
    
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"Unexpected font value"
                                 userInfo:@{ @"value": value }];

}

- (NSAttributedString *)stringBySanitizingTypes
{
    NSMutableAttributedString *adjustedAttributedString = [[NSMutableAttributedString alloc] init];
    
    
    [self enumerateAttributesInRange:NSMakeRange(0, self.length)
                                         options:0
                                      usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
     {
        NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];
        
        for (NSString *key in ColorAttributeKeys()) {
            UIColor *textColor = [NSAttributedString uiColorForValue:newTextAttributes[key]];
            if (textColor) {
                newTextAttributes[key] = textColor;
            }
        }
        
        UIFont *currentFont = [NSAttributedString uiFontForValue:newTextAttributes[NSFontAttributeName]];
        if (currentFont) {
            newTextAttributes[NSFontAttributeName] = currentFont;
        }

         NSString *string = [self string];

         //adjust length if strings length is less than range
         //note: this shouldn't happen but did happen, so we resolve it manually
         if (NSMaxRange(range) > [string length])
         {
             range.length -= (NSMaxRange(range) - [string length]);
         }

         NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[string substringWithRange:range]
                                                                                                 attributes:newTextAttributes];
         [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

     }];

    return [adjustedAttributedString copy];
}

- (NSAttributedString *)stringbyReplacingTextColor:(UIColor *)existingColor
										 withColor:(UIColor *)newColor
{
	NSMutableAttributedString *adjustedAttributedString = [[NSMutableAttributedString alloc] init];
	
	
	[self enumerateAttributesInRange:NSMakeRange(0, self.length)
										 options:0
									  usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
	 {
        NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];
        UIColor *textColor = [NSAttributedString uiColorForValue:newTextAttributes[NSForegroundColorAttributeName]];

		 if (textColor == nil ||
			 UIColorComponentsEqual(textColor, existingColor))
		 {
			 newTextAttributes[NSForegroundColorAttributeName] = newColor;
		 }

         NSString *string = [self string];

         //adjust length if strings length is less than range
         //note: this shouldn't happen but did happen, so we resolve it manually
         if (NSMaxRange(range) > [string length])
         {
             range.length -= (NSMaxRange(range) - [string length]);
         }

		 NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[string substringWithRange:range]
																								 attributes:newTextAttributes];
		 [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

	 }];

	return [adjustedAttributedString copy];
}


- (NSAttributedString *)stringbyReplacingFontWithFont:(UIFont *)newFont
{
	NSMutableAttributedString *adjustedAttributedString = [[NSMutableAttributedString alloc] init];

	[self enumerateAttributesInRange:NSMakeRange(0, [[self string] length])
							 options:0
						  usingBlock:^(NSDictionary *textAttributes, NSRange range, BOOL *stop)
	 {
		 NSMutableDictionary *newTextAttributes = [textAttributes mutableCopy];

        UIFont *currentFont = [NSAttributedString uiFontForValue:newTextAttributes[NSFontAttributeName]];

		 if (currentFont == nil)
		 {
			 newTextAttributes[NSFontAttributeName] = newFont;
		 }

		 NSAttributedString *adjustedAttributedStringComponent = [[NSAttributedString alloc] initWithString:[[self string] substringWithRange:range]
																								 attributes:newTextAttributes];
		 [adjustedAttributedString appendAttributedString:adjustedAttributedStringComponent];

	 }];

	return [adjustedAttributedString copy];
}

@end
