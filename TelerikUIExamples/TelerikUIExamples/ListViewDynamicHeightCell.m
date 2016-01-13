//
//  ListViewDynamicHeightCell.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "ListViewDynamicHeightCell.h"

@implementation ListViewDynamicHeightCell
{
    BOOL wasLayout;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.numberOfLines = 0;
        [self addSubview:label];
        self.label = label;
        
        NSDictionary *views = @{ @"view": self.label };
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[view]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[view]-10-|" options:0 metrics:nil views:views]];
    }
    return self;
}

- (void)layoutSubviews
{
    self.label.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds)-20;
    [super layoutSubviews];
}

@end
