//
//  Product.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "Product.h"

@implementation Product

- (instancetype)init
{
    self = [super init];
    if (self) {
        _productID = [[NSUUID UUID] UUIDString];
    }
    return self;
}
@end
