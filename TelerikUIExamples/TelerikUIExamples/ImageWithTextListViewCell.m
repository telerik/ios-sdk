//
//  ImageWithTextListViewCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "ImageWithTextListViewCell.h"

@implementation ImageWithTextListViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];

        self.textLabel.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.font =[UIFont fontWithName:@"Optima-Regular" size:16];
        self.textLabel.layer.cornerRadius = 3;
        self.textLabel.layer.masksToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15 , 0, 120, 150);
    self.textLabel.frame = CGRectMake(0, self.imageView.frame.size.height, self.frame.size.width, 60);
}

@end
