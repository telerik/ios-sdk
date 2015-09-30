//
//  AutoCompleteCustomization.m
//  TelerikUIExamples
//
//  Created by Sophia Lazarova on 9/22/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "AutoCompleteWrap.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteWrap ()<TKAutoCompleteTextViewDelegate>

@end

@implementation AutoCompleteWrap
{
    TKDataSource *_dataSourceEmails;
    TKDataSource *_dataSourceNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    _dataSourceNames = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"names"];
    _dataSourceEmails = [[TKDataSource alloc] initWithDataFromJSONResource:@"PhotosWithNames" ofType:@"json" rootItemKeyPath:@"emails"];
    [_dataSourceNames.settings.autocomplete createToken:^TKAutoCompleteTextViewToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteTextViewToken *token = [[TKAutoCompleteTextViewToken alloc] initWithText:item];
        token.detailText = _dataSourceEmails.items[dataIndex];
        return token;
    }];
    
    NSArray *titles = @[ @"To:", @"Cc:", @"Bcc" ];
    CGFloat height = 30;
    for (int i = 0; i<titles.count; i++) {
        NSString *title = titles[i];
        TKAutoCompleteTextView *autocompleteTo = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, 90 + height*i, self.view.bounds.size.width-10, height)];
        autocompleteTo.dataSource = _dataSourceNames;
        autocompleteTo.titleLabel.text = title;
        [self.view addSubview:autocompleteTo];
        
        [self setupAutoCompleteField:autocompleteTo];
    }
}

- (void)setupAutoCompleteField:(TKAutoCompleteTextView*)autocomplete
{
    autocomplete.layer.borderColor = [UIColor clearColor].CGColor;
    autocomplete.titleLabel.textColor = [UIColor lightGrayColor];
    autocomplete.stroke = [TKStroke strokeWithColor:[UIColor lightGrayColor]];
    autocomplete.stroke.strokeSides = TKRectSideBottom;
    autocomplete.displayMode = TKAutoCompleteTextViewDisplayModeTokens;
    autocomplete.noResultsLabel.text = @"No Users Found";
    autocomplete.delegate = self;
}

#pragma mark - TKAutoCompleteTextViewDelegate

- (TKAutoCompleteTextViewTokenView *)autoComplete:(TKAutoCompleteTextView *)autocomplete viewForToken:(TKAutoCompleteTextViewToken *)token
{
    TKAutoCompleteTextViewTokenView *tokenView = [[TKAutoCompleteTextViewTokenView alloc ] initWithToken:token];
    tokenView.layer.cornerRadius = 0;
    tokenView.backgroundColor = [UIColor clearColor];
    tokenView.isCloseButtonVisisble = NO;
    tokenView.delimeter = @",";
    tokenView.tokenHighlightColor = [UIColor colorWithRed:0.000f green:0.478f blue:1.000f alpha:1.00f];
    tokenView.clipsToBounds = NO;
    return tokenView;
}

@end
