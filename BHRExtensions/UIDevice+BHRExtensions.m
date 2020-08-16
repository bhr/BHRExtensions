//
//  UIDevice+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 4/9/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "UIDevice+BHRExtensions.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (BHRExtensions)

#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);

    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);

    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];

    free(answer);
    return results;
}

- (NSString *)platform
{
    return [self getSysInfoByName:"hw.machine"];
}

#pragma mark -

#pragma mark platform type and name utils
- (UIDevicePlatform) platformType
{
    NSString *platform = [self platform];

    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return UIDeviceIFPGA;

    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return UIDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return UIDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return UIDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return UIDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return UIDevice4SiPhone;
	if ([platform hasPrefix:@"iPhone5,3"])          return UIDevice5CiPhone;
	if ([platform hasPrefix:@"iPhone5,4"])          return UIDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone5"])            return UIDevice5iPhone;
	if ([platform hasPrefix:@"iPhone6"])			return UIDevice5SiPhone;
	if ([platform hasPrefix:@"iPhone7,2"])			return UIDevice6iPhone;
	if ([platform hasPrefix:@"iPhone7,1"])			return UIDevice6PlusiPhone;

    // iPod
    if ([platform hasPrefix:@"iPod1"])              return UIDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return UIDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return UIDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return UIDevice4GiPod;
	if ([platform hasPrefix:@"iPod5"])              return UIDevice5GiPod;

    // iPad
    if ([platform hasPrefix:@"iPad1"])              return UIDevice1GiPad;
    if ([platform hasPrefix:@"iPad2"])              return UIDevice2GiPad;

	if ([platform hasPrefix:@"iPad3,4"])            return UIDevice4GiPad;
	if ([platform hasPrefix:@"iPad3,5"])            return UIDevice4GiPad;
	if ([platform hasPrefix:@"iPad3,6"])            return UIDevice4GiPad;

    if ([platform hasPrefix:@"iPad3"])              return UIDevice3GiPad;

	if ([platform hasPrefix:@"iPad2,5"])            return UIDevice1GiPadMini;
	if ([platform hasPrefix:@"iPad2,6"])            return UIDevice1GiPadMini;
	if ([platform hasPrefix:@"iPad2,7"])            return UIDevice1GiPadMini;

	if ([platform hasPrefix:@"iPad4,4"])            return UIDevice2GiPadMini;
	if ([platform hasPrefix:@"iPad4,5"])            return UIDevice2GiPadMini;
	if ([platform hasPrefix:@"iPad4"])				return UIDevice1GiPadAir;

    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return UIDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return UIDeviceAppleTV3;

    if ([platform hasPrefix:@"iPhone"])             return UIDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return UIDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return UIDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return UIDeviceUnknownAppleTV;

    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = [[UIScreen mainScreen] bounds].size.width < 768;
        return smallerScreen ? UIDeviceSimulatoriPhone : UIDeviceSimulatoriPad;
    }

    return UIDeviceUnknown;
}

- (NSString *) platformString
{
    switch ([self platformType])
    {
        case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
        case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
        case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
        case UIDevice4iPhone: return IPHONE_4_NAMESTRING;
        case UIDevice4SiPhone: return IPHONE_4S_NAMESTRING;
        case UIDevice5iPhone: return IPHONE_5_NAMESTRING;
		case UIDevice5CiPhone: return IPHONE_5C_NAMESTRING;
		case UIDevice5SiPhone: return IPHONE_5S_NAMESTRING;
		case UIDevice6iPhone: return IPHONE_6_NAMESTRING;
		case UIDevice6PlusiPhone: return IPHONE_6Plus_NAMESTRING;
        case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;

        case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
        case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
        case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
        case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
		case UIDevice5GiPod: return IPOD_5G_NAMESTRING;
        case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;

        case UIDevice1GiPad : return IPAD_1G_NAMESTRING;
        case UIDevice2GiPad : return IPAD_2G_NAMESTRING;
        case UIDevice3GiPad : return IPAD_3G_NAMESTRING;
        case UIDevice4GiPad : return IPAD_4G_NAMESTRING;
		case UIDevice1GiPadAir: return IPAD_Air_1G_NAMESTRING;
		case UIDevice1GiPadMini: return IPAD_MINI_1G_NAMESTRING;
		case UIDevice2GiPadMini: return IPAD_MINI_2G_NAMESTRING;
        case UIDeviceUnknowniPad : return IPAD_UNKNOWN_NAMESTRING;

        case UIDeviceAppleTV2 : return APPLETV_2G_NAMESTRING;
        case UIDeviceAppleTV3 : return APPLETV_3G_NAMESTRING;
        case UIDeviceAppleTV4 : return APPLETV_4G_NAMESTRING;
        case UIDeviceUnknownAppleTV: return APPLETV_UNKNOWN_NAMESTRING;

        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
        case UIDeviceSimulatoriPhone: return SIMULATOR_IPHONE_NAMESTRING;
        case UIDeviceSimulatoriPad: return SIMULATOR_IPAD_NAMESTRING;
        case UIDeviceSimulatorAppleTV: return SIMULATOR_APPLETV_NAMESTRING;

        default: return IOS_FAMILY_UNKNOWN_DEVICE;
    }
}

- (BOOL)isiPad
{
    return (self.userInterfaceIdiom == UIUserInterfaceIdiomPad);
}

- (UIDeviceScreenSize)screenSizeType
{
    switch ([self platformType])
    {
        case UIDevice1GiPhone: return UIDeviceScreenSize35Inch;
        case UIDevice3GiPhone: return UIDeviceScreenSize35Inch;
        case UIDevice3GSiPhone: return UIDeviceScreenSize35Inch;
        case UIDevice4iPhone: return UIDeviceScreenSize35Inch;
        case UIDevice4SiPhone: return UIDeviceScreenSize35Inch;
        case UIDevice5iPhone: return UIDeviceScreenSize4Inch;
        case UIDevice5CiPhone: return UIDeviceScreenSize4Inch;
        case UIDevice5SiPhone: return UIDeviceScreenSize4Inch;
        case UIDevice6iPhone: return UIDeviceScreenSize47Inch;
        case UIDevice6PlusiPhone: return UIDeviceScreenSize55Inch;

        case UIDevice1GiPod: return UIDeviceScreenSize35Inch;
        case UIDevice2GiPod: return UIDeviceScreenSize35Inch;
        case UIDevice3GiPod: return UIDeviceScreenSize35Inch;
        case UIDevice4GiPod: return UIDeviceScreenSize35Inch;
        case UIDevice5GiPod: return UIDeviceScreenSize4Inch;

        case UIDevice1GiPad : return UIDeviceScreenSize97Inch;
        case UIDevice2GiPad : return UIDeviceScreenSize97Inch;
        case UIDevice3GiPad : return UIDeviceScreenSize97Inch;
        case UIDevice4GiPad : return UIDeviceScreenSize97Inch;
        case UIDevice1GiPadAir: return UIDeviceScreenSize97Inch;
        case UIDevice1GiPadMini: return UIDeviceScreenSize79Inch;
        case UIDevice2GiPadMini: return UIDeviceScreenSize79Inch;

        default: return UIDeviceScreenSizeUnknown;
    }
}

@end
