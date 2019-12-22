//
//  NSManagedObject+BHRPermanentObjectID.h
//  
//
//  Created by Benedikt Hirmer on 2/11/15.
//
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (BHRPermanentObjectID)

- (NSManagedObjectID*)permanentObjectID;

@end
