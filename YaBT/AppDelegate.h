#import <UIKit/UIKit.h>

@class CoreDataStack ;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    CoreDataStack* _coreDataStack ;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) CoreDataStack *coreDataStack;

@end

