//
//  SearchModes.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "AutoCompleteSearchModes.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteSearchModes ()
@end

@implementation AutoCompleteSearchModes
{
    TKDataSource *_prefixModeDataSource;
    TKDataSource *_containsModeDataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _prefixModeDataSource =[[TKDataSource alloc] initWithDataFromJSONResource:@"countries" ofType:@"json" rootItemKeyPath:@"data"];
    [_prefixModeDataSource.settings.autocomplete createToken:^TKAutoCompleteTextViewToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteTextViewToken *token = [[TKAutoCompleteTextViewToken alloc] initWithText:[item valueForKey:@"country"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"flag"]];
        return token;
    }];
    
    _containsModeDataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"countries" ofType:@"json" rootItemKeyPath:@"data"];
    [_containsModeDataSource.settings.autocomplete createToken:^TKAutoCompleteTextViewToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteTextViewToken *token = [[TKAutoCompleteTextViewToken alloc] initWithText:[item valueForKey:@"country"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"flag"]];
        return token;
    }];

    _prefixModeDataSource.settings.autocomplete.highlightMatch = YES;
    _containsModeDataSource.settings.autocomplete.completionMode = TKAutoCompleteTextViewCompletetionModeContains;
    
    UILabel *prefixTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, self.exampleBounds.size.width - 20, 30)];
    prefixTitleLabel.text = @"Search by prefix:";
    [self.view addSubview:prefixTitleLabel];
    
    UILabel *containsTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, self.exampleBounds.size.width - 20, 30)];
    containsTitleLabel.text = @"Search by contains:";
    [self.view addSubview:containsTitleLabel];
    
    TKAutoCompleteTextView *searchByPrefix = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, 110, self.exampleBounds.size.width - 20, 30)];
    searchByPrefix.dataSource = _prefixModeDataSource;
    [self.view addSubview:searchByPrefix];
    
    TKAutoCompleteTextView *searchByContains = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, 260, self.exampleBounds.size.width - 20, 30)];
    searchByContains.dataSource = _containsModeDataSource;
    [self.view addSubview:searchByContains];

    [self setupAutocomplete:searchByPrefix];
    [self setupAutocomplete:searchByContains];
}

-(void)setupAutocomplete:(TKAutoCompleteTextView*)autocomplete
{
    autocomplete.closeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clear"]];
    autocomplete.imageView.image = [UIImage imageNamed:@"search"];
    autocomplete.layer.borderColor = [UIColor clearColor].CGColor;
    autocomplete.stroke = [TKStroke strokeWithColor:[UIColor lightGrayColor]];
    autocomplete.textField.placeholder = @"Choose country";
    autocomplete.stroke.strokeSides = TKRectSideBottom;
}

@end
