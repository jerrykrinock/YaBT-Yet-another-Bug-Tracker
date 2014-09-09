#import "CoreDataStack.h"
#import "YaBTGlobals.h"

@interface CoreDataStack ()

- (NSURL *)applicationDocumentsDirectory;

@end


@implementation CoreDataStack

// These are required for readonly properties with custom getters
@synthesize rootContext = _rootContext;
@synthesize mainContext = _mainContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sheepsystems.YaBT" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"YaBT" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSError* error = nil;
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"YaBT.sqlite"];
    
    // If database is not found, replace with fake data
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSURL *fakeDataURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"FakeData"
                                                                                    ofType:@"sqlite"]];
        
        if (![[NSFileManager defaultManager] copyItemAtURL:fakeDataURL
                                                     toURL:storeURL
                                                     error:&error]) {
            NSLog(@"Failed initializing with fake data %@", error);
        }
    }
    
    
    error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:YaBTErrorDomain
                                    code:0001
                                userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)rootContext {
    // Returns the highest-level moc for the application
    // (which is already bound to the psc for the application.)
    if (!_rootContext) {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator) {
            _rootContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [_rootContext setPersistentStoreCoordinator:coordinator];
            [_rootContext setName:@"Root-Context"] ;
            /*SSYDBL*/ NSLog(@"Created moc: %@", _rootContext) ;
        }
        else {
            // Fail
            _rootContext = nil ;
        }
    }

    return _rootContext;
}

- (NSManagedObjectContext *)mainContext {
    if (!_mainContext) {
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType] ;
        // Because this is not a root context, instead of
        //   setting a psc, we set a parentContext
        [_mainContext setParentContext:[self rootContext]] ;
        [_mainContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy] ;
        [_mainContext setName:@"Main-Context"] ;
        /*SSYDBL*/ NSLog(@"Created moc: %@", _mainContext) ;
    }
    
    return _mainContext ;
}

- (NSManagedObjectContext *)newWorkerContextNamed:(NSString*)name {
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType] ;
    [context setParentContext:[self mainContext]] ;
    [context setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy] ;
    [context setName:name] ;
    /*SSYDBL*/ NSLog(@"Created moc: %@", context) ;

    return context ;
}


- (id)init {
    self = [super init] ;
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(contextDidSave:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil] ;
    }
    
    return self ;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self] ;
}

- (void)contextDidSave:(NSNotification*)note {
    NSManagedObjectContext* savedContext = [note object] ;
    /*SSYDBL*/ NSLog(@"Context %@ did save", [savedContext name]) ;
    NSManagedObjectContext* parentContext = [savedContext parentContext] ;
    if (parentContext) {
        [self saveContext:parentContext] ;
    }
}

- (void)saveContext:(NSManagedObjectContext*)context {
    if (context != nil) {
#if 0
#warning Whoops, forgot to wrap moc save in -performBlock:
        [self unsafeSaveContext:context];
#else
        [context performBlock:^{
            [self unsafeSaveContext:context];
        }];
#endif
    }
}

- (void)unsafeSaveContext:(NSManagedObjectContext *)context {
    if ([context hasChanges]) {
        NSError* error = nil ;
        BOOL ok ;
        
        ok = [context obtainPermanentIDsForObjects:[[context insertedObjects] allObjects]
                                             error:&error] ;
        if (!ok) {
            // You'll do something better in a real app.
            /*SSYDBL*/ NSLog(@"Error permanentizing %@, %@", error, [error userInfo]);
            abort();
        }
        
        ok = [context save:&error] ;
        if (!ok) {
            // You'll do something better in a real app.
            /*SSYDBL*/ NSLog(@"Error saving %@, %@", error, [error userInfo]);
            abort();
        }
    }
    else {/*SSYDBL*/ NSLog(@"Skipped saving unchanged context %@", [context name]) ; }
}

- (void)saveRootContext {
    [self saveContext:[self rootContext]] ;
}

- (void)saveMainContext {
    [self saveContext:[self mainContext]] ;
}

@end

