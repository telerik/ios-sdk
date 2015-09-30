//
//  StockDataPoint.h
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>

@interface StockDataPoint : TKChartFinancialDataPoint<NSCoding>

+ (NSArray *)stockPoints;

+ (NSArray *)stockPoints:(NSInteger)count;

- (NSArray *)loadFromJson;

@end
