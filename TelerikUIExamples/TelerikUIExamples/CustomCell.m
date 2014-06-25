//
//  CustomCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "CustomCell.h"

static UIImage *gDayImage;
static UIImage *gSelectedDayImage;
static UIImage *gCurrentDayImage;

@interface CustomCell ()

@property (nonatomic, weak) UIImage *currentImg;

@end

@implementation CustomCell

+ (void)initialize
{
    gDayImage = [UIImage imageNamed:@"calendar_cell"];
    gDayImage = [gDayImage resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4) resizingMode:UIImageResizingModeStretch];
    
    gCurrentDayImage = [UIImage imageNamed:@"calendar_current_cell"];
    gCurrentDayImage = [gCurrentDayImage resizableImageWithCapInsets:UIEdgeInsetsMake(4, 4, 4, 4) resizingMode:UIImageResizingModeStretch];
    
    gSelectedDayImage = [UIImage imageNamed:@"calendar_selected_cell"];
    gSelectedDayImage = [gSelectedDayImage resizableImageWithCapInsets:UIEdgeInsetsMake(12, 12, 12, 12) resizingMode:UIImageResizingModeStretch];
}

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
    
    self.style.backgroundColor = [UIColor clearColor];
    self.style.shape = nil;
    self.style.topBorderColor = nil;
    self.style.bottomBorderColor = nil;
    
    if (self.state & TKCalendarDayStateSelected) {
        self.currentImg = gSelectedDayImage;
    }
    else if (self.state & TKCalendarDayStateToday) {
        self.currentImg = gCurrentDayImage;
        self.label.textColor = [UIColor whiteColor];
    }
    else {
        self.currentImg = gDayImage;
    }
}

- (void)drawRect:(CGRect)rect
{
    [self.currentImg drawInRect:rect];
    [super drawRect:rect];
}

@end
