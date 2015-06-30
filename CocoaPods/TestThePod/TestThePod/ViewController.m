//
//  ViewController.m
//  TestThePod
//
//  Created by Tsvetan Raikov on 6/30/15.
//  Copyright (c) 2015 TR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) TKDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.dataSource = [[TKDataSource alloc] initWithArray:@[ @10, @6, @8, @16, @9 ]];
    self.chart.dataSource = self.dataSource;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
