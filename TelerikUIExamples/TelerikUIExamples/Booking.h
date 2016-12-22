//
//  Booking.h
//  TelerikUIExamples
//
//  Created by Vladimir Amiorkov on 12/22/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Booking : NSObject

@property (nonatomic, strong) NSArray *from;

@property (nonatomic, strong) NSString *to;

@property (nonatomic) BOOL sendAllTraffic;

@end
