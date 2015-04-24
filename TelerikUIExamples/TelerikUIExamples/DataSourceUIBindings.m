//
//  DataSourceUIBindings.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>

#import "DataSourceUIBindings.h"
#import "DSItem.h"
#import "DSCollectionViewCell.h"

@interface DataSourceUIBindings ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation DataSourceUIBindings

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"TKChart" selector:@selector(useChart)];
        [self addOption:@"TKCalendar" selector:@selector(useCalendar)];
        [self addOption:@"UITableView" selector:@selector(useTableView)];
        [self addOption:@"UICollectionView" selector:@selector(useCollectionView)];
        [self addOption:@"TKListView" selector:@selector(useListView)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:[UIView new]];

    self.title = @"Bind with UI controls";

    NSArray *imageNames = @[ @"CENTCM.jpg", @"FAMIAF.jpg", @"CHOPSF.jpg", @"DUMONF.jpg", @"ERNSHM.jpg", @"FOLIGF.jpg" ];
    NSArray *names = @[ @"John", @"Abby", @"Phill", @"Saly", @"Robert", @"Donna" ];
    NSMutableArray *items = [NSMutableArray new];
    for (int i = 0; i<names.count; i++) {
        UIImage *image = [UIImage imageNamed:imageNames[i]];
        [self addItem:items name:names[i] value:arc4random()%100 group:(arc4random()%100)>50 ? @"two" : @"one" day:arc4random()%10 image:image];
    }
    
    self.dataSource = [TKDataSource new];
    self.dataSource.displayKey = @"name";
    self.dataSource.valueKey = @"value";
    self.dataSource.itemSource = items;
    
    [self useChart];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.view.subviews.count > 1) {
        ((UIView*)self.view.subviews[1]).frame = self.exampleBounds;
    }
}

- (void)addItem:(NSMutableArray*)items name:(NSString*)name value:(CGFloat)value group:(NSString*)group day:(NSInteger)dayOffset image:(UIImage*)image
{
    DSItem *item = [DSItem new];

    item.name = name;
    item.value = value;
    item.group = group;
    item.image = image;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    components.day = dayOffset;
    item.date = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];

    [items addObject:item];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)useChart
{
    if (self.view.subviews.count>1) {
        [self.view.subviews[1] removeFromSuperview];
    }
    
    [self.dataSource.settings.chart createSeries:^TKChartSeries *(TKDataSourceGroup *group) {
        TKChartColumnSeries *series = [TKChartColumnSeries new];
        series.selectionMode = TKChartSeriesSelectionModeDataPoint;
        series.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
        return series;
    }];
    
    TKChart *chart = [[TKChart alloc] initWithFrame:self.exampleBounds];
    chart.dataSource = self.dataSource;
    [self.view addSubview:chart];
}

- (void)useCalendar
{
    if (self.view.subviews.count>1) {
        [self.view.subviews[1] removeFromSuperview];
    }
    
    self.dataSource.settings.calendar.startDateKey = @"date";
    self.dataSource.settings.calendar.endDateKey = @"date";
    self.dataSource.settings.calendar.defaultEventColor = [UIColor redColor];
    
    TKCalendar *calendar = [[TKCalendar alloc] initWithFrame:self.exampleBounds];
    calendar.dataSource = self.dataSource;
    [self.view addSubview:calendar];
    
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)calendar.presenter;
    presenter.inlineEventsViewMode = TKCalendarInlineEventsViewModeInline;
}

- (void)useTableView
{
    if (self.view.subviews.count>1) {
        [self.view.subviews[1] removeFromSuperview];
    }

    // optional
    [self.dataSource.settings.tableView createCell:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath, id item) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        return cell;
    }];
    
    // optional
    [self.dataSource.settings.tableView initCell:^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell, id item) {
        DSItem *dsitem = (DSItem*)item;
        cell.textLabel.text = dsitem.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", dsitem.value];
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.exampleBounds];
    tableView.dataSource = self.dataSource;
    [self.view addSubview:tableView];
}

- (void)useCollectionView
{
    if (self.view.subviews.count>1) {
        [self.view.subviews[1] removeFromSuperview];
    }
    
    [self.dataSource.settings.collectionView createCell:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, id item) {
        DSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }];
    
    [self.dataSource.settings.collectionView initCell:^(UICollectionView *collectionView, NSIndexPath *indexPath, UICollectionViewCell *cell, id item) {
        DSCollectionViewCell *dscell = (DSCollectionViewCell*)cell;
        DSItem *dsitem = (DSItem*)item;
        dscell.label.text = [self.dataSource textFromItem:item inGroup:nil];
        dscell.imageView.image = dsitem.image;
    }];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(140, 140);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.exampleBounds collectionViewLayout:layout];
    [collectionView registerClass:[DSCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.dataSource = self.dataSource;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
}

- (void)useListView
{
    if (self.view.subviews.count>1) {
        [self.view.subviews[1] removeFromSuperview];
    }
    
    TKListView *listView = [[TKListView alloc] initWithFrame:self.exampleBounds];
    listView.dataSource = self.dataSource;
    [self.view addSubview:listView];
}

@end
