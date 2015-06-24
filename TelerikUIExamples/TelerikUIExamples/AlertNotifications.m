//
//  AlertNotifications.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "AlertNotifications.h"

@interface AlertNotifications () <TKListViewDelegate>
@end

@implementation AlertNotifications
{
    TKListView* _listView;
    TKDataSource *_dataSource;
    NSArray* _titles;
    NSArray* _messages;
    NSArray* _colors;
    TKAlert* _alert;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [[TKDataSource alloc] initWithArray:@[@"Error", @"Warning", @"Positive", @"Info"]];

    _listView = [[TKListView alloc] initWithFrame:self.view.frame];
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _listView.dataSource = _dataSource;
    _listView.delegate = self;
    [self.view addSubview:_listView];
    
    _titles = @[@"Oh no!", @"Warning!", @"Well done!", @"Info."];
    _messages = @[@"Change this and try again!", @"Be careful next time", @"You successfully read this message", @"This is TKAlert dialog"];
    _colors = @[[UIColor colorWithRed:1 green:0 blue:0.282 alpha:1],
                [UIColor colorWithRed:1 green:0.733 blue:0 alpha:1],
                [UIColor colorWithRed:0.478 green:0.988 blue:0.157 alpha:1],
                [UIColor colorWithRed:0.231 green:0.678 blue:1 alpha:1]];
    
    _alert = [TKAlert new];
    _alert.style.contentSeparatorWidth = 0;
    _alert.style.titleColor = [UIColor whiteColor];
    _alert.style.messageColor = [UIColor whiteColor];
    _alert.style.cornerRadius = 0;
    _alert.style.showAnimation = TKAlertAnimationSlideFromTop;
    _alert.style.dismissAnimation = TKAlertAnimationSlideFromTop;
    _alert.style.backgroundStyle = TKAlertBackgroundStyleNone;
    _alert.dismissMode = TKAlertDismissModeTap;
}

#pragma mark - TKListViewDelegate

- (void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _alert.title = _titles[indexPath.row];
    _alert.message = _messages[indexPath.row];
    _alert.contentView.fill = [TKSolidFill solidFillWithColor:_colors[indexPath.row]];
    _alert.headerView.fill = [TKSolidFill solidFillWithColor:[_colors[indexPath.row] colorWithAlphaComponent:0.9]];
    _alert.customFrame = CGRectMake(0, 0, self.view.frame.size.width, 160);
    _alert.alertView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    if (indexPath.row > 0) {
        _alert.dismissTimeout = 3.2;
    }
    else {
        _alert.dismissTimeout = 0;
    }
    
    [_alert show:YES];
}

@end
