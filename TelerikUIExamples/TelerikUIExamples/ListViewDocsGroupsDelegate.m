//
//  ListViewDocsGroupsDelegate.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ListViewDocsGroupsDelegate.h"
#import "DataSourceItem.h"

// >> listview-groups-delegate
@implementation ListViewDocsGroupsDelegate
{
    NSMutableArray *_items;
    NSArray *_groups;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _groups= @[@[@"John",@"Abby"],@[@"Smith",@"Peter",@"Paula"]];
    
    _items = [NSMutableArray new];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"John" value:50 group:@"A"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Abby" value:33 group:@"A"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Smith" value:42 group:@"B"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Peter" value:28 group:@"B"]];
    [_items addObject:[[DataSourceItem alloc] initWithName:@"Paula" value:25 group:@"B"]];

    TKListView *_listView = [[TKListView alloc] initWithFrame: CGRectMake(20, 20, self.view.bounds.size.width-40,self.view.bounds.size.height-40)];
    
    [_listView registerClass:[TKListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [_listView registerClass:[TKListViewHeaderCell class] forSupplementaryViewOfKind:TKListViewElementKindSectionHeader withReuseIdentifier:@"header"];
    
    _listView.dataSource = self;
    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)_listView.layout;
    layout.headerReferenceSize = CGSizeMake(200, 22);
    
    [self.view addSubview:_listView];
}

-(NSInteger) numberOfSectionsInListView:(TKListView *)listView
{
    return _groups.count;
}

-(NSInteger) listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray*)_groups[section]).count;
}

-(TKListViewCell*) listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _groups[indexPath.section][indexPath.row];
    
    return cell;
}

-(TKListViewReusableCell*) listView:(TKListView *)listView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TKListViewReusableCell *headerCell = [listView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    headerCell.textLabel.text = [NSString stringWithFormat:@"Group %li",indexPath.section];
    return headerCell;
}

@end
// << listview-groups-delegate