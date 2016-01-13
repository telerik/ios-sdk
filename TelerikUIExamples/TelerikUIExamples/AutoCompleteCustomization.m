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
    TKView *_view;
    TKListView *_listView;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

   self.autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y + 5, self.view.bounds.size.width - 20, 44)];
    self.autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.autocomplete.suggestionViewOutOfFrame = YES;
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"namesPhotos" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken * _Nullable(NSUInteger dataIndex, id  _Nonnull item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"name"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"photo"]];
        return token;
    }];
    
    _listView = (TKListView*)self.autocomplete.suggestionView;
    
    _listView.frame = CGRectMake(10, self.view.bounds.origin.y + 50, self.view.bounds.size.width - 20, self.view.bounds.size.height - (15 + self.autocomplete.bounds.size.height));
    _listView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [_listView removeFromSuperview];
    [self.view addSubview:_listView];
    
    [_listView registerClass:[ImageWithTextListViewCell class] forCellWithReuseIdentifier:@"cell"];

    TKListViewGridLayout *layout = [TKListViewGridLayout new];
    layout.itemAlignment = TKListViewItemAlignmentCenter;
    layout.spanCount = 2;
    layout.itemSize = CGSizeMake(150, 200);
    layout.lineSpacing = 60;
    layout.itemSpacing = 10;
    _listView.layout = layout;
    _listView.backgroundColor = [UIColor clearColor];
    
    self.autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggestAppend;
    
    UIImage *btnImage = [UIImage imageNamed:@"clear.png"];
    [self.autocomplete.closeButton setImage:btnImage forState:UIControlStateNormal];
    
    self.autocomplete.maximumWrapHeight = 50;
    self.autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    
    self.autocomplete.textField.placeholder = @"Enter User";
    self.autocomplete.noResultsLabel.text = @"No Users Found";
    
    self.autocomplete.dataSource = _dataSource;
    self.autocomplete.showAllItemsInitially = YES;
    
    self.autocomplete.backgroundColor = [UIColor whiteColor];
    self.autocomplete.delegate = self;
    
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
    [(TKListView *)self.autocomplete.suggestionView scrollToItemAtIndexPath:((TKSuggestionListView *)self.autocomplete.suggestionView).selectedIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - height - 50;
}

- (void)keyboardDidHide:(NSNotification *) notification
{
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;
}

@end
