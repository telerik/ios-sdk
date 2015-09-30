//
//  StockDataPoint.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "StockDataPoint.h"

@implementation StockDataPoint

+ (NSArray *)stockPoints
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"applestock" ofType:@"plist"];
    NSArray *items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return items;
}

+ (NSArray *)stockPoints:(NSInteger)count
{
    NSArray *stockPoints = [StockDataPoint stockPoints];
    
    NSMutableArray *dataPoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        [dataPoints addObject:stockPoints[i]];
    }
    
    return dataPoints;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init]) {
        
        self.dataXValue = [aDecoder decodeObjectForKey:@"x"];
        self.dataYValue = [aDecoder decodeObjectForKey:@"y"];
        self.dataName = [aDecoder decodeObjectForKey:@"n"];
        self.open = [aDecoder decodeObjectForKey:@"o"];
        self.high = [aDecoder decodeObjectForKey:@"h"];
        self.low = [aDecoder decodeObjectForKey:@"l"];
        self.close = [aDecoder decodeObjectForKey:@"c"];
        self.volume = [aDecoder decodeObjectForKey:@"v"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dataXValue forKey:@"x"];
    [aCoder encodeObject:self.dataYValue forKey:@"y"];
    [aCoder encodeObject:self.dataName forKey:@"n"];
    [aCoder encodeObject:self.open forKey:@"o"];
    [aCoder encodeObject:self.high forKey:@"h"];
    [aCoder encodeObject:self.low forKey:@"l"];
    [aCoder encodeObject:self.close forKey:@"c"];
    [aCoder encodeObject:self.volume forKey:@"v"];
}

- (NSArray *)loadFromJson
{
    
    NSMutableArray *dataPoints = [NSMutableArray new];
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"AppleStockPrices" ofType:@"json"];
    NSData* json = [NSData dataWithContentsOfFile:filePath];
    
    NSArray* data = [NSJSONSerialization JSONObjectWithData:json
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    for (NSDictionary* jsonPoint  in data) {
        StockDataPoint *datapoint = [StockDataPoint new];
        datapoint.dataXValue = [self dateFromString:jsonPoint[@"date"]];
        datapoint.open = jsonPoint[@"open"];
        datapoint.high = jsonPoint[@"high"];
        datapoint.low = jsonPoint[@"low"];
        datapoint.close = jsonPoint[@"close"];
        datapoint.volume = jsonPoint[@"volume"];
        [dataPoints addObject:datapoint];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = nil;
    
    if (documentsDirectory) {
        fileName = [NSString stringWithFormat:@"%@/applestock.plist",documentsDirectory];
    }
    
//    NSMutableData *arcData = [[NSMutableData alloc] init];
//    NSKeyedArchiver *arc = [[NSKeyedArchiver alloc] initForWritingWithMutableData:arcData];
//    [arc setOutputFormat:NSPropertyListBinaryFormat_v1_0];
//    [arc encodeObject:dataPoints];
//    [arc finishEncoding];
//    [arcData writeToFile:fileName atomically:YES];
    
    [NSKeyedArchiver archiveRootObject:dataPoints toFile:fileName];
    
    NSLog(@"file name:%@", fileName);
    return dataPoints;
}

- (NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [formatter dateFromString:string];
    return date;
}

@end
