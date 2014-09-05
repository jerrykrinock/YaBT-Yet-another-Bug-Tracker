//
//  Foo.h
//  YaBT
//
//  Created by Jerry on 14/09/04.
//  Copyright (c) 2014 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Foo;

@interface Foo : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *children;
@property (nonatomic, retain) Foo *parent;
@end

@interface Foo (CoreDataGeneratedAccessors)

- (void)insertObject:(Foo *)value inChildrenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChildrenAtIndex:(NSUInteger)idx;
- (void)insertChildren:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChildrenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChildrenAtIndex:(NSUInteger)idx withObject:(Foo *)value;
- (void)replaceChildrenAtIndexes:(NSIndexSet *)indexes withChildren:(NSArray *)values;
- (void)addChildrenObject:(Foo *)value;
- (void)removeChildrenObject:(Foo *)value;
- (void)addChildren:(NSOrderedSet *)values;
- (void)removeChildren:(NSOrderedSet *)values;
@end
