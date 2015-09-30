//
//  SearchModes.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "SearchModes.h"
#import <TelerikUI/TelerikUI.h>

@interface SearchModes ()

@end

@implementation SearchModes
{
    TKAutoCompleteTextView *_autocomplete;
    TKDataSource *_datasource;
    NSMutableArray *_dataPrefix;
    NSArray *_countryNames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _dataPrefix = [NSMutableArray new];
    
    _datasource =[[TKDataSource alloc] initWithDataFromJSONResource:@"countries" ofType:@"json" rootItemKeyPath:@"data"];
    [_datasource.settings.autocomplete createToken:^TKAutoCompleteTextViewToken * _Nullable(NSUInteger dataIndex, id  _Nonnull item) {
        TKAutoCompleteTextViewToken *token = [[TKAutoCompleteTextViewToken alloc] initWithText:[item valueForKey:@"country"]];
        token.owner = _autocomplete;
        token.image = [UIImage imageNamed:[item  valueForKey:@"flag"]];
        return token;
    }];
    
    _datasource.settings.autocomplete.highlightMatch = YES;
    
    UILabel *prefixTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 130, 30)];
    prefixTitleLabel.text = @"Search mode:";
    [self.view addSubview:prefixTitleLabel];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Prefix", @"Contains"]];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(searchModeChanged:) forControlEvents: UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(prefixTitleLabel.bounds.size.width + 10, 80, self.view.bounds.size.width - prefixTitleLabel.bounds.size.width - 20, 30);
    [self.view addSubview:segmentedControl];
    
    _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, 160, self.exampleBounds.size.width - 20, 20)];
    _autocomplete.dataSource = _datasource;
    [self setupAutocomplete:_autocomplete];
    [self.view addSubview:_autocomplete];
    
}

-(void)setupAutocomplete:(TKAutoCompleteTextView*)autocomplete
{
    autocomplete.closeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"clear"]];
    autocomplete.imageView.image = [UIImage imageNamed:@"search"];
    autocomplete.layer.borderColor = [UIColor clearColor].CGColor;
    autocomplete.stroke = [TKStroke strokeWithColor:[UIColor lightGrayColor]];
    autocomplete.textField.placeholder = @"Choose country";
    autocomplete.stroke.strokeSides = TKRectSideBottom;
    autocomplete.minimumCharactersToSearch = 1;
}

-(void)searchModeChanged:(UISegmentedControl*)segment
{
    if (segment.selectedSegmentIndex == 0) {
        _datasource.settings.autocomplete.completionMode = TKAutoCompleteTextViewCompletetionModePrefix;
    }
    else {
         _datasource.settings.autocomplete.completionMode = TKAutoCompleteTextViewCompletetionModeContains;
    }
}
@end
