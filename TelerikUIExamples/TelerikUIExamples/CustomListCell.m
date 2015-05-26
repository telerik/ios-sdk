//
//  CustomListCell.m
//  TelerikUIExamples
//
//  Created by Tsvetan Raikov on 5/20/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "CustomListCell.h"

@implementation CustomListCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        
        self.textLabel.textColor =  [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:13];
        
        self.detailTextLabel.textColor =  [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
        self.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.colors = [NSArray arrayWithObjects: (id)[UIColor clearColor].CGColor, (id)[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8].CGColor, nil];
        self.gradient.locations = [NSArray arrayWithObjects: @(0.0), @(0.7), nil];
        [self.imageView.layer insertSublayer:self.gradient atIndex:0];

        ((TKView*)self.backgroundView).stroke.strokeSides = 0;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(14, CGRectGetHeight(self.frame) - 10 - 35, CGRectGetWidth(self.frame) - 28, 20);
    self.detailTextLabel.frame = CGRectMake(14, CGRectGetHeight(self.frame) - 15 - 10, CGRectGetWidth(self.frame) - 28, 15);
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.gradient.frame = CGRectMake(-2, CGRectGetHeight(self.frame)/2, CGRectGetWidth(self.frame) + 2, CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame)/2);
    [CATransaction commit];
    self.imageView.frame = self.bounds;
}

@end
