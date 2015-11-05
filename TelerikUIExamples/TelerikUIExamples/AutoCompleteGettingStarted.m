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
    UILabel *_titleLabel;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Contains" selector:@selector(containsSelected)];
        [self addOption:@"StartsWith" selector:@selector(prefixSelected)];
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
        _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.exampleBounds.origin.y, self.exampleBounds.size.width - 20, 30)];
         _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.exampleBounds.origin.y, self.exampleBounds.size.width - 20, 30)];
    }
    else {
         _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y + 25, self.exampleBounds.size.width - 20, 30)];
         _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y, self.exampleBounds.size.width - 20, 30)];
        
        self.navigationController.navigationBar.translucent = NO;
    }
   
    _autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_titleLabel];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _dataSource = [[TKDataSource alloc] initWithDataFromJSONResource:@"countries" ofType:@"json" rootItemKeyPath:@"data"];
    [_dataSource.settings.autocomplete createToken:^TKAutoCompleteToken *(NSUInteger dataIndex, id item) {
        TKAutoCompleteToken *token = [[TKAutoCompleteToken alloc] initWithText:[item valueForKey:@"country"]];
        token.image = [UIImage imageNamed:[item  valueForKey:@"flag"]];
        return token;
    }];
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeContains;
    
    _autocomplete.dataSource = _dataSource;
    _autocomplete.textField.placeholder = @"Choose country";
    [_autocomplete.closeButton setImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    _autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    _autocomplete.minimumCharactersToSearch = 1;
    _autocomplete.suggestionViewHeight = self.exampleBounds.size.height - self.exampleBounds.origin.y + 45;
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
}

-(void) containsSelected
{
    _dataSource.settings.autocomplete.completionMode = TKAutoCompleteCompletionModeContains;
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    _autocomplete.suggestionViewHeight = self.exampleBounds.size.height - height - 80;
}

- (void)keyboardDidHide:(NSNotification *) notification
{
    _autocomplete.suggestionViewHeight = self.exampleBounds.size.height - 100;
}

@end
