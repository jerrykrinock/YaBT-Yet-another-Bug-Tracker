// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Details.m instead.

#import "_Details.h"

const struct DetailsAttributes DetailsAttributes = {
	.commentary = @"commentary",
	.severity = @"severity",
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
	
	if ([key isEqualToString:@"severityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"severity"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic commentary;






@dynamic severity;



- (int16_t)severityValue {
	NSNumber *result = [self severity];
	return [result shortValue];
}

- (void)setSeverityValue:(int16_t)value_ {
	[self setSeverity:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveSeverityValue {
	NSNumber *result = [self primitiveSeverity];
	return [result shortValue];
}

- (void)setPrimitiveSeverityValue:(int16_t)value_ {
	[self setPrimitiveSeverity:[NSNumber numberWithShort:value_]];
}





@dynamic bug;

	






@end
