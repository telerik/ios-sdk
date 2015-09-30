//
//  Annotations.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "BalloonAnnotation.h"
#import <TelerikUI/TelerikUI.h>

@implementation BalloonAnnotation
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
    TKChartLineSeries *series = [[TKChartLineSeries alloc] initWithItems:array];
    series.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeCircle andSize:CGSizeMake(10, 10)];
    [_chart addSeries:series];
    
    // Add two balloon annotations
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Important milestone:\n $55000"
                                                                                       attributes:@{ NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                                     NSParagraphStyleAttributeName:paragraphStyle }];
    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(22, 6)];
    
    TKChartBalloonAnnotation *balloon = [[TKChartBalloonAnnotation alloc] initWithX:@"Mar" Y:@55 forSeries:series];
    balloon.attributedText = attributedText;
    balloon.style.distanceFromPoint = 20;
    balloon.style.arrowSize = CGSizeMake(10, 10);
    [_chart addAnnotation:balloon];
    
    balloon = [[TKChartBalloonAnnotation alloc] initWithText:@"The lowest value:\n $30000" X:@"Apr" Y:@30 forSeries:series];
    balloon.style.verticalAlign = TKChartBalloonVerticalAlignmentBottom;
    [_chart addAnnotation:balloon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
