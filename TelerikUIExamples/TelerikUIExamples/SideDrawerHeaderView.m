//
//  SideDrawerHeaderView.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SideDrawerHeaderView.h"
#import <TelerikUI/TelerikUI.h>

@implementation SideDrawerHeaderView
{
    TKSideDrawerHeader *_sideDrawerHeader;
}

- (id)initWithButton:(BOOL)addButton target:(id)target selector:(SEL)selector
{
    self = [super init];
    if (self) {
        _sideDrawerHeader = [[TKSideDrawerHeader alloc] initWithTitle:@"Navigation Menu"];
        _sideDrawerHeader.contentInsets = UIEdgeInsetsMake(-15, 0, 0, 0);
        if (addButton) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
            [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
            _sideDrawerHeader.actionButton = button;
            _sideDrawerHeader.contentInsets = UIEdgeInsetsMake(-15, -20, 0, 0);
            _sideDrawerHeader.buttonPosition = TKSideDrawerHeaderButtonPositionLeft;
        }
        
        [self addSubview:_sideDrawerHeader];
    }
    
    return self;
}

- (void)layoutSubviews
{
    _sideDrawerHeader.frame = self.bounds;
}


@end
