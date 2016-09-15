//
//  DataSourceDocsUIBinding.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataSourceDocsUIBinding.h"
#import "DSItem.h"
#import <TelerikUI/TelerikUI.h>

@interface DataSourceDocsUIBinding ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceDocsUIBinding

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) setupTableView {
    // >> datasource-tableview-ui
    self.dataSource = [[TKDataSource alloc] initWithArray:@[ @10, @5, @12, @7, @44 ]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self.dataSource;
    [self.view addSubview:tableView];
    // << datasource-tableview-ui
    
    // >> datasource-cell-init
    [self.dataSource.settings.tableView initCell:^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, id item) {
        cell.textLabel.text = @"Item:";
        cell.detailTextLabel.text = [self.dataSource textFromItem:item inGroup:nil];
    }];
    // << datasource-cell-init
    
    // >> datasource-cell-create
    [self.dataSource.settings.tableView createCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, id item) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        return cell;
    }];
    // << datasource-cell-create
    
    // >> datasource-cell-group
    [self.dataSource group:^id(id item) {
        return @([item intValue] % 2 == 0);
    }];
    // << datasource-cell-group
}

- (void) setupCollectionView {
    // >> datasource-collectionview-ui
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(140, 140);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 30) collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    collectionView.dataSource = self.dataSource;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    // << datasource-collectionview-ui
    
    // >> datasource-collectionview-cell-init
    [self.dataSource.settings.collectionView initCell:^(UICollectionView *collectionView, NSIndexPath *indexPath, UICollectionViewCell *cell, id item) {
        TKCollectionViewCell *tkcell = (TKCollectionViewCell*)cell;
        tkcell.label.text = [self.dataSource textFromItem:item inGroup:nil];
        tkcell.backgroundColor = [UIColor yellowColor];
    }];
    // << datasource-collectionview-cell-init
}

- (void) setupListView {
    // >> datasource-listview-ui
    TKListView *listView = [[TKListView alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 30)];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    listView.dataSource = self.dataSource;
    [self.view addSubview:listView];
    // << datasource-listview-ui
    
    // >> datasource-listview-cell-create
    [self.dataSource.settings.listView createCell:^TKListViewCell *(TKListView *listView, NSIndexPath *indexPath, id item) {
        return [listView dequeueReusableCellWithReuseIdentifier:@"myCustomCell" forIndexPath:indexPath];
    }];
    [self.dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.textLabel.text = [self.dataSource textFromItem:item inGroup:nil];
        ((TKView*)cell.backgroundView).fill = [TKSolidFill solidFillWithColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
    }];
    // << datasource-listview-cell-create
}

- (void) setupChart {
    // >> datasource-chart-ui
    NSMutableArray *items = [NSMutableArray new];
    
    [items addObject:[[DSItem alloc] initWithName:@"John" value:50 group:@"A"]];
    [items addObject:[[DSItem alloc] initWithName:@"Abby" value:33 group:@"A"]];
    [items addObject:[[DSItem alloc] initWithName:@"Paula" value:33 group:@"A"]];
    
    [items addObject:[[DSItem alloc] initWithName:@"John" value:42 group:@"B"]];
    [items addObject:[[DSItem alloc] initWithName:@"Abby" value:28 group:@"B"]];
    [items addObject:[[DSItem alloc] initWithName:@"Paula" value:25 group:@"B"]];
    
    self.dataSource.displayKey = @"name";
    self.dataSource.valueKey = @"value";
    self.dataSource.itemSource = items;
    
    TKChart *chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    chart.dataSource = self.dataSource;
    [self.view addSubview:chart];
    // << datasource-chart-ui
    
    // >> datasource-chart-series
    [self.dataSource groupWithKey:@"group"];
    
    [self.dataSource.settings.chart createSeries:^TKChartSeries *(TKDataSourceGroup *group) {
        TKChartColumnSeries *series = [TKChartColumnSeries new];
        return series;
    }];
    // << datasource-chart-series
}

- (void) setupCalendar {
    NSMutableArray *items = [NSMutableArray new];
    
    // >> datasource-calendar-ui
    self.dataSource.displayKey = @"name";
    self.dataSource.settings.calendar.startDateKey = @"startDate";
    self.dataSource.settings.calendar.endDateKey = @"endDate";
    self.dataSource.settings.calendar.defaultEventColor = [UIColor redColor];
    self.dataSource.itemSource = items;
    
    TKCalendar *calendar = [[TKCalendar alloc] initWithFrame:CGRectInset(self.view.bounds, 0, 30)];
    calendar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    calendar.dataSource = self.dataSource;
    [self.view addSubview:calendar];
    // << datasource-calendar-ui
}

@end
