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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.autocomplete = [[TKAutoCompleteTextView alloc] init];
    self.autocomplete.frame = CGRectMake(10, self.view.bounds.origin.y + 5, self.view.bounds.size.width - 20, 44);
    self.autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"namesPhotos" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken * _Nullable(NSUInteger dataIndex, id  _Nonnull item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"name"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"photo"]];
        return token;
    }];
    
    TKListView *listView = (TKListView*)self.autocomplete.suggestionView;
    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    layout.itemSize = CGSizeMake(120, 150);
    layout.spanCount = 2;
    layout.itemSpacing = 20;
    layout.lineSpacing = 20;
    listView.layout = layout;
    [listView registerClass:[PersonListViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.autocomplete.dataSource = _dataSource;
    self.autocomplete.displayMode = TKAutoCompleteDisplayModeTokens;
    self.autocomplete.layoutMode = TKAutoCompleteLayoutModeWrap;
    
    self.autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    self.autocomplete.delegate = self;
    self.autocomplete.textField.placeholder = @"Enter Users";
    self.autocomplete.noResultsLabel.text = @"No Users Found";
    self.autocomplete.minimumCharactersToSearch = 1;
    self.autocomplete.maximumWrapHeight = 200;

    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - self.view.bounds.origin.y + 45;
}

#pragma mark - TKAutoCompleteDelegate

-(TKAutoCompleteTokenView *)autoComplete:(TKAutoCompleteTextView*)autocomplete viewForToken:(TKAutoCompleteToken *)token
{
    TKAutoCompleteTokenView *tokenView = [[TKAutoCompleteTokenView alloc] initWithToken:token];
    tokenView.backgroundColor = [UIColor colorWithRed:0.910 green:0.910 blue:0.910 alpha:1.00];
    return tokenView;
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - height - 55;
}

- (void)keyboardDidHide:(NSNotification *) notification
{
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;
}

@end
