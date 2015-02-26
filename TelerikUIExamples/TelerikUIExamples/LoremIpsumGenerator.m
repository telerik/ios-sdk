//
//  LoremIpsumGenerator.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "LoremIpsumGenerator.h"

@implementation LoremIpsumGenerator
{
    NSArray *_words;
    NSMutableDictionary *_rows;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _words = @[ @"lorem", @"ipsum", @"dolor", @"sit", @"amet", @"consectetuer", @"adipiscing", @"elit", @"integer", @"in", @"mi", @"a", @"mauris" ];
        _rows = [NSMutableDictionary new];
    }
    return self;
}

- (NSString *)generateString:(NSInteger)wordCount
{
    NSMutableString *randomStr = [NSMutableString new];
    for (int i = 0; i<wordCount; i++) {
        [randomStr appendString:_words[arc4random() % _words.count]];
        [randomStr appendString:@" "];
    }
    return randomStr;
}

- (NSString*)randomString:(NSInteger)wordCount forIndexPath:(NSIndexPath*)indexPath
{
    NSString *text = [_rows objectForKey:indexPath];
    if (!text) {
        text = [self generateString:wordCount];
        [_rows setObject:text forKey:indexPath];
    }
    return text;
}

@end
