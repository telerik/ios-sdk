//
//  CustomCardListViewCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "CustomCardListViewCell.h"

@implementation CustomCardListViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.height-20;
    self.imageView.frame = CGRectMake(0, 10, width, width);
    CGSize desiredSize = [self.textLabel sizeThatFits:self.bounds.size];
    CGFloat x = self.imageView.frame.origin.x + self.imageView.bounds.size.width + 10;
    self.textLabel.frame = CGRectMake(x, 10, desiredSize.width, desiredSize.height);
    CGFloat height = self.contentView.bounds.size.height - self.textLabel.frame.size.height - 30;
    desiredSize = [self.detailTextLabel sizeThatFits:CGSizeMake(self.contentView.bounds.size.width - x - 10, height)];
    self.detailTextLabel.frame = CGRectMake(x, 10 + self.textLabel.frame.origin.y + self.textLabel.frame.size.height,
                                            self.contentView.bounds.size.width - x - 10, MIN(desiredSize.height, height));
}

@end
