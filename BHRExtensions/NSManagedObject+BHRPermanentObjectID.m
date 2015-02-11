//
//  NSManagedObject+BHRPermanentObjectID.m
//  
//
//  Created by Benedikt Hirmer on 2/11/15.
//
//

#import "NSManagedObject+BHRPermanentObjectID.h"

@implementation NSManagedObject (BHRPermanentObjectID)

- (NSManagedObjectID*)permanentObjectID
{
    NSManagedObjectID *objectID = nil;
    objectID = [self objectID];

    if ([objectID isTemporaryID]) {
        NSError *error = nil;

        [[self managedObjectContext] obtainPermanentIDsForObjects:@[self]
                                                            error:&error];

        if (error != nil) {
            NSLog(@"Could not obtain permanent ID for object %@ because of error %@", self, error);
            objectID = nil;
        }else {
            objectID = [self objectID];
        }
    }
    
    return objectID;
}


@end
