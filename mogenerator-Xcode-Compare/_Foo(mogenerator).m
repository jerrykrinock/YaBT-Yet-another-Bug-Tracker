// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Foo.m instead.

#import "_Foo.h"

const struct FooAttributes FooAttributes = {
};

const struct FooRelationships FooRelationships = {
	.children = @"children",
	.parent = @"parent",
};

const struct FooFetchedProperties FooFetchedProperties = {
};

@implementation FooID
@end

@implementation _Foo

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Foo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Foo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Foo" inManagedObjectContext:moc_];
}

- (FooID*)objectID {
	return (FooID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic children;

	
- (NSMutableOrderedSet*)childrenSet {
	[self willAccessValueForKey:@"children"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"children"];
  
	[self didAccessValueForKey:@"children"];
	return result;
}
	

@dynamic parent;

	






@end
