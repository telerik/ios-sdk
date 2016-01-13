//
//  CountriesExample.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "AutoCompleteGettingStarted.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteGettingStarted()
@end

@implementation AutoCompleteGettingStarted
{
    TKDataSource *_dataSource;
    TKAutoCompleteTextView*_autocomplete;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [self addOption:@"Contains" selector:@selector(containsSelected) inSection:@"Completion Modes"];
        [self addOption:@"Starts With" selector:@selector(prefixSelected) inSection:@"Completion Modes"];
        
        [self addOption:@"Append" selector:@selector(appendSelected) inSection:@"Suggest Modes"];
        [self addOption:@"Suggest-Append" selector:@selector(suggestAppendSelected) inSection:@"Suggest Modes"];
        [self addOption:@"Suggest" selector:@selector(suggestSelected) inSection:@"Suggest Modes"];
        
        [self setSelectedOption:2 inSection:1];

    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];


    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y, self.view.bounds.size.width - 20, 44)];
    }
    else {
         _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y + 25, self.view.bounds.size.width - 20, 44)];
        self.navigationController.navigationBar.translucent = NO;
    }
   
    _autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"countries" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"country"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"flag"]];
        return token;
    }];
    
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeContains;
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggest;
    _autocomplete.dataSource = _dataSource;
    _autocomplete.textField.placeholder = @"Choose country";
    [_autocomplete.closeButton setImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    _autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    _autocomplete.minimumCharactersToSearch = 1;
    [self.view addSubview:_autocomplete];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (parent == nil) {
      self.navigationController.navigationBar.translucent = YES;
    }
    
    [super willMoveToParentViewController:parent];
}

-(void) prefixSelected
{
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeStartsWith;
    [_autocomplete resetAutocomplete];
}

-(void) containsSelected
{
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeContains;
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggest;
    [self setSelectedOption:2 inSection:1];
    [_autocomplete resetAutocomplete];
}

-(void) suggestAppendSelected
{
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggestAppend;
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeStartsWith;
    [self setSelectedOption:1 inSection:0];
    [_autocomplete resetAutocomplete];
}
-(void) appendSelected
{
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeAppend;
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeStartsWith;
    [self setSelectedOption:1 inSection:0];
    [_autocomplete resetAutocomplete];
}

-(void) suggestSelected
{
    _autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggest;
    [_autocomplete resetAutocomplete];
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    _autocomplete.suggestionViewHeight = self.view.bounds.size.height - height - 80;
}

- (void)keyboardDidHide:(NSNotification *) notification
{
    _autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;
}

@end
