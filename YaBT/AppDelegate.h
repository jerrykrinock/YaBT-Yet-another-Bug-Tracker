#import <UIKit/UIKit.h>

@class CoreDataStack ;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    // Readonly property with non-default getter requires declaration…
    CoreDataStack* _coreDataStack ;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) CoreDataStack *coreDataStack;

@end

