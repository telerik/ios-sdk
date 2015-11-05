//
//  AutoCompleteCustomization.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "AutoCompleteTokens.h"
#import "PersonListViewCell.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteTokens ()<TKAutoCompleteDelegate>

@end

@implementation AutoCompleteTokens
{
    TKDataSource *_dataSource;
    TKAutoCompleteTextView*_autocomplete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.exampleBounds.origin.y, self.exampleBounds.size.width - 20, 30)];
    
    _autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_autocomplete];
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"namesPhotos" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken * _Nullable(NSUInteger dataIndex, id  _Nonnull item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"name"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"photo"]];
        return token;
    }];
    
    TKListView *listView = (TKListView*)_autocomplete.suggestionView;
    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    layout.itemSize = CGSizeMake(120, 150);
    layout.spanCount = 2;
    layout.itemSpacing = 20;
    layout.lineSpacing = 20;
    listView.layout = layout;
    [listView registerClass:[PersonListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    _autocomplete.dataSource = _dataSource;
    _autocomplete.displayMode = TKAutoCompleteDisplayModeTokens;
    _autocomplete.layoutMode = TKAutoCompleteLayoutModeWrap;
    
    _autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    _autocomplete.delegate = self;
    _autocomplete.textField.placeholder = @"Enter Users";
    _autocomplete.noResultsLabel.text = @"No Users Found";
    _autocomplete.minimumCharactersToSearch = 1;
    
    _autocomplete.suggestionViewHeight = self.exampleBounds.size.height - self.exampleBounds.origin.y + 45;
    _autocomplete.stroke.strokeSides = TKRectSideBottom;
}

#pragma mark - TKAutoCompleteDelegate

-(TKAutoCompleteTokenView *)autoComplete:(TKAutoCompleteTextView*)autocomplete viewForToken:(TKAutoCompleteToken *)token
{
    TKAutoCompleteTokenView *tokenView = [[TKAutoCompleteTokenView alloc] initWithToken:token];
    tokenView.backgroundColor = [UIColor lightGrayColor];
    tokenView.layer.cornerRadius = 10;
    tokenView.imageView.layer.cornerRadius = 5;
    return tokenView;
}

@end
