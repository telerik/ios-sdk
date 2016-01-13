//
//  ListViewPerformance.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "ListViewPerformance.h"
#import "LoremIpsumGenerator.h"
#import "ListViewDynamicHeightCell.h"

@interface ListViewPerformance () <TKListViewDataSource>

@property (nonatomic, weak) TKListView *listView;

@end

@implementation ListViewPerformance
{
    NSMutableArray *_items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LoremIpsumGenerator *generator = [LoremIpsumGenerator new];
    _items = [[NSMutableArray alloc] initWithCapacity:10000];
    for (int i = 0; i<10000; i++) {
        [_items addObject:[generator generateString:3 + arc4random()%50 + arc4random()%30]];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, self.view.center.y - 22, CGRectGetWidth(self.view.frame)-40, 44);
    button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [button setTitle:@"Load 10000 items" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadItemsTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)loadItemsTouched:(UIButton*)sender
{
    CGFloat systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (systemVersion < 9) {
        TKAlert *alert = [TKAlert new];
        alert.title = @"Telerik UI";
        alert.message = @"TKListView is optimized for performance when using dynamic item sizing only when running on iOS 9 and upper!";
        [alert addAction:[TKAlertAction actionWithTitle:@"OK" handler:^BOOL(TKAlert * _Nonnull alert, TKAlertAction * _Nonnull action) {
            [self createListView];
            return YES;
        }]];
        [alert show:YES];
    }
    else {
        [self createListView];
    }

    [sender removeFromSuperview];
}

- (void)createListView
{
    TKListView *listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [listView registerClass:[ListViewDynamicHeightCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:listView];

    TKListViewLinearLayout *layout = (TKListViewLinearLayout*)listView.layout;
    layout.dynamicItemSize = YES;
    
    listView.dataSource = self;
    
    self.listView = listView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TKListViewDataSource

- (NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (TKListViewCell *)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewDynamicHeightCell *cell = (ListViewDynamicHeightCell*)[listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = _items[indexPath.row];
    return cell;
}

@end
