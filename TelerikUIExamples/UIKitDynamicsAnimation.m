//
//  UIKitDynamicsAnimation.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "UIKitDynamicsAnimation.h"
#import <TelerikUI/TelerikUI.h>

@interface UIKitDynamicsAnimation() <TKChartDelegate>
@end

@implementation UIKitDynamicsAnimation
{
    TKChart *_chart;
    UIDynamicAnimator *_animator;
    NSMutableArray *_points;
    TKChartVisualPoint *_selectedPoint;
    CGPoint _originalLocation;
    CGPoint _originalPosition;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Apply Gravity" selector:@selector(applyGravity)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _chart = [[TKChart alloc] initWithFrame:[self exampleBounds]];
    _chart.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _chart.allowAnimations = YES;
    _chart.delegate = self;
    [self.view addSubview:_chart];
    
    [self reloadChart];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSArray *points = [_chart visualPointsForSeries:_chart.series[0]];
    TKChartVisualPoint *point = points[4];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:point snapToPoint:point.center];
    snap.damping = 0.2f;
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[point] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0.f, -1.f);
    push.magnitude = 0.003;
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] init];
    [animator addBehavior:snap];
    [animator addBehavior:push];
    
    point.animator = animator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CAAnimation *)chart:(TKChart *)chart animationForSeries:(TKChartSeries *)series withState:(TKChartSeriesRenderState *)state inRect:(CGRect)rect
{
    return nil;
}

- (void)applyGravity
{
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:_chart.plotView];
    
    NSArray *points = [_chart visualPointsForSeries:_chart.series[0]];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:points];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:points];
    gravity.gravityDirection = CGVectorMake(0.f, 2.f);
    
    UIDynamicItemBehavior *dynamic = [[UIDynamicItemBehavior alloc] initWithItems:points];
    dynamic.elasticity = 0.5f;
    
    [_animator addBehavior:dynamic];
    [_animator addBehavior:gravity];
    [_animator addBehavior:collision];
}

- (void)reloadChart
{
    _points = [[NSMutableArray alloc] init];
    for (int i = 0; i<10; i++) {
        CGFloat x = i * 10;
        CGFloat y = arc4random() % 100;
        TKChartDataPoint *point = [[TKChartDataPoint alloc] initWithX:@(x) Y:@(y)];
        [_points addObject:point];
    }
    
    TKChartLineSeries *lineSeries = [[TKChartLineSeries alloc] initWithItems:_points];
    CGFloat shapeSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 14 : 17;
    lineSeries.selectionMode = TKChartSeriesSelectionModeDataPoint;
    lineSeries.style.pointShape = [[TKPredefinedShape alloc] initWithType:TKShapeTypeRhombus andSize:CGSizeMake(shapeSize, shapeSize)];
    lineSeries.style.shapeMode = TKChartSeriesStyleShapeModeAlwaysShow;
    [_chart addSeries:lineSeries];
    _chart.yAxis.style.labelStyle.textHidden = YES;
    
    [_chart reloadData];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:_chart.plotView];
    TKChartSelectionInfo *hitTestInfo = [_chart hitTestForPoint:touchPoint];
    _selectedPoint = [_chart visualPointForSeries:hitTestInfo.series dataPointIndex:hitTestInfo.dataPointIndex];
    _originalLocation = touchPoint;
    if (_selectedPoint) {
        _selectedPoint.animator = nil;
        _originalPosition = _selectedPoint.center;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (!_selectedPoint) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:_chart.plotView];
    CGPoint delta = CGPointMake(_originalLocation.x - touchPoint.x, _originalLocation.y - touchPoint.y);
    
    _selectedPoint.center = CGPointMake(_originalPosition.x, _originalPosition.y - delta.y);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (!_selectedPoint) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:_chart.plotView];
    CGPoint delta = CGPointMake(_originalLocation.x, _originalLocation.y - touchPoint.y);
    
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:_selectedPoint snapToPoint:_originalPosition];
    snap.damping = 0.2f;
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[_selectedPoint] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0.f, delta.y > 0 ? -1.f : -1.f);
    push.magnitude = 0.001;
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] init];
    [animator addBehavior:snap];
    [animator addBehavior:push];
    
    _selectedPoint.animator = animator;
}

@end
