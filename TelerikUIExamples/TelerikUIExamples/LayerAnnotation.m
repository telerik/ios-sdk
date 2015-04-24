//
//  LayerAnnotation.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "LayerAnnotation.h"
#import <TelerikUI/TelerikUI.h>

@implementation LayerAnnotation
{
    TKChart *_chart;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    // Add a layer annotation
    CALayer *layer = [[CALayer alloc] init];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.backgroundColor = [UIColor colorWithRed:1. green:0. blue:0. alpha:0.6].CGColor;
    layer.shadowRadius = 10;
    layer.shadowColor = [UIColor yellowColor].CGColor;
    layer.shadowOpacity = 1;
    layer.cornerRadius = 10;
    
    TKChartLayerAnnotation *a = [[TKChartLayerAnnotation alloc] initWithLayer:layer X:@"Mar" Y:@80 forSeries:series];
    a.zPosition = TKChartAnnotationZPositionAboveSeries;
    [_chart addAnnotation:a];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
