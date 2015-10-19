//
//  AppDelegate.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <TelerikAppFeedback/TelerikAppFeedback.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "ExampleInfo.h"

#import "ColumnAndBarChart.h"
#import "LineAreaSpline.h"
#import "ScatterChart.h"
#import "PieDonut.h"
#import "StackedColumnChart.h"
#import "StackedAreaChart.h"
#import "FinancialChart.h"
#import "NumericAxis.h"
#import "CategoricalAxis.h"
#import "DateTimeAxis.h"
#import "LogarithmicAxis.h"
#import "CustomAxis.h"
#import "MultipleAxes.h"
#import "DateTimeCategoryAxis.h"
#import "NegativeValues.h"
#import "PanZoom.h"
#import "DefaultAnimation.h"
#import "CustomAnimationAreaChart.h"
#import "CustomAnimationLineChart.h"
#import "CustomAnimationPieChart.h"
#import "UIKitDynamicsAnimation.h"
#import "BindWithDataPoint.h"
#import "BindWithCustomObject.h"
#import "BindWithDelegate.h"
#import "Customize.h"
#import "BandAndLineAnnotations.h"
#import "BalloonAnnotation.h"
#import "LayerAnnotation.h"
#import "ViewAnnotation.h"
#import "CrossLineAnnotation.h"
#import "CustomAnnotation.h"
#import "Trackball.h"
#import "BubbleChart.h"
#import "RangeBarColumnChart.h"

#import "IndicatorsViewController.h"

#import "CalendarWithEvents.h"
#import "CalendarViewModes.h"
#import "CalendarTransitionEffects.h"
#import "CalendarSelection.h"
#import "iOS7StyleCalendar.h"
#import "CalendarCustomization.h"
#import "CalendarEventKitDataBinding.h"
#import "LocalizedCalendar.h"
#import "InlineEvents.h"

#import "FeedbackExampleController.h"

#import "PointLabels.h"
#import "CustomPointLabels.h"
#import "CustomPointLabelRender.h"

#import "LiveData.h"
#import "SideDrawerGettingStarted.h"
#import "SideDrawerTransitions.h"
#import "SideDrawerCustomContentController.h"
#import "SideDrawerCustomTransition.h"
#import "SideDrawerPositions.h"

#import "DataSourceGettingStarted.h"
#import "DataSourceDescriptorsAPI.h"
#import "DataSourceUIBindings.h"
#import "DataSourceWithWebService.h"

#import "ListViewGettingStarted.h"
#import "ListViewSelection.h"
#import "ListViewAnimations.h"
#import "ListViewLoadOnDemand.h"
#import "ListViewGroups.h"
#import "ListViewLayout.h"
#import "ListViewPullToRefresh.h"
#import "ListViewReorder.h"
#import "ListViewSwipe.h"

#import "AlertViewGettingStarted.h"
#import "AlertViewSettings.h"
#import "AlertViewCustomize.h"
#import "AlertViewAnimations.h"
#import "AlertNotifications.h"
#import "AlertCustomView.h"

#import "DataFormGettingStarted.h"
#import "DataFormValidation.h"
#import "DataFormReadOnly.h"
#import "DataFormCustomization.h"
#import "DataFormLabelAlignment.h"
#import "DataFormCollapsibleGroups.h"

#import "AutoCompleteGettingStarted.h"
#import "AutoCompleteCustomization.h"
#import "AutoCompleteTokens.h"

#import "GaugeGettingStarted.h"
#import "GaugeCustomization.h"
#import "GaugeAnimations.h"
#import "GaugeInteraction.h"
#import "GaugeScales.h"
#import "GaugeRanges.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *mainViewController = [[ViewController alloc] initWithExample:[self createExamples]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIInterfaceOrientationMask)application:(nonnull UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return 0;
}

- (ExampleInfo*)createExamples
{
    NSDictionary *examples = @{

                               @"1.Alert" : @{
                                       @"1. Getting started": [AlertViewGettingStarted class],
                                       @"2. Custom View": [AlertCustomView class],
                                       @"3. Animations": [AlertViewAnimations class],
                                       @"4. Notifications": [AlertNotifications class],
                                       @"5. Customize": [AlertViewCustomize class],
                                       @"6. Settings": [AlertViewSettings class],
                                       },
                               
                               @"2.AppFeedback": [FeedbackExampleController class],
                               
                               @"3.AutoCompleteTextView (Beta)" : @{
                                       @"1. Getting Started": [AutoCompleteGettingStarted class],
                                       @"2. Customization":[AutoCompleteCustomization class],
                                       @"3. Tokens":[AutoCompleteTokens class],
                                       },
                               
                               @"4.Calendar": @{
                                       @"1. Calendar with events": [CalendarWithEvents class],
                                       @"2. View modes": [CalendarViewModes class],
                                       @"3. Transition effects": [CalendarTransitionEffects class],
                                       @"4. Selection": [CalendarSelection class],
                                       @"5. iOS 7 style calendar": [iOS7StyleCalendar class],
                                       @"6. Customization": [CalendarCustomization class],
                                       @"7. EventKit data binding": [CalendarEventKitDataBinding class],
                                       @"8. Localized calendar": [LocalizedCalendar class],
                                       @"9. Inline events": [InlineEvents class],
                                       },
                               
                               @"5.Chart": @{
                                       @"1.Chart Types": @{
                                               @"1.Column / Bar chart": [ColumnAndBarChart class],
                                               @"2.Range Column / Bar chart" : [RangeBarColumnChart class],
                                               @"3.Line / Area / Spline chart": [LineAreaSpline class],
                                               @"4.Scatter chart": [ScatterChart class],
                                               @"5.Bubble chart": [BubbleChart class],
                                               @"6.Pie chart": [PieDonut class],
                                               @"7.Stacked Column chart": [StackedColumnChart class],
                                               @"8.Stacked Area chart": [StackedAreaChart class],
                                               @"9.Financial chart": [FinancialChart class],
                                               @"10.Indicators": [IndicatorsViewController class],
                                               },
                                       
                                       @"2.Axis Types": @{
                                               @"1.Numeric axis": [NumericAxis class],
                                               @"2.Categorical axis": [CategoricalAxis class],
                                               @"3.Date/Time axis": [DateTimeAxis class],
                                               @"4.Date/Time category axis": [DateTimeCategoryAxis class],
                                               @"5.Multiple axes": [MultipleAxes class],
                                               @"6.Negative values": [NegativeValues class],
                                               @"7.Logarithmic axis": [LogarithmicAxis class],
                                               @"8.Custom axis": [CustomAxis class],
                                               },
                                       
                                       @"3.Animations": @{
                                               @"1.Default animations": [DefaultAnimation class],
                                               @"2.Custom animation - line chart": [CustomAnimationLineChart class],
                                               @"3.Custom animation - area chart": [CustomAnimationAreaChart class],
                                               @"4.Custom animation - pie chart": [CustomAnimationPieChart class],
                                               @"5.UIKit dynamics animation": [UIKitDynamicsAnimation class],
                                               },
                                       
                                       @"4.Binding": @{
                                               @"1.Bind with data point": [BindWithDataPoint class],
                                               @"2.Bind with custom object": [BindWithCustomObject class],
                                               @"3.Bind with delegate": [BindWithDelegate class],
                                               },
                                       
                                       @"5.Pan/Zoom": [PanZoom class],
                                       @"6.Customize": [Customize class],
                                       @"7.Annotations": @{
                                               @"1.Band and line annotations": [BandAndLineAnnotations class],
                                               @"2.Balloon annotation": [BalloonAnnotation class],
                                               @"3.Layer annotation": [LayerAnnotation class],
                                               @"4.View annotation": [ViewAnnotation class],
                                               @"5.Cross line annotation": [CrossLineAnnotation class],
                                               @"6.Custom annotation": [CustomAnnotation class],
                                               @"7.Trackball": [Trackball class],
                                               },
                                       @"8.Point Labels" : @{
                                               @"1.Point Labels" : [PointLabels class],
                                               @"2.Custom Label" : [CustomPointLabels class],
                                               @"3.Custom Label Render" : [CustomPointLabelRender class],
                                               },
                                       @"9.Live Data" : [LiveData class],
                                       },
                               
                               @"6.DataForm (New)": @{
                                       @"1. Getting started": [DataFormGettingStarted class],
                                       @"2. Validation": [DataFormValidation class],
                                       @"3. Read Only Mode": [DataFormReadOnly class],
                                       @"4. Customization": [DataFormCustomization class],
                                       @"5. Alignment" : [DataFormLabelAlignment class],
                                       @"6. Collapsible Groups" : [DataFormCollapsibleGroups class]
                                       },
                               
                               @"7.DataSource": @{
                                       @"1. Getting started": [DataSourceGettingStarted class],
                                       @"2. Descriptors API": [DataSourceDescriptorsAPI class],
                                       @"3. Bind with UI controls": [DataSourceUIBindings class],
                                       @"4. Consume web service": [DataSourceWithWebService class],
                                       },
                               
                               @"8.Gauges (New)" : @{
                                       @"1. Getting started": [GaugeGettingStarted class],
                                       @"2. Customization": [GaugeCustomization class],
                                       @"3. Interaction": [GaugeInteraction class],
                                       @"4. Animations": [GaugeAnimations class],
                                       @"5. Scales": [GaugeScales class],
                                       @"6. Ranges": [GaugeRanges class],
                                       },

                               @"9.ListView": @{
                                       @"1. Getting started": [ListViewGettingStarted class],
                                       @"2. Swipe cell": [ListViewSwipe class],
                                       @"3. Items reorder": [ListViewReorder class],
                                       @"4. Selection": [ListViewSelection class],
                                       @"5. Grouping": [ListViewGroups class],
                                       @"6. Layouts": [ListViewLayout class],
                                       @"7. Animations": [ListViewAnimations class],
                                       @"8. Load on demand": [ListViewLoadOnDemand class],
                                       @"9. Pull to refresh": [ListViewPullToRefresh class],
                                       },

                               @"10.SideDrawer" : @{
                                       @"1. Getting Started" : [SideDrawerGettingStarted class],
                                       @"2. Transitions" : [SideDrawerTransitions class],
                                       @"3. Custom Content" : [SideDrawerCustomContentController class],
                                       @"4. Custom Transition" : [SideDrawerCustomTransition class],
                                       @"5. Positions" : [SideDrawerPositions class],
                                       }
                               };
    
    NSArray *examplesArray = [self createExamplesRecursively:examples];
    return [[ExampleInfo alloc] initWithExamples:examplesArray withTitle:@"Examples"];
}

- (NSArray*)createExamplesRecursively:(NSDictionary*)examplesDict
{
    NSArray *orderedKeys = [[examplesDict allKeys] sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
    
    NSMutableArray *examplesArray = [[NSMutableArray alloc] init];
    for (NSString *exampleKey in orderedKeys) {
        id example = [examplesDict valueForKey:exampleKey];
        NSRange firstDotIndex = [exampleKey rangeOfString:@"."];
        NSString *exampleName = [exampleKey substringFromIndex:firstDotIndex.location+firstDotIndex.length];
        if ([example isKindOfClass:[NSDictionary class]]) {
            NSArray *array = [self createExamplesRecursively:(NSDictionary*)example];
            [examplesArray addObject:[[ExampleInfo alloc] initWithExamples:array withTitle:exampleName]];
        }
        else {
            [examplesArray addObject:[[ExampleInfo alloc] initWithClass:(Class)example withTitle:exampleName]];
        }
    }
    
    return examplesArray;
}

@end
