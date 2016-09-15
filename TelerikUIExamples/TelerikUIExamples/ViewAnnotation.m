//
//  ViewAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "ViewAnnotation.h"
#import <TelerikUI/TelerikUI.h>

@implementation ViewAnnotation
{
    TKChart *_chart;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    for (int i = 0; i < 2; i++) {
        NSMutableArray *points = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            [points addObject:[[TKChartDataPoint alloc] initWithX:@(arc4random() % 1450) Y:@(arc4random()%150)]];
        }
        [_chart addSeries:[[TKChartScatterSeries alloc] initWithItems:points]];
    }

    // add a view annotation
    // >> chart-layer-annotation
    UIImage *image = [UIImage imageNamed:@"logo"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    imageView.alpha = 0.7;
    [_chart addAnnotation:[[TKChartViewAnnotation alloc] initWithView:imageView X:@550 Y:@90 forSeries:_chart.series[0]]];
    // << chart-layer-annotation
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
