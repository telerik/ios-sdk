//
//  AutoCompleteLoadData.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "AutoCompleteLoadData.h"
#import <TelerikUI/TelerikUI.h>

@interface AutoCompleteLoadData() <TKAutoCompleteDataSource>

@end

@implementation AutoCompleteLoadData
{
    NSString *_url;
    NSArray *_airports;
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

    self.autocomplete = [[TKAutoCompleteTextView alloc] initWithFrame:CGRectMake(10, self.view.bounds.origin.y + 25, self.view.bounds.size.width - 20, 44)];
    self.autocomplete.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.view.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
    self.automaticallyAdjustsScrollViewInsets = NO;
    ;
    self.autocomplete.suggestMode = TKAutoCompleteSuggestModeSuggest;
    self.autocomplete.textField.placeholder = @"Choose airport";
    [self.autocomplete.closeButton setImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    self.autocomplete.imageView.image = [UIImage imageNamed:@"search.png"];
    self.autocomplete.minimumCharactersToSearch = 1;
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - self.view.bounds.origin.y + 45;
    self.autocomplete.dataSource = self;
    
    _url = @"http://www.telerik.com/docs/default-source/ui-for-ios/airports.json?sfvrsn=2";
}

- (void)keyboardDidShow:(NSNotification *) notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    int height = MIN(keyboardSize.height,keyboardSize.width);
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - height - 80;
}

- (void)keyboardDidHide:(NSNotification *) notification
{
    self.autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;
}

-(void)autoComplete:(TKAutoCompleteTextView *)autocomplete completionsForString:(NSString *)input
{
    NSMutableArray *suggestions = [NSMutableArray new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        if(_airports == nil) {
        NSURL *url = [[NSURL alloc] initWithString:_url];
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        NSURLResponse *res = nil;
        NSError *error = nil;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&res error:&error];
            if (error) {
                NSLog(@"%@",error);
            } else {
                NSDictionary* json = [NSJSONSerialization
                                      JSONObjectWithData:data
                                      options:kNilOptions 
                                      error:&error];
                _airports = [json objectForKey:@"airports"];
            }
        }
        
        for (NSDictionary* dict in _airports) {
            NSString *current = [NSString stringWithFormat:@"%@, %@", [dict objectForKey:@"FIELD2"], [dict objectForKey:@"FIELD5"]];
            if ([current.uppercaseString hasPrefix:input.uppercaseString]){
                [suggestions addObject:[[TKAutoCompleteToken alloc] initWithText:current]];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), ^{
            [self.autocomplete completeSuggestionViewPopulation:suggestions];
        });
    });
}

@end
