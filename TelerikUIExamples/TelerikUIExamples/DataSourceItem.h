//
//  DataSourceItem.h
//  TelerikUIExamples
//
//  Created by Sophia Lazarova on 5/31/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSourceItem : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic) CGFloat value;

- (instancetype __nonnull)initWithName:(NSString*)name value:(CGFloat)value;

@property (nonatomic, copy) NSString *group;

- (instancetype __nonnull)initWithName:(NSString*)name value:(CGFloat)value group:(NSString*)group;

@property (nonatomic, strong) NSDate *startDate;

@property (nonatomic, strong) NSDate *endDate;

@end

