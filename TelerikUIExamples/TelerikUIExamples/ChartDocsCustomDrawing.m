//
//  ChartDocsCustomDrawing.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "ChartDocsCustomDrawing.h"
#import <TelerikUI/TelerikUI.h>

@implementation ChartDocsCustomDrawing
{
    TKChart *chart;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    chart = [[TKChart alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:chart];
    
    NSArray *gdpInPoundsValues = @[@80, @92, @73, @85, @59];
    NSMutableArray *gdpInPoundsPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < gdpInPoundsValues.count; i++) {
        [gdpInPoundsPoints addObject:[[TKChartDataPoint alloc] initWithX:[self dateWithYear:(i + 2009) month:12 day:31] Y:gdpInPoundsValues[i]]];
    }
    
    // >> chart-drawing-cycling
    TKChartSeries *columnSeries = [[TKChartColumnSeries alloc] initWithItems:gdpInPoundsPoints];
    // >> chart-drawing-pallete
    columnSeries.style.palette = [TKChartPalette new];
    // << chart-drawing-pallete
    
    // >> chart-drawing-solid-fill
    TKSolidFill *redFill = [[TKSolidFill alloc] initWithColor:[UIColor redColor]];
    // << chart-drawing-solid-fill
    
    [columnSeries.style.palette addPaletteItem:[[TKChartPaletteItem alloc] initWithFill:redFill]];
    
    TKSolidFill *blueFill = [[TKSolidFill alloc] initWithColor:[UIColor blueColor]];
    [columnSeries.style.palette addPaletteItem:[[TKChartPaletteItem alloc] initWithFill:blueFill]];
    
    TKSolidFill *greenFill = [[TKSolidFill alloc] initWithColor:[UIColor greenColor]];
    [columnSeries.style.palette addPaletteItem:[[TKChartPaletteItem alloc] initWithFill:greenFill]];
   
    columnSeries.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    [chart addSeries:columnSeries];
    // << chart-drawing-cycling

    columnSeries.style.palette = [TKChartPalette new];
    
    // >> chart-drawing-pallete-mode-index
    columnSeries.style.paletteMode = TKChartSeriesStylePaletteModeUseItemIndex;
    // << chart-drawing-pallete-mode-index
    
    // >> chart-drawing-pallete-mode-series
    columnSeries.style.paletteMode = TKChartSeriesStylePaletteModeUseSeriesIndex;
    // << chart-drawing-pallete-mode-series
    
    // >> chart-drawing-pallete-items
    TKChartPaletteItem *paletteItem1 = [TKChartPaletteItem paletteItemWithFill:[TKSolidFill solidFillWithColor:[UIColor redColor]]];
    TKChartPaletteItem *paletteItem2 = [TKChartPaletteItem paletteItemWithStroke:[TKStroke strokeWithColor:[UIColor blueColor]]];
    TKChartPaletteItem *paletteItem3 = [TKChartPaletteItem paletteItemWithStroke:[TKStroke strokeWithColor:[UIColor blueColor]]
                                                                         andFill:[TKSolidFill solidFillWithColor:[UIColor redColor]]];
    
    [columnSeries.style.palette addPaletteItem:paletteItem1];
    [columnSeries.style.palette addPaletteItem:paletteItem2];
    [columnSeries.style.palette addPaletteItem:paletteItem3];

     // << chart-drawing-pallete-items
    
    NSArray *xValues = @[ @460, @510, @600, @640, @700, @760, @800, @890, @920, @1000, @1060, @1120, @1200, @1342, @1440];
    NSArray *yValues = @[ @7, @9, @12, @17, @19, @25, @32, @42, @50, @16, @56, @77, @24, @80, @90 ];
    NSMutableArray *scatterPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i<xValues.count; i++) {
        [scatterPoints addObject:[[TKChartDataPoint alloc] initWithX:xValues[i] Y:yValues[i]]];
    }
    
    // >> chart-drawing-pallete-point
    TKChartScatterSeries *scatterSeries = [[TKChartScatterSeries alloc] initWithItems:scatterPoints];
    scatterSeries.style.pointShape = [TKPredefinedShape shapeWithType:TKShapeTypeRhombus andSize:CGSizeMake(15.f, 15.f)];
    // << chart-drawing-pallete-point
}

- (void) paletteItemsWithSeries:(TKChartSeries*)series
{
    // >> chart-drawing-pallete-items-arrays
    series.style.palette = [TKChartPalette new];
    TKSolidFill *redFill = [[TKSolidFill alloc] initWithColor:[UIColor redColor] cornerRadius:2.f];
    TKStroke *stroke1 = [TKStroke strokeWithColor:[UIColor yellowColor] width:1.f cornerRadius:2.f];
    stroke1.insets = UIEdgeInsetsMake(1.f, 1.f, 1.f, 1.f);
    TKStroke *stroke2 = [TKStroke strokeWithColor:[UIColor blackColor] width:1.f cornerRadius:2.f];
    [series.style.palette addPaletteItem:[TKChartPaletteItem paletteItemWithDrawables:@[redFill, stroke1, stroke2]]];
    // << chart-drawing-pallete-items-arrays
}

- (void) simpleStroke
{
    // >> chart-drawing-stroke
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blueColor]];
    // << chart-drawing-stroke
    NSLog(@"%@", stroke);
}

- (void) simpleStroke2
{
   // >> chart-drawing-stroke-rounded-corners
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blueColor] width:1.f cornerRadius:5.0f];
    // << chart-drawing-stroke-rounded-corners
    NSLog(@"%@", stroke);
    
}

- (void) simpleStrokeLinear
{
    // >> chart-drawing-stroke-gradient
    TKLinearGradientFill *fill = [TKLinearGradientFill linearGradientFillWithColors:@[[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.6f]]];
    TKStroke *stroke = [TKStroke strokeWithFill:fill width:1.f cornerRadius:5.0f];
    // << chart-drawing-stroke-gradient
    NSLog(@"%@", stroke);
}

- (void) strokeCombinedWithFill
{
    // >> chart-drawing-stroke-combined
    TKLinearGradientFill *fill = [TKLinearGradientFill linearGradientFillWithColors:@[[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.6f]]];
    TKStroke *stroke = [TKStroke strokeWithFill:fill width:1.f cornerRadius:8.0f];
    stroke.dashPattern = @[@2, @2, @5, @2];
    stroke.corners = UIRectCornerTopRight | UIRectCornerBottomLeft;
    // << chart-drawing-stroke-combined
}

- (void) simpleStrokeDash
{
    // >> chart-drawing-stroke-dashed
    TKStroke *stroke = [TKStroke strokeWithColor:[UIColor blueColor] width:1.f cornerRadius:5.0f];
    stroke.dashPattern = @[@2, @2, @5, @2];
    // << chart-drawing-stroke-dashed
}

- (void) simpleFill
{
    TKSolidFill *fill = [[TKSolidFill alloc] initWithColor:[UIColor redColor]];
    NSLog(@"%@", fill);
}

- (void)simpleFill2
{
    TKSolidFill *fill = [TKSolidFill solidFillWithColor:[UIColor redColor]];
    NSLog(@"%@", fill);
}

- (void) simpleFillRadius
{
     // >> chart-drawing-solid-fill-radius
    TKSolidFill *fill = [TKSolidFill solidFillWithColor:[UIColor redColor] cornerRadius:5.f];
    // << chart-drawing-solid-fill-radius
    NSLog(@"%@", fill);
}

- (void) simpleFillDiffCornersToRound
{
    // >> chart-drawing-round-corners
    TKSolidFill *fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.5f] cornerRadius:8.f];
    fill.corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    // << chart-drawing-round-corners
}

- (void) gradientFill
{
    // >> chart-drawing-gradient
    TKLinearGradientFill *fill = [TKLinearGradientFill linearGradientFillWithColors:@[[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.6f]]];
    // << chart-drawing-gradient
    NSLog(@"%@", fill);
}

- (void) gradientFillCustomized
{
    // >> chart-drawing-gradient-direction
    TKLinearGradientFill *fill = [TKLinearGradientFill linearGradientFillWithColors:@[[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.6f],
                                                                                      [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.6f]]
                                                                          locations:@[@(0.6f), @(0.8f), @(1.0f)]
                                                                         startPoint:CGPointMake(0.f, 0.f)
                                                                           endPoint:CGPointMake(1.f, 1.f)];
    // << chart-drawing-gradient-direction
    NSLog(@"%@", fill);
}

- (void) radialFill
{
    // >> chart-drawing-gradient-radial
    TKRadialGradientFill *fill = [[TKRadialGradientFill alloc] initWithColors:@[[UIColor colorWithRed:0.f green:1.f blue:0.f alpha:0.7f],
                                                                                [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.0f]]
                                                                  startCenter:CGPointMake(0.5f, 0.5f)
                                                                  startRadius:0.7f
                                                                    endCenter:CGPointMake(0.f, 1.f)
                                                                    endRadius:0.3f
                                                                   radiusType:TKGradientRadiusTypeRectMax];
    // << chart-drawing-gradient-radial
    NSLog(@"%@", fill);
}

- (void) imageFill
{
    // >> chart-drawing-image-fill
    TKImageFill *fill = [TKImageFill imageFillWithImage:[UIImage imageNamed:@"pattern1"] cornerRadius:4.f];
    fill.resizingMode = TKImageFillResizingModeTile;
    // << chart-drawing-image-fill
}

- (void) imageFillStretch
{
    // >> chart-drawing-image-fill-stretch
    TKImageFill *fill = [TKImageFill imageFillWithImage:[UIImage imageNamed:@"building1"] cornerRadius:4.f];
    // << chart-drawing-image-fill-stretch
    NSLog(@"%@", fill);
}

- (void) ownStretchableImage
{
    // >> chart-drawing-image-resize
    TKImageFill *fill = [TKImageFill imageFillWithImage:
                         [[UIImage imageNamed:@"pattern2"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    fill.resizingMode = TKImageFillResizingModeNone;
    // << chart-drawing-image-resize
}

- (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
