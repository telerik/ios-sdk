//
//  DataSourceDocsDictionary.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataSourceDocsDictionary.h"
#import <TelerikUI/TelerikUI.h>

@implementation DataSourceDocsDictionary

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    // >> datasource-dict
    NSDictionary *dict = @{ @"John": @50, @"Abby": @33, @"Smith": @42, @"Peter": @28, @"Paula": @25 };
    TKDataSource *dataSource = [[TKDataSource alloc] initWithItemSource:dict];
    [dataSource sortWithKey:@"" ascending:YES];
    [dataSource filter:^BOOL(id item) {
        return [dict[item] intValue] > 30;
    }];
    // << datasource-dict
}

@end
