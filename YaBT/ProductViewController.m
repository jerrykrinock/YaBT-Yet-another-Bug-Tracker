#import "ProductViewController.h"
#import "YaBTGlobals.h"
#import "Product.h"

@interface ProductViewController ()

@end

@implementation ProductViewController
            
#pragma mark - Managing the detail item

- (void)setProduct:(Product*)product {
   if (_product != product) {
        _product = product;
            
        // Update the view.
       /*SSYDBL*/ NSLog(@"Will configure for new product (%@)", [product shortDescription]) ;
        [self configureView];
       /*SSYDBL*/ NSLog(@"Did configure for new product") ;
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.product) {
       // self.detailDescriptionLabel.text = [[self.detailItem valueForKey:BugAttributes.timestamp] description];
        NSString* tableLabelText = [[NSString alloc] initWithFormat:
                           @"%ld Bugs",
                           self.product.bugs.count] ;
        /*SSYDBL*/ NSLog(@"Setting title of %@ to: %@", self.navigationItem, tableLabelText) ;
        tableLabel.text = tableLabelText ;
        self.navigationItem.title = [[self product] name] ;
    }
    else {/*SSYDBL*/ NSLog(@"WHOOPS  nil product") ;}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*SSYDBL*/ NSLog(@"Will configure due to load") ;
    [self configureView];
    /*SSYDBL*/ NSLog(@"Did configure due to load") ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
