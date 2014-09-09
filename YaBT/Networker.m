#import "Networker.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "YaBTGlobals.h"
#import "Product.h"

@implementation Networker

+ (void)createProductOnTimer:(NSTimer*)timer {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CoreDataStack* coreDataStack = [appDelegate coreDataStack];
    NSString* timestamp = DemoTimestamp() ;
    NSString* contextName = [[NSString alloc] initWithFormat:
                             @"Worker-Context-%@",
                             timestamp] ;
    NSManagedObjectContext* context = [coreDataStack newWorkerContextNamed:contextName];
    Product* product = [Product insertInManagedObjectContext:context];
    [product setName:[[NSString alloc] initWithFormat:@"Networker made at %@", timestamp]] ;
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate.
        // You should not use this function in a shipping application.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

+ (void)startWithInterval:(NSTimeInterval)interval {
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(createProductOnTimer:)
                                   userInfo:nil
                                    repeats:YES] ;
}

@end
