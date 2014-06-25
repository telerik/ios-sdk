//
//  Product.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

//the entity class used for persistence
//NOTE:For synchronization example you have to create the corresponding Product type in Telerik Platform
//     Not forget to create the SyncLock type too
@interface Product : NSObject

//NOTE:we use UUID string as unique value for primary key
//You can use integer primitive type with autoincremental behaviour too,
//but cloud synchronization requires global uniqueness for primary keys.
@property (strong, nonatomic) NSString *productID;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *manufacturer;

@property (nonatomic) float price;

@property (nonatomic) long int quantity;

@property (strong, nonatomic) NSDate* dateOfPurchase;

-(instancetype) init;
@end