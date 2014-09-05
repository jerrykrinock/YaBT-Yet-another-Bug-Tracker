// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Foo.h instead.

#import <CoreData/CoreData.h>


extern const struct FooAttributes {
} FooAttributes;

extern const struct FooRelationships {
	__unsafe_unretained NSString *children;
	__unsafe_unretained NSString *parent;
} FooRelationships;

extern const struct FooFetchedProperties {
} FooFetchedProperties;

@class Foo;
@class Foo;


@interface FooID : NSManagedObjectID {}
@end

@interface _Foo : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FooID*)objectID;





@property (nonatomic, strong) NSOrderedSet *children;

- (NSMutableOrderedSet*)childrenSet;




@property (nonatomic, strong) Foo *parent;

//- (BOOL)validateParent:(id*)value_ error:(NSError**)error_;





@end

@interface _Foo (CoreDataGeneratedAccessors)

- (void)addChildren:(NSOrderedSet*)value_;
- (void)removeChildren:(NSOrderedSet*)value_;
- (void)addChildrenObject:(Foo*)value_;
- (void)removeChildrenObject:(Foo*)value_;

@end

@interface _Foo (CoreDataGeneratedPrimitiveAccessors)



- (NSMutableOrderedSet*)primitiveChildren;
- (void)setPrimitiveChildren:(NSMutableOrderedSet*)value;



- (Foo*)primitiveParent;
- (void)setPrimitiveParent:(Foo*)value;


@end
