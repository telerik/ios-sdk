//
//  ListViewSwipe.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ListViewSwipe.h"
#import <TelerikUI/TelerikUI.h>
#import "LoremIpsumGenerator.h"

@interface ListViewSwipe () <TKListViewDelegate>

@end

@implementation ListViewSwipe
{
    LoremIpsumGenerator *_loremIpsum;
    TKListView *_listView;
    TKDataSource *_dataSource;
    BOOL _buttonAnimationEnabled;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"YES" selector:@selector(enableButtonAnimation) inSection:@"Animate buttons"];
        [self addOption:@"NO" selector:@selector(disableButtonAnimation) inSection:@"Animate buttons"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _loremIpsum = [LoremIpsumGenerator new];
    _buttonAnimationEnabled = YES;
    
    NSDictionary *mails = @{
                            @"Joyce Dean": @"Sales report for January",
                            @"Joel Robertson": @"Planned network mainternance",
                            @"Sherman Martin": @"IT help desk",
                            @"Lela Richardson": @"Summaries of my interviews with customers",
                            @"Jackie Maldonado": @"REMAINDER: corporate meeting",
                            @"Kathryn Byrd": @"Stock options",
                            @"Ervin Powers": @"Thank you!",
                            @"Leland Warner": @"Meeting with Jack",
                            @"Nicholas Bowers": @"Please share these articles",
                            @"Alex Soto": @"Additional information for Jack",
                            @"Naomi Carson": @"Miss you!",
                            @"Rufus Edwards": @"Training",
                            @"Ian Ellis": @"Do you like this blog article?",
                            @"Pat Vasquez": @"The latest UI design",
                            @"Chelsea Burton": @"Need this article!",
                            @"Karl Bates": @"Training update",
                            @"Evan Rivera": @"Safety instructions",
                            @"Tony Lawson": @"Missed our converstation",
                            @"Wallace Little": @"Swift is awessome",
                            @"Carrie Tran": @"Missed conference call with Jack",
                            @"Tyler Washington": @"HR question",
                            @"Dominick Holloway": @"Wellcome!",
                            @"Clark Sharp": @"Important question!"
                            };
    
    _dataSource = [[TKDataSource alloc] initWithItemSource:mails];
    
    [_dataSource.settings.listView createCell:^TKListViewCell *(TKListView *listView, NSIndexPath *indexPath, id item) {
       
        TKListViewCell *cell = [listView dequeueReusableCellWithReuseIdentifier:@"defaultCell" forIndexPath:indexPath];

        if (cell.swipeBackgroundView.subviews.count == 0) {
           
            CGSize size = cell.frame.size;
            UIFont *font = [UIFont systemFontOfSize:14];
            
            UIButton *bMore = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 180, 0, 60, size.height)];
            [bMore setTitle:@"More" forState:UIControlStateNormal];
            [bMore setBackgroundColor:[UIColor lightGrayColor]];
            bMore.titleLabel.font = font;
            [bMore addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
            [cell.swipeBackgroundView addSubview:bMore];

            UIButton *bFlag = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 120, 0, 60, size.height)];
            [bFlag setTitle:@"Flag" forState:UIControlStateNormal];
            [bFlag setBackgroundColor:[UIColor orangeColor]];
            bFlag.titleLabel.font = font;
            [bFlag addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
            [cell.swipeBackgroundView addSubview:bFlag];

            UIButton *bTrash = [[UIButton alloc] initWithFrame:CGRectMake(size.width - 60, 0, 60, size.height)];
            [bTrash setTitle:@"Trash" forState:UIControlStateNormal];
            [bTrash setBackgroundColor:[UIColor redColor]];
            bTrash.titleLabel.font = font;
            [bTrash addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
            [cell.swipeBackgroundView addSubview:bTrash];
            
            UIButton *bUnread = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, size.height)];
            [bUnread setTitle:@"Mark as Unread" forState:UIControlStateNormal];
            [bUnread setBackgroundColor:[UIColor blueColor]];
            bUnread.titleLabel.font = font;
            bUnread.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            bUnread.titleLabel.textAlignment = NSTextAlignmentCenter;
            [bUnread addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
            [cell.swipeBackgroundView addSubview:bUnread];
        }
        
        return cell;
    }];
    
    [_dataSource.settings.listView initCell:^(TKListView *listView, NSIndexPath *indexPath, TKListViewCell *cell, id item) {
        cell.textLabel.text = item;
        NSDictionary *dict = _dataSource.itemSource;
        cell.detailTextLabel.attributedText = [self attributedMailText:dict[item]];
        cell.contentInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    }];
    
    _listView = [[TKListView alloc] initWithFrame:self.view.bounds];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.delegate = self;
    _listView.dataSource = _dataSource;
    _listView.allowsCellSwipe = YES;
    _listView.cellSwipeLimits = UIEdgeInsetsMake(0, 60, 0, 180);//how far the cell may swipe
    _listView.cellSwipeTreshold = 30; //the treshold after which the cell will autoswipe to the end and will not jump back to the center.
    ((TKListViewLinearLayout*)_listView.layout).itemSize = CGSizeMake(100, 80);
    
    [self.view addSubview:_listView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enableButtonAnimation
{
    _buttonAnimationEnabled = YES;
    [_listView reloadData];
}

- (void)disableButtonAnimation
{
    _buttonAnimationEnabled = NO;
    [_listView reloadData];
}

- (void)buttonTouched
{
    [_listView endSwipe:YES];
}

- (void)animateButtonsInCell:(TKListViewCell*)cell widthOffset:(CGPoint)offset
{
    if (offset.x > 0) {
        return;
    }
    
    UIButton *bMore = cell.swipeBackgroundView.subviews[0];
    UIButton *bFlag = cell.swipeBackgroundView.subviews[1];
    UIButton *bTrash = cell.swipeBackgroundView.subviews[2];
    
    CGSize size = cell.frame.size;
    if (_buttonAnimationEnabled) {
        CGFloat x = size.width - fabs(offset.x);
        CGFloat delta = fabs(offset.x) / _listView.cellSwipeLimits.right;
        bTrash.frame = CGRectMake(x + 20 + 100*delta, 0, 60, size.height);
        bFlag.frame = CGRectMake(x + 10 + 50*delta, 0, 60, size.height);
        bMore.frame = CGRectMake(x, 0, 60, size.height);
    }
    else {
        bMore.frame = CGRectMake(size.width - 180, 0, 60, size.height);
        bFlag.frame = CGRectMake(size.width - 120, 0, 60, size.height);
        bTrash.frame = CGRectMake(size.width - 60, 0, 60, size.height);
    }
}

- (NSAttributedString*)attributedMailText:(NSString*)text
{
    NSString *randomStr = [_loremIpsum generateString:10 + arc4random()%15];
    NSString *str = [NSString stringWithFormat:@"%@\n%@", text, randomStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{}];
    NSRange range = [str rangeOfString:@"\n"];
    [attrStr addAttribute:NSForegroundColorAttributeName
                                    value:[UIColor grayColor]
                                    range:NSMakeRange(range.location, str.length - range.location)];
    return attrStr;
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didSwipeCell:(TKListViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withOffset:(CGPoint)offset
{
    [self animateButtonsInCell:cell widthOffset:offset];
}

- (void)listView:(TKListView *)listView didFinishSwipeCell:(TKListViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withOffset:(CGPoint)offset
{
    NSLog(@"swiped cell at index path: %ld", (long)indexPath.row);
}

@end
