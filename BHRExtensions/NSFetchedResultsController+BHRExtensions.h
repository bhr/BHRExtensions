//
//  NSFetchedResultsController+BHRExtensions.h
//  BHRExtensions
//
//  Created by Benedikt Hirmer on 3/13/14.
//  Copyright (c) 2014 HIRMER.me. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface NSFetchedResultsController (BHRExtensions)

- (void)moveObjectAtIndexPath:(NSIndexPath *)sourceIndexPath
				  toIndexPath:(NSIndexPath *)destinationIndexPath;

- (void)deleteObjectsAtIndexPaths:(NSArray *)indexPaths;

- (NSArray *)objectsAtIndexPaths:(NSArray *)indexPaths;

- (void)flattenObjectsWithSortingKey:(NSString *)sortingKey;


- (id)nextObjectForObject:(id)object;
- (id)previousObjectForObject:(id)object;
- (BOOL)isLastInSection:(NSIndexPath *)indexPath;
- (BOOL)isFirstInSection:(NSIndexPath *)indexPath;
- (BOOL)isLastSection:(NSUInteger)section;
- (BOOL)isFirstSection:(NSUInteger)section;
- (NSUInteger)nextSectionForSection:(NSUInteger)section;
- (NSUInteger)previousSectionForSection:(NSUInteger)section;
- (NSIndexPath *)nextIndexPathForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)previousIndexPathForIndexPath:(NSIndexPath *)indexPath;

@end
