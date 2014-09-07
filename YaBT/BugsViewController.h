#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Product ;

@interface BugsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (strong, nonatomic) Product* product;


@end

