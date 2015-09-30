//
//  CustomAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CustomAnnotation.h"
#import <TelerikUI/TelerikUI.h>
#import "MyAnnotation.h"

@implementation CustomAnnotation
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
    
    _chart = [[TKChart alloc] initWithFrame:self.exampleBoundsWithInset];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_chart];
    
    NSArray *months = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun"];
    NSArray *values = @[@95, @40, @55, @30, @76, @34];
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i<months.count; i++) {
        [array addObject:[[TKChartDataPoint alloc] initWithX:months[i] Y:values[i]]];
    }
    TKChartAreaSeries *series = [[TKChartAreaSeries alloc] initWithItems:array];
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(10, 10)];
    [_chart addSeries:series];
    
    // Add my custom annotation
    TKPredefinedShape *shape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeStar andSize:CGSizeMake(20, 20)];
    MyAnnotation *a = [[MyAnnotation alloc] initWithShape:shape X:@"Mar" Y:@60 forSeries:series];
    a.fill = [TKSolidFill solidFillWithColor:[UIColor blueColor]];
    a.stroke = [TKStroke strokeWithColor:[UIColor yellowColor] width:3];
    [_chart addAnnotation:a];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
