//
//  ListViewDocsSetupDataSource.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ListViewDocsSetupDataSource.h"

// >> listview-populating
@implementation ListViewDocsSetupDataSource
{
    NSArray *_sampleArrayOfStrings;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sampleArrayOfStrings =@[@"Kristina Wolfe",@"Freda Curtis",@"Jeffery Francis",@"Eva Lawson",@"Emmett Santos", @"Theresa	Bryan", @"Jenny Fuller", @"Terrell Norris", @"Eric Wheeler", @"Julius Clayton", @"Alfredo Thornton", @"Roberto Romero",@"Orlando 	Mathis",@"Eduardo Thomas",@"Harry Douglas"];
    
    TKListView *_listView = [[TKListView alloc] initWithFrame: self.view.bounds];
    [_listView registerClass:[TKListViewCell class] forCellWithReuseIdentifier:@"cell"];
    _listView.dataSource = self;
    
    [self.view addSubview:_listView];
}

-(NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section  {
    return _sampleArrayOfStrings.count;
}

-(NSInteger)numberOfSectionsInListView:(TKListView *)listView
{
    return 1;
}

- (TKListViewCell *)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _sampleArrayOfStrings[indexPath.row];
    
    return cell;
}
// << listview-populating

@end
