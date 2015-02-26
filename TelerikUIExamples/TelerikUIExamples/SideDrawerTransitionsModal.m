//
//  SideDrawerTransitionsModal.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerTransitionsModal.h"
#import "SideDrawerHeaderView.h"

@interface SideDrawerTransitionsModal ()

@end

@implementation SideDrawerTransitionsModal

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createButtonWithTitle:@"Push" target:self selector:@selector(pushTransition) origin:CGPointMake(15, 80)];
    [self createButtonWithTitle:@"Reveal" target:self selector:@selector(revealTransition) origin:CGPointMake(15, 130)];
    [self createButtonWithTitle:@"Reverse Slide Out" target:self selector:@selector(reverseSlideOutTransition) origin:CGPointMake(15, 180)];
    [self createButtonWithTitle:@"Slide Along" target:self selector:@selector(slideAlongTransition) origin:CGPointMake(15, 230)];
    [self createButtonWithTitle:@"Slide In On Top" target:self selector:@selector(slideInOnTopTransition) origin:CGPointMake(15, 280)];
    [self createButtonWithTitle:@"Scale Up" target:self selector:@selector(scaleUpTransition) origin:CGPointMake(15, 330)];
    [self createButtonWithTitle:@"Fade In" target:self selector:@selector(fadeInTransition) origin:CGPointMake(15, 380)];
}

- (void)createButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector origin:(CGPoint)origin
{
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(origin.x, origin.y, titleSize.width, 44)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setCornerRadius:3.f];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pushTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypePush;
    sideDrawer.headerView = [[SideDrawerHeaderView alloc] initWithButton:NO target:nil selector:nil];
    [self showSideDrawer];
}

- (void)revealTransition
{
    TKSideDrawer *sideDrawer = self.sideDrawer;
    sideDrawer.fill = [TKSolidFill solidFillWithColor:[UIColor grayColor]];
    sideDrawer.transition = TKSideDrawerTransitionTypeReveal;
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
