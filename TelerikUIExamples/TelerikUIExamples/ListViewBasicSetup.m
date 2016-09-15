//
//  ListViewBaseicSetup.m
//  TelerikUIExamples

//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ListViewBasicSetup.h"
#import <TelerikUI/TelerikUI.h>

// >> listview-populating-ds
@implementation ListViewBasicSetup
{
    TKDataSource *_dataSource;
    NSArray *_sampleArrayOfStrings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // >> listview-feed
    _sampleArrayOfStrings =@[@"Kristina Wolfe",@"Freda Curtis",@"Jeffery Francis",@"Eva Lawson",@"Emmett Santos", @"Theresa	Bryan", @"Jenny Fuller", @"Terrell Norris", @"Eric Wheeler", @"Julius Clayton", @"Alfredo Thornton", @"Roberto Romero",@"Orlando Mathis",@"Eduardo Thomas",@"Harry Douglas"];
    // << listview-feed
    
    // >> listview-feed-ds
    _dataSource = [[TKDataSource alloc] initWithArray:_sampleArrayOfStrings];
    // << listview-feed-ds
    
    // >> listview-init
    TKListView *_listView = [[TKListView alloc] initWithFrame: CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-20)];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    [self.view addSubview:_listView];
    // << listview-init
    
    // >> listview-init-selec
    _listView.allowsMultipleSelection = YES;
    // << listview-init-selec
    
    // >> listview-init-reorder
    _listView.allowsCellReorder = YES;
    // << listview-init-reorder

}

@end
// << listview-populating-ds
