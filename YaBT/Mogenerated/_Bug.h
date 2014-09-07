// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Bug.h instead.

#import <CoreData/CoreData.h>


extern const struct BugAttributes {
	__unsafe_unretained NSString *timestamp;
	__unsafe_unretained NSString *title;
} BugAttributes;

extern const struct BugRelationships {
	__unsafe_unretained NSString *blockees;
	__unsafe_unretained NSString *blockers;
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *products;
} BugRelationships;

extern const struct BugFetchedProperties {
} BugFetchedProperties;

@class Bug;
@class Bug;
@class Details;
@class Product;




@interface BugID : NSManagedObjectID {}
@end

@interface _Bug : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BugID*)objectID;





@property (nonatomic, strong) NSDate* timestamp;



//- (BOOL)validateTimestamp:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *blockees;

- (NSMutableSet*)blockeesSet;




@property (nonatomic, strong) NSSet *blockers;

- (NSMutableSet*)blockersSet;




@property (nonatomic, strong) Details *details;

//- (BOOL)validateDetails:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;





@end

@interface _Bug (CoreDataGeneratedAccessors)

- (void)addBlockees:(NSSet*)value_;
- (void)removeBlockees:(NSSet*)value_;
- (void)addBlockeesObject:(Bug*)value_;
- (void)removeBlockeesObject:(Bug*)value_;

- (void)addBlockers:(NSSet*)value_;
- (void)removeBlockers:(NSSet*)value_;
- (void)addBlockersObject:(Bug*)value_;
- (void)removeBlockersObject:(Bug*)value_;

- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(Product*)value_;
- (void)removeProductsObject:(Product*)value_;

@end

@interface _Bug (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveTimestamp;
- (void)setPrimitiveTimestamp:(NSDate*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveBlockees;
- (void)setPrimitiveBlockees:(NSMutableSet*)value;



- (NSMutableSet*)primitiveBlockers;
- (void)setPrimitiveBlockers:(NSMutableSet*)value;



- (Details*)primitiveDetails;
- (void)setPrimitiveDetails:(Details*)value;



- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;


@end
