//
//  CalendarTransitionEffects.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CalendarTransitionEffects.h"
#import <TelerikUI/TelerikUI.h>

@interface CalendarTransitionEffects () <TKCalendarPresenterDelegate, TKCalendarDelegate>

@property (nonatomic, strong) TKCalendar *calendarView;
@property (nonatomic, strong) UIButton *buttonPrev;
@property (nonatomic, strong) UIButton *buttonNext;

@end

@implementation CalendarTransitionEffects
{
    NSInteger _colorIndex;
    NSInteger _oldColorIndex;
    NSArray *_colors;
    TKCalendarTransitionMode _transitionMode;
    UIView *_contentView;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _colorIndex = 0;
        _colors = @[ [UIColor colorWithRed:0. green:1. blue:0. alpha:0.3],
                     [UIColor colorWithRed:1. green:0. blue:0. alpha:0.3],
                     [UIColor colorWithRed:0. green:0. blue:1. alpha:0.3],
                     [UIColor colorWithRed:1. green:1. blue:0. alpha:0.3],
                     [UIColor colorWithRed:0. green:1. blue:1. alpha:0.3],
                     [UIColor colorWithRed:1. green:0. blue:1. alpha:0.3]
                   ];
        
        [self addOption:@"Flip effect" selector:@selector(selectFlipEffect)];
        [self addOption:@"Float effect" selector:@selector(selectFloatEffect)];
        [self addOption:@"Fold effect" selector:@selector(selectFoldEffect)];
        [self addOption:@"Rotate effect" selector:@selector(selectRotateEffect)];
        [self addOption:@"Card effect" selector:@selector(selectCardEffect)];
        [self addOption:@"Scroll effect" selector:@selector(selectScrollEffect)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _contentView = [[UIView alloc] initWithFrame:self.exampleBounds];
    [self.view addSubview:_contentView];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentView.bounds) - 44, CGRectGetWidth(_contentView.bounds), 44)];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_contentView addSubview:toolbar];
    
    UIBarButtonItem *buttonPrev = [[UIBarButtonItem alloc] initWithTitle:@"Prev month" style:UIBarButtonItemStylePlain target:self action:@selector(prevTouched:)];
    UIBarButtonItem *buttonNext = [[UIBarButtonItem alloc] initWithTitle:@"Next month" style:UIBarButtonItemStylePlain target:self action:@selector(nextTouched:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolbar.items = @[buttonPrev, space, buttonNext];
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentView.bounds), CGRectGetHeight(_contentView.bounds) - 44)];
    self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.calendarView.delegate = self;
    self.calendarView.allowPinchZoom = NO;
    [_contentView addSubview:self.calendarView];
    
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)self.calendarView.presenter;
    presenter.transitionMode = TKCalendarTransitionModeFlip;
    presenter.delegate = self;
    presenter.headerIsSticky = YES;
    presenter.contentView.backgroundColor = _colors[_colorIndex];
    _transitionMode = TKCalendarTransitionModeFlip;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _contentView.frame = self.exampleBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prevTouched:(id)sender
{
    [_calendarView navigateBack:YES];
}

- (void)nextTouched:(id)sender
{
    [_calendarView navigateForward:YES];
}

- (void)selectFlipEffect
{
    [self setTransition:TKCalendarTransitionModeFlip isVertical:NO];
}

- (void)selectFloatEffect
{
    [self setTransition:TKCalendarTransitionModeFloat isVertical:NO];
}

- (void)selectFoldEffect
{
    [self setTransition:TKCalendarTransitionModeFold isVertical:NO];
}

- (void)selectRotateEffect
{
    [self setTransition:TKCalendarTransitionModeRotate isVertical:NO];
}

- (void)selectCardEffect
{
    [self setTransition:TKCalendarTransitionModeCard isVertical:YES];
}

- (void)selectScrollEffect
{
    [self setTransition:TKCalendarTransitionModeScroll isVertical:YES];
}

- (void)setTransition:(TKCalendarTransitionMode)transitionMode isVertical:(BOOL)isVertical
{
    _calendarView.viewMode = TKCalendarViewModeMonth;
    TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)_calendarView.presenter;
    presenter.contentView.backgroundColor = _colors[_colorIndex];
    presenter.delegate = self;
    presenter.headerIsSticky = YES;
    presenter.transitionIsVertical = isVertical;
    presenter.transitionMode = transitionMode;
    _transitionMode = transitionMode;
}

#pragma mark TKCalendarDelegate

- (void)calendar:(TKCalendar *)calendar didChangedViewModeFrom:(TKCalendarViewMode)previousViewMode to:(TKCalendarViewMode)viewMode
{
    if (viewMode == TKCalendarViewModeMonth) {
        TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter*)_calendarView.presenter;
        presenter.contentView.backgroundColor = _colors[_colorIndex];
        presenter.delegate = self;
        presenter.transitionMode = _transitionMode;
    }
}

#pragma mark TKCalendarPresenterDelegate

- (void)presenter:(id<TKCalendarPresenter>)presenter beginTransition:(TKViewTransition *)transition
{
    _oldColorIndex = _colorIndex;
    _colorIndex = (_colorIndex + 1) % _colors.count;
    TKCalendarMonthPresenter *monthPresenter = (TKCalendarMonthPresenter*)presenter;
    monthPresenter.contentView.backgroundColor = _colors[_colorIndex];
}

- (void)presenter:(id<TKCalendarPresenter>)presenter finishTransition:(BOOL)canceled
{
    if (canceled) {
        TKCalendarMonthPresenter *monthPresenter = (TKCalendarMonthPresenter*)presenter;
        monthPresenter.contentView.backgroundColor = _colors[_oldColorIndex];
        _colorIndex = _oldColorIndex;
    }
}

@end
