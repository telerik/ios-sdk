//
//  LoremIpsumGenerator.h
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoremIpsumGenerator : NSObject

- (NSString*)generateString:(NSInteger)wordCount;

- (NSString*)randomString:(NSInteger)wordCount forIndexPath:(NSIndexPath*)indexPath;

@end
