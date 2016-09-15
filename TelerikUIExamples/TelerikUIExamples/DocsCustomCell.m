//
//  DocsCustomCell.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DocsCustomCell.h"
#import <TelerikUI/TelerikUI.h>

// >> customization-customcell
@implementation DocsCustomCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)updateVisuals
{
    [super updateVisuals];
    
    if (self.state & TKCalendarDayStateToday) {
        self.label.textColor = [UIColor redColor];
    }
    else {
        self.label.textColor = [UIColor blueColor];
    }
}

@end
// << customization-customcell