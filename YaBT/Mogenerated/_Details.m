// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Details.m instead.

#import "_Details.h"

const struct DetailsAttributes DetailsAttributes = {
	.steps = @"steps",
};

const struct DetailsRelationships DetailsRelationships = {
	.bug = @"bug",
};

const struct DetailsFetchedProperties DetailsFetchedProperties = {
};

@implementation DetailsID
@end

@implementation _Details

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Details" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Details";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Details" inManagedObjectContext:moc_];
}

- (DetailsID*)objectID {
	return (DetailsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic steps;






@dynamic bug;

	






@end
