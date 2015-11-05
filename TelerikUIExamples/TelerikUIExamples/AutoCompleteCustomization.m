//
//  AutoCompleteTokens.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "AutoCompleteCustomization.h"
#import "PersonListViewCell.h"
#import "ImageWithTextListViewCell.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteCustomization ()<TKAutoCompleteDelegate>

@end

@implementation AutoCompleteCustomization
{
    TKDataSource *_dataSource;
    TKAutoCompleteTextView*_autocomplete;
    TKView *_view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _view = [[TKView alloc]initWithFrame:self.view.bounds];
    _view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    TKFill *fill = [TKLinearGradientFill linearGradientFillWithColors:@[
                                                                        [UIColor colorWithRed:0.35 green:0.68 blue:0.89 alpha:0.89],
                                                                        [UIColor colorWithRed:0.35 green:0.68 blue:1.00 alpha:1.0],
                                                                        [UIColor colorWithRed:0.85 green:0.8 blue:0.2 alpha:0.8]
                                                                        ]];
    _view.fill = fill;
    [self.view addSubview:_view];

    _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10,self.exampleBounds.origin.y + 5, self.exampleBounds.size.width - 20, 30)];
    _autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_autocomplete];
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"namesPhotos" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken * _Nullable(NSUInteger dataIndex, id  _Nonnull item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"name"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"photo"]];
        return token;
    }];
    
    TKListView *listView = (TKListView*)_autocomplete.suggestionView;
    
    listView.frame = CGRectMake(10,self.exampleBounds.origin.y + 40, self.view.bounds.size.width - 20, self.exampleBounds.size.height - (15 + _autocomplete.bounds.size.height));
    listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [listView removeFromSuperview];
    [self.view addSubview:listView];
    
    [listView registerClass:[ImageWithTextListViewCell class] forCellWithReuseIdentifier:@"cell"];

    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    layout.spanCount = 2;
    layout.itemSize = CGSizeMake(150, 200);
    layout.lineSpacing = 60;
    layout.itemSpacing = 10;
    listView.layout = layout;
    listView.backgroundColor = [UIColor clearColor];
    
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggestAppend;
    
    UIImage *btnImage = [UIImage imageNamed:@"clear.png"];
    [_autocomplete.closeButton setImage:btnImage forState:UIControlStateNormal];
    
    _autocomplete.maximumWrapHeight = 50;
    _autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    
    _autocomplete.textField.placeholder = @"Enter User";
    _autocomplete.noResultsLabel.text = @"No Users Found";
    
    _autocomplete.dataSource = _dataSource;
    _autocomplete.backgroundColor = [UIColor whiteColor];
    _autocomplete.delegate = self;
    _autocomplete.showAllItemsInitially = YES;
}

#pragma mark - TKAutoCompleteDelegate

- (TKAutoCompleteTokenView *)autoComplete:(TKAutoCompleteTextView*)autocomplete viewForToken:(TKAutoCompleteToken *)token
{
    TKAutoCompleteTokenView *tokenView = [[TKAutoCompleteTokenView alloc] initWithToken:token];
    tokenView.backgroundColor = [UIColor lightGrayColor];
    tokenView.layer.cornerRadius = 10;
    tokenView.imageView.layer.cornerRadius = 3;
    return tokenView;
}

- (void)autoComplete:(TKAutoCompleteTextView *)autocomplete didAddToken:(TKAutoCompleteToken *)token
{
    [(TKListView *)_autocomplete.suggestionView scrollToItemAtIndexPath:((TKSuggestionListView *)_autocomplete.suggestionView).selectedIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

@end
