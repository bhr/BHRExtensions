//
//  NSFetchedResultsController+BHRExtensions.m
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import "NSFetchedResultsController+BHRExtensions.h"
#import "BHRCoreDataErrorManager.h"

@implementation NSFetchedResultsController (BHRExtensions)


- (void)moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath
				  toIndexPath:(NSIndexPath *)destinationIndexPath
{
	NSMutableArray *objects = [[self fetchedObjects] mutableCopy];
	
	NSManagedObject *movedObject = [self objectAtIndexPath:sourceIndexPath];
	
	// Remove the object we're moving from the array.
	[objects removeObject:movedObject];
	// Now re-insert it at the destination.
	[objects insertObject:movedObject atIndex:[destinationIndexPath row]];
	
	// All of the objects are now in their correct order. Update each
	// object's displayOrder field by iterating through the array.
	int i = 0;
	for (NSManagedObject *object in objects)
	{
		[object setValue:@(i++) forKey:@"sortIndex"];
	}
	
	NSError *error = nil;
	if (![[self managedObjectContext] save:&error])
	{
		[[BHRCoreDataErrorManager sharedManager] showErrorAlert];
	}
}

- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths
{
	NSManagedObjectContext *context = [self managedObjectContext];
	
	for (NSIndexPath *indexPath in indexPaths)
	{
        NSManagedObject *object = [self objectAtIndexPath:indexPath];
        if (object)
        {
            [context deleteObject:object];
        }
	}
	
	// Save the context.
	NSError *error = nil;
	if (![context save:&error])
	{
		[[BHRCoreDataErrorManager sharedManager] showErrorAlert];
	}
}


@end
