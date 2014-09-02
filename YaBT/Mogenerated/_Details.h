// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Details.h instead.

#import <CoreData/CoreData.h>


extern const struct DetailsAttributes {
	__unsafe_unretained NSString *steps;
} DetailsAttributes;

extern const struct DetailsRelationships {
	__unsafe_unretained NSString *bug;
} DetailsRelationships;

extern const struct DetailsFetchedProperties {
} DetailsFetchedProperties;

@class Bug;



@interface DetailsID : NSManagedObjectID {}
@end

@interface _Details : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (DetailsID*)objectID;





@property (nonatomic, strong) NSString* steps;



//- (BOOL)validateSteps:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Bug *bug;

//- (BOOL)validateBug:(id*)value_ error:(NSError**)error_;





@end

@interface _Details (CoreDataGeneratedAccessors)

@end

@interface _Details (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveSteps;
- (void)setPrimitiveSteps:(NSString*)value;





- (Bug*)primitiveBug;
- (void)setPrimitiveBug:(Bug*)value;


@end
