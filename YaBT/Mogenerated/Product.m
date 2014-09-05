#import "Product.h"


@interface Product ()

@end


@implementation Product

- (NSString*)shortDescription {
    return [[NSString alloc] initWithFormat:
            @"Product named %@",
            [self name]] ;
}

@end
