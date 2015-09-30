//
//  LanguageChoice.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import "AppendSuggestMode.h"
#import <TelerikUI/TelerikUI.h>

@interface AppendSuggestMode()<TKAutoCompleteTextViewDelegate>

@end

@implementation AppendSuggestMode
{
    TKAutoCompleteTextView *_autocomplete;
    UILabel *_codeImplementationLabel;
    NSArray *_languages;
    TKDataSource *datasource;
    NSMutableArray *_data;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _languages = [NSArray arrayWithObjects:@"ActionScript",@"Bash", @"C#", @"Objective-C", @"C", @"C++", @"JavaScript", @"Java", @"Ruby", @"Python", @"Swift", @"Pascal", @"Php",
                  nil];
    
    _data = [NSMutableArray new];
    for (int i = 0; i < _languages.count; i++) {
        TKAutoCompleteTextViewToken *token = [[TKAutoCompleteTextViewToken alloc] initWithText:_languages[i]];
        [_data addObject:token];
    }
  datasource = [[TKDataSource alloc] initWithDataFromJSONResource:@"languages" ofType:@"json" rootItemKeyPath:@"items"];
    _codeImplementationLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, self.exampleBounds.size.height/2 + 40, self.exampleBounds.size.width - 50, 150)];
    _codeImplementationLabel.numberOfLines = 0;
    _codeImplementationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _codeImplementationLabel.font = [UIFont fontWithName:@"Menlo" size:14];
    
    [self.view addSubview:_codeImplementationLabel];
    
    _autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.exampleBounds.size.height/3 - 15, self.exampleBounds.size.width - 20, 30)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _autocomplete.layer.borderColor = [UIColor colorWithRed:0.427f green:0.373f blue:0.361f alpha:1.00f].CGColor;
    _autocomplete.layer.borderWidth = 1;
    _autocomplete.layer.cornerRadius = 5;
    
    _autocomplete.suggestionsList = _data;
    _autocomplete.readOnly = NO;
    
    _autocomplete.displayMode = TKAutoCompleteTextViewDisplayModePlain;
    _autocomplete.suggestMode = TKAutoCompleteTextViewSuggestModeAppend;
    
    _autocomplete.delegate = self;

    _autocomplete.closeButton.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"clear"]];
    _autocomplete.imageView.image = [UIImage imageNamed:@"search"];
    _autocomplete.textField.placeholder = @"Choose Programming Language";
    
    _autocomplete.layer.borderColor = [UIColor clearColor].CGColor;
    _autocomplete.stroke = [TKStroke strokeWithColor:[UIColor lightGrayColor]];
    _autocomplete.stroke.strokeSides = TKRectSideBottom;
    _autocomplete.minimumCharactersToSearch = 1;
    [self.view addSubview:_autocomplete];
}

-(void)autoComplete:(TKAutoCompleteTextView *)autocomplete didAutoComplete:(NSString *)completion
{
    for (int i = 0; i < datasource.items.count; i++) {
        NSDictionary *current = datasource.items[i];
        if ([[current valueForKey:@"name"] isEqualToString:completion]) {
            NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            style.alignment = NSTextAlignmentJustified;
            style.firstLineHeadIndent = 10.0f;
            style.headIndent = 10.0f;
            style.tailIndent = -10.0f;
            
            NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:[current valueForKey:@"code"] attributes:@{ NSParagraphStyleAttributeName : style}];
            _codeImplementationLabel.attributedText = attrText;
            break;
        }
    }
}

@end
