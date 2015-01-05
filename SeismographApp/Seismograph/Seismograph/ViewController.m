//
//  ViewController.m
//  Seismograph
//
//  Created by Nikolay Diyanov on 11/24/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "NeedleAnnotation.h"

typedef NS_ENUM(NSInteger, AxisType) {
    AxisTypeX,
    AxisTypeY,
    AxisTypeZ
};

static NSInteger const coefficient = 1000;

@interface ViewController ()
{
    NSMutableArray *dataPoints;
    TKChartLineSeries *lineSeries;
    AxisType aType;
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *controlButtons;
@property (strong, nonatomic) IBOutlet TKChart *chart;
@property (strong, nonatomic) IBOutlet UISegmentedControl *axesButtons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataPoints = [[NSMutableArray alloc] init];
    
    motionManager = [[CMMotionManager alloc] init];

    [self startOperations];
}

-(void)startOperations {
    motionManager.accelerometerUpdateInterval = 0.2;
    if(motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            CMAcceleration acceleration = accelerometerData.acceleration;
         
            switch (aType) {
                case AxisTypeX:
                    [self buildChartWithPoint:acceleration.x*coefficient];
                    break;
                case AxisTypeY:
                    [self buildChartWithPoint:acceleration.y*coefficient];
                    break;
                case AxisTypeZ:
                    [self buildChartWithPoint:acceleration.z*coefficient];
                    break;
                default:
                    break;
            }
        }];
    }
}

-(void)buildChartWithPoint:(double)point {
    [_chart removeAllData];
    [_chart removeAllAnnotations];

    TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:[NSDate date] Y:@(point)];
    [dataPoints addObject:dataPoint];
    
    if (dataPoints.count > 25) {
        [dataPoints removeObjectAtIndex:0];
    }
    
    TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(-coefficient) andMaximum:@(coefficient)];
    yAxis.position = TKChartAxisPositionLeft;
    yAxis.majorTickInterval = @200;
    yAxis.minorTickInterval = @1;
    yAxis.offset = @0;
    yAxis.baseline = @0;
    yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitModeRotate;
    yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentLeft;
    _chart.yAxis = yAxis;

    lineSeries = [[TKChartLineSeries alloc] initWithItems:dataPoints];
    lineSeries.style.palette = [TKChartPalette new];
    TKStroke *strokeRed = [TKStroke strokeWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
    strokeRed.width = 1.5;
    [lineSeries.style.palette addPaletteItem:[TKChartPaletteItem paletteItemWithDrawables:@[strokeRed]]];
    [_chart addSeries:lineSeries];
    
    TKStroke *axisColor = [TKStroke strokeWithColor:[UIColor blackColor]];
    axisColor.width = 1;
    _chart.xAxis.style.lineStroke = axisColor;
    _chart.xAxis.style.majorTickStyle.ticksHidden = YES;
    _chart.xAxis.style.labelStyle.textHidden = YES;
    
    TKStroke *dashStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    dashStroke.dashPattern = @[@6, @1];
    dashStroke.width = 0.5;
    
    TKChartBandAnnotation *annotationBandRed = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@(-1000) andMaximum:@(1000)] forAxis:_chart.yAxis];
    annotationBandRed.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:255/255.0 green:149/255.0 blue:149/255.0 alpha:0.7]];
    [_chart addAnnotation:annotationBandRed];
    
    TKChartBandAnnotation *annotationBandYellow = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@-500 andMaximum:@500] forAxis:_chart.yAxis];
    annotationBandYellow.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:252/255.0 green:255/255.0 blue:138/255.0 alpha:0.7]];
    [_chart addAnnotation:annotationBandYellow];
    
    TKChartBandAnnotation *annotationBandGreen = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@-300 andMaximum:@300] forAxis:_chart.yAxis];
    annotationBandGreen.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:152/255.0 green:255/255.0 blue:149/255.0 alpha:1]];
    [_chart addAnnotation:annotationBandGreen];
    
    TKChartGridLineAnnotation *positiveDashAnnotation = [[TKChartGridLineAnnotation alloc] initWithValue:@150 forAxis:_chart.yAxis];
    positiveDashAnnotation.style.stroke = dashStroke;
    [_chart addAnnotation:positiveDashAnnotation];
    
    TKChartGridLineAnnotation *negativeDashAnnotation = [[TKChartGridLineAnnotation alloc] initWithValue:@-150 forAxis:_chart.yAxis];
    negativeDashAnnotation.style.stroke = dashStroke;
    [_chart addAnnotation:negativeDashAnnotation];
    
    if(dataPoints.count > 1) {
        NeedleAnnotation *needle = [[NeedleAnnotation alloc] initWithX:dataPoint.dataXValue Y:dataPoint.dataYValue forSeries:lineSeries];
        needle.zPosition = TKChartAnnotationZPositionAboveSeries;
        [_chart addAnnotation:needle];
    }
}

- (IBAction)axesButtonsValueChanged:(id)sender {
    [dataPoints removeAllObjects];
    [_chart removeAllData];
    
    aType = [self.axesButtons selectedSegmentIndex];
}

- (IBAction)controlButtonsValueChanged:(id)sender {
    NSString *category = [self.controlButtons titleForSegmentAtIndex: [self.controlButtons selectedSegmentIndex]];
    
    if([category isEqualToString:@"Start"])
    {
        [self startOperations];
    }
    else if ([category isEqualToString:@"Stop"])
    {
        [motionManager stopAccelerometerUpdates];
        [[NSOperationQueue currentQueue] cancelAllOperations];
    }
    else if ([category isEqualToString:@"Reset"])
    {
        [dataPoints removeAllObjects];
        [_chart removeAllData];
    }
}

@end
