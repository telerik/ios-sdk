//
//  DSItem.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSItem : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) CGFloat value;

@property (nonatomic, copy) NSString *group;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSDate *date;

- (id)initWithName:(NSString*)name value:(CGFloat)value group:(NSString*)group;

@end
