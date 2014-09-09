#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Product.h"
#import "Bug.h"
#import "Details.h"


static NSManagedObjectModel *managedObjectModel()
{
    static NSManagedObjectModel *model = nil;
    if (model != nil) {
        return model;
    }
    
    NSString *path = @"YaBT";
    path = [path stringByDeletingPathExtension];
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathExtension:@"momd"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}

static NSURL *storeURL(void)
{
    NSString *path = [[NSProcessInfo processInfo] arguments][0];
    path = [path stringByDeletingLastPathComponent];
    path = [path stringByAppendingPathComponent:@"FakeData.sqlite"];
    NSURL *url = [NSURL fileURLWithPath:path];
    return url;
}

/* This function creates a complete stack: PS, PSC, MOC */
static NSManagedObjectContext *managedObjectContext()
{
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }
    
    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *psc;
        psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
        [context setPersistentStoreCoordinator:psc];
        
        NSURL *url;
        url = storeURL();
        
        // Remove any prior data
        [[NSFileManager defaultManager] removeItemAtURL:url
                                                  error:NULL] ;
        
        // The following is required when using OS X 10.9+ or iOS 7+ SDK, to
        // ensure that we generate a single .sqlite file, without -shm or -wal
        // files.
        NSDictionary *options = @{
                                  NSSQLitePragmasOption : @{
                                          @"journal_mode" : @"DELETE"} };
        
        NSError *error;
        NSPersistentStore *store;
        store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                  configuration:nil
                                            URL:url
                                        options:options
                                          error:&error];
        
        if (store == nil) {
            NSLog(@"Store Configuration Failure %@",
                  ([error localizedDescription] != nil)
                  ? [error localizedDescription]
                  : @"Unknown Error");
        }
    }
    return context;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool {
       // Create the managed object context
        NSManagedObjectContext *context = managedObjectContext();
        
        NSLog(@"Will make fake data");
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error while saving empty MOC %@",
                  ([error localizedDescription] != nil)
                  ? [error localizedDescription]
                  : @"Unknown Error");
            exit(1);
        }
        
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"FakeData"
                                                             ofType:@"plist"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:dataPath
                                                      options:0 error:&error];
        NSDictionary *productsAndBugs;
        productsAndBugs = [NSPropertyListSerialization propertyListWithData:data
                                                                    options:NSPropertyListImmutable
                                                                     format:NULL
                                                                      error:&error];
        NSArray *bugsInfos = [productsAndBugs objectForKey:@"BugsAndDetails"];
        NSMutableDictionary* bugsByTitle = [[NSMutableDictionary alloc] initWithCapacity:[bugsInfos count]] ;
        [bugsInfos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
#if NO_MOGENERATOR
            Bug *bug = [NSEntityDescription insertNewObjectForEntityForName:@"Bug"
                                                     inManagedObjectContext:context];
#else
            Bug *bug = [Bug insertInManagedObjectContext:context];
#endif
            NSString* title = [obj objectForKey:BugAttributes.title];
            bug.title = title;
            bug.timestamp = [obj objectForKey:BugAttributes.timestamp];
            [bugsByTitle setObject:bug
                            forKey:title] ;

            Details *details = [Details insertInManagedObjectContext:context];
            details.commentary = [obj objectForKey:DetailsAttributes.commentary];
        }];

        NSArray *productInfos = [productsAndBugs objectForKey:@"Products"];
        [productInfos enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Product *product = [Product insertInManagedObjectContext:context];
            product.name = [obj objectForKey:ProductAttributes.name];
            NSArray* bugTitles = [obj objectForKey:ProductRelationships.bugs] ;
            for (NSString* bugTitle in bugTitles) {
                Bug* bug = [bugsByTitle objectForKey:bugTitle] ;
                if (bug) {
                    [bug addProductsObject:product] ;
                    /* Do not set the inverse relationship, because Core Data
                      does it for you! */
                    // [product addBugsObject:bug] ;  <---- NO!!
                }
                else {
                    NSLog(@"Error.  Product '%@' has unlisted bug '%@'",
                          product.name,
                          bugTitle) ;
                }
            }
        }];
        
        if (![context save:&error]) {
            NSLog(@"Error saving moc: %@", [error localizedDescription]);
        }
        else {
            NSLog(@"Successfully created fake database at path:\n   %@",
                  storeURL());
        }
    }

    return 0;
}

