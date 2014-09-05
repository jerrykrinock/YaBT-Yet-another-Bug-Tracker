// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Product.h instead.

#import <CoreData/CoreData.h>


extern const struct ProductAttributes {
	__unsafe_unretained NSString *name;
} ProductAttributes;

extern const struct ProductRelationships {
	__unsafe_unretained NSString *bugs;
} ProductRelationships;

extern const struct ProductFetchedProperties {
} ProductFetchedProperties;

@class Bug;



@interface ProductID : NSManagedObjectID {}
@end

@interface _Product : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProductID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSOrderedSet *bugs;

- (NSMutableOrderedSet*)bugsSet;





@end

@interface _Product (CoreDataGeneratedAccessors)

- (void)addBugs:(NSOrderedSet*)value_;
- (void)removeBugs:(NSOrderedSet*)value_;
- (void)addBugsObject:(Bug*)value_;
- (void)removeBugsObject:(Bug*)value_;

@end

@interface _Product (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableOrderedSet*)primitiveBugs;
- (void)setPrimitiveBugs:(NSMutableOrderedSet*)value;


@end
