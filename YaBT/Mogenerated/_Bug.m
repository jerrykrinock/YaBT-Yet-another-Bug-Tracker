// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bug.m instead.

#import "_Bug.h"

const struct BugAttributes BugAttributes = {
	.timestamp = @"timestamp",
	.title = @"title",
};

const struct BugRelationships BugRelationships = {
	.blockees = @"blockees",
	.blockers = @"blockers",
	.details = @"details",
};

const struct BugFetchedProperties BugFetchedProperties = {
};

@implementation BugID
@end

@implementation _Bug

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Bug" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Bug";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Bug" inManagedObjectContext:moc_];
}

- (BugID*)objectID {
	return (BugID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic timestamp;






@dynamic title;






@dynamic blockees;

	
- (NSMutableSet*)blockeesSet {
	[self willAccessValueForKey:@"blockees"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"blockees"];
  
	[self didAccessValueForKey:@"blockees"];
	return result;
}
	

@dynamic blockers;

	
- (NSMutableSet*)blockersSet {
	[self willAccessValueForKey:@"blockers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"blockers"];
  
	[self didAccessValueForKey:@"blockers"];
	return result;
}
	

@dynamic details;

	






@end
