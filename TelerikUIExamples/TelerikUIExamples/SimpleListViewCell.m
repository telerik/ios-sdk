//
//  SimpleListViewCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "SimpleListViewCell.h"

@implementation SimpleListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize desiredSize = [self.textLabel sizeThatFits:self.bounds.size];
    self.textLabel.frame = CGRectMake(1, self.bounds.size.height - desiredSize.height - 6, self.bounds.size.width - 2, desiredSize.height - 2);
    self.imageView.frame = CGRectMake((self.bounds.size.width - 100)/2., 5, 100, self.bounds.size.height - (self.textLabel.bounds.size.height + 17));
}

@end
