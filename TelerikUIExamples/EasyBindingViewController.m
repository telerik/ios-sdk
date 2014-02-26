//
//  EasyBindingViewController.m
//  TelerikUIExamples
//
//  Created by Tsvetan Raikov on 26/2/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "EasyBindingViewController.h"

#import <TelerikUI/TelerikUI.h>

@interface EasyBindingViewController ()
@end

@implementation EasyBindingViewController

//...
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(30, 30, 300, 300);
    TKChart *chart = [[TKChart alloc] initWithFrame:rect];
    [self.view addSubview:chart];
    
    NSMutableArray *myData = [NSMutableArray new];
    for (int i = 0; i<10; i++) {
        [myData addObject:[[TKChartDataPoint alloc]
                    initWithX:@(i) Y:@(arc4random() % 100)]];
    }
    [chart addSeries:[[TKChartLineSeries alloc]
                                      initWithItems:myData]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
