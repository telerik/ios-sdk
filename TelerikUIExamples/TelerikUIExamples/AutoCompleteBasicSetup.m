//
//  AutoCompleteBasicSetup.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "AutoCompleteBasicSetup.h"
#import "TelerikUI/TelerikUI.h"

@implementation AutoCompleteBasicSetup
{
    TKDataSource *_dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
    // >> autocmp-feed
    NSArray *sampleArrayOfStrings =@[@"Kristina Wolfe",@"Freda Curtis",@"Jeffery Francis",@"Eva Lawson", @"Theresa	Bryan", @"Jenny Fuller", @"Terrell Norris", @"Eric Wheeler", @"Julius Clayton", @"Alfredo Thornton", @"Roberto Romero",@"Orlando Mathis",@"Eduardo Thomas",@"Harry Douglas"];
    // << autocmp-feed
    
    // >> autocmp-src
    _dataSource = [[TKDataSource alloc] initWithArray:sampleArrayOfStrings];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:item];
        return token;
    }];
    // << autocmp-src
    
    // >> autocmp-init
    self.automaticallyAdjustsScrollViewInsets = NO;
    TKAutoCompleteTextView *autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame: CGRectMake(10, 80, self.view.bounds.size.width - 20, 40)];
    autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    autocomplete.dataSource = _dataSource;
    [self.view addSubview:autocomplete];
    // << autocmp-init
    
    
    // >> autocmp-completion
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeStartsWith;
    // << autocmp-completion
    
    // >> autocmp-char
    autocomplete.minimumCharactersToSearch = 1;
    autocomplete.suggestionViewHeight = self.view.bounds.size.height/4;
    // << autocmp-char
    
    autocomplete.textField.placeholder = @"Type a name";
    
    // >> autocmp-suggestmode
    autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggestAppend;
    // << autocmp-suggestmode
}

@end
