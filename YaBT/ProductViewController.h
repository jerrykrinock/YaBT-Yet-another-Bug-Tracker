#import <UIKit/UIKit.h>

@class Product ;

@interface ProductViewController : UIViewController
{
    IBOutlet UILabel *tableLabel ;
}

@property (strong, nonatomic) Product* product;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@end

