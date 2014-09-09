#import "NetWorker.h"
#import "AppDelegate.h"
#import "CoreDataStack.h"
#import "YaBTGlobals.h"
#import "Product.h"

@implementation NetWorker

+ (void)createProductOnTimer:(NSTimer*)timer {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    CoreDataStack* coreDataStack = [appDelegate coreDataStack];
    NSString* timestamp = DemoTimestamp() ;
    NSString* contextName = [[NSString alloc] initWithFormat:
                             @"Worker-Context-%@",
                             timestamp] ;
    NSManagedObjectContext* context = [coreDataStack newWorkerContextNamed:contextName];
    [context performBlock:^{
        Product* product = [Product insertInManagedObjectContext:context];
        [product setName:[[NSString alloc] initWithFormat:@"NetWorker made at %@", timestamp]] ;
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }];
}

+ (void)startWithInterval:(NSTimeInterval)interval {
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(createProductOnTimer:)
                                   userInfo:nil
                                    repeats:YES] ;
}

@end
