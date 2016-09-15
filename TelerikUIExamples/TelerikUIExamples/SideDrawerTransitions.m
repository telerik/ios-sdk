//
//  SideDrawerTransitions.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerTransitions.h"
#import "SideDrawerHeaderView.h"

@implementation SideDrawerTransitions
{
    UIScrollView *_scrollView;
    CGFloat _buttonY;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.scrollEnabled = YES;
    
    [self addButtonWithTitle:@"Push" target:self selector:@selector(pushTransition)];
    [self addButtonWithTitle:@"Reveal" target:self selector:@selector(revealTransition)];
    [self addButtonWithTitle:@"Reverse Slide Out" target:self selector:@selector(reverseSlideOutTransition)];
    [self addButtonWithTitle:@"Slide Along" target:self selector:@selector(slideAlongTransition)];
    [self addButtonWithTitle:@"Slide In On Top" target:self selector:@selector(slideInOnTopTransition)];
    [self addButtonWithTitle:@"Scale Up" target:self selector:@selector(scaleUpTransition)];
    [self addButtonWithTitle:@"Fade In" target:self selector:@selector(fadeInTransition)];
    [self addButtonWithTitle:@"Scale Down Pusher" target:self selector:@selector(scaleDownPusherTransition)];
    
    [self.sideDrawerView.mainView addSubview:_scrollView];
    self.sideDrawerView.backgroundColor = [UIColor grayColor];
    
    self.sideDrawer.style.shadowMode = TKSideDrawerShadowModeSideDrawer;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrollView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.sideDrawerView.mainView.bounds) - 44);
}

- (void)pushTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypePush;
    // >> drawer-transitions-duration
    sideDrawer.transitionDuration = 0.5;
    // << drawer-transitions-duration
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)revealTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    
    // >> drawer-transition
    sideDrawer.transition = TKSideDrawerTransitionTypeReveal;
    // << drawer-transition
    
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)reverseSlideOutTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeReverseSlideOut;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)slideAlongTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeSlideAlong;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)slideInOnTopTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeSlideInOnTop;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    [self showSideDrawer];
}

- (void)scaleUpTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeScaleUp;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)fadeInTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeFadeIn;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:YES target:self selector:@selector(dismissSideDrawer)];
    [self showSideDrawer];
}

- (void)scaleDownPusherTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeScaleDownPusher;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:self selector:@selector(dismissSideDrawer)];
    [self showSideDrawer];
}

- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    CGSize titleSize = [title sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:18] }];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15 + _buttonY, titleSize.width, 44)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setCornerRadius:3.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];
    _buttonY += 50;
    _scrollView.contentSize = CGSizeMake(fmax(CGRectGetWidth(button.frame), _scrollView.contentSize.width), _buttonY + 15 + self.view.bounds.origin.y);
}

#pragma mark TKSideDrawerDelegate

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForItem:(NSInteger)item inSection:(NSInteger)section
{
    TKSideDrawerItem *currentItem = ((TKSideDrawerSection *)sideDrawer.sections[section]).items[item];
    currentItem.style.contentInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    currentItem.style.separatorColor = [TKSolidFill solidFillWithColor:[UIColor clearColor]];
}

- (void)sideDrawer:(TKSideDrawer *)sideDrawer updateVisualsForSection:(NSInteger)sectionIndex
{
    TKSideDrawerSection *section = sideDrawer.sections[sectionIndex];
    section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}

@end
