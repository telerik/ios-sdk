//
//  AnimationListCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "AnimationListCell.h"

@implementation AnimationListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;

        TKView *view = (TKView*)self.backgroundView;
        view.stroke = [TKStroke strokeWithColor:[UIColor colorWithWhite:0.9 alpha:0.9] width:0.5];
        
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame = CGRectInset(self.contentView.frame, 1, 1);
}

@end
