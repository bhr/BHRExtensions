//
//  BHRColorizer.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 5/15/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "BHRColorizer.h"
#import "NSObject+BHRClassesAggregation.h"
#import "BHRColorProvider.h"

@interface BHRColorizer ()

@property (nonatomic, strong) NSMutableDictionary *colorIdentifierMap;

@end

@implementation BHRColorizer


- (instancetype)init
{
    self = [super init];
    if (self)
	{
        _colorIdentifierMap = [NSMutableDictionary dictionary];
		[self _fillMap];
    }
    return self;
}

- (void)_fillMap
{
	NSArray *classNames;

	classNames =[NSObject allClassNamesWithSuffix:@"ColorProvider"
										   prefix:nil
								  subclassOfClass:[BHRColorProvider class]];

	for (NSString *className in classNames)
	{
		BHRColorProvider *instance;
		instance = [[NSClassFromString(className) alloc] init];

		[self.colorIdentifierMap addEntriesFromDictionary:[instance colorIdentifierMap]];
	}

}

#pragma mark - Getter

+ (UIColor *)colorForIdentifier:(NSString *)identifier
{
    return [[BHRColorizer shared] colorForIdentifier:identifier];
}

- (UIColor *)colorForIdentifier:(NSString*)identifier
{
    return [self.colorIdentifierMap objectForKey:identifier];
}


#pragma mark - Singleton

static BHRColorizer *shared = nil;

+ (BHRColorizer *)shared
{
	static dispatch_once_t onceToken;

	dispatch_once(&onceToken, ^{
		shared = [[self alloc] init];
	});

	return shared;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
        if (shared == nil) {
            return [super allocWithZone:zone];
        }
    }

    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}


@end
