//
//  DSCollectionViewCell.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "DSCollectionViewCell.h"

@implementation DSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat size = fminf(frame.size.width - 60, frame.size.height - 40);
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - size)/2., 0, size, size)];
        self.imageView.layer.cornerRadius = size/2.;
        self.imageView.layer.masksToBounds = YES;
        [self addSubview:self.imageView];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
    }
    return self;
}

@end
