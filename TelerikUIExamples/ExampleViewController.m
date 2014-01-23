//
//  ExampleViewController.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <objc/message.h>
#import "ExampleViewController.h"
#import "OptionInfo.h"
#import "SettingsViewController.h"

@implementation ExampleViewController
{
    NSMutableArray *_options;
    CGRect _exampleBounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _options = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    if (_options.count > 0) {
        if (idiom == UIUserInterfaceIdiomPad) {
            CGSize desiredSize = CGSizeZero;
            if (_options.count == 1) {
                OptionInfo *info = _options[0];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [button addTarget:self action:@selector(optionTouched) forControlEvents:UIControlEventTouchDown];
                [button setTitle:info.optionText forState:UIControlStateNormal];
                desiredSize = [button sizeThatFits:self.view.bounds.size];
                button.frame = CGRectMake(30, 10, desiredSize.width, desiredSize.height);
                [self.view addSubview:button];
            }
            else {
                UISegmentedControl *segmented = [[UISegmentedControl alloc] init];
                int i = 0;
                for (OptionInfo *option in _options) {
                    [segmented insertSegmentWithTitle:option.optionText atIndex:i++ animated:NO];
                }
                desiredSize = [segmented sizeThatFits:self.view.bounds.size];
                segmented.frame = CGRectMake(10, 10, desiredSize.width, desiredSize.height);
                [segmented addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventValueChanged];
                [self.view addSubview:segmented];
                
                [segmented setSelectedSegmentIndex:self.selectedOption];
            }
            _exampleBounds = CGRectMake(20, 30 + desiredSize.height, self.view.bounds.size.width - 40, self.view.bounds.size.height - desiredSize.height - 60);
        }
        else {
            UIBarButtonItem *button = nil;
            if (_options.count == 1) {
                OptionInfo *info = _options[0];
                button = [[UIBarButtonItem alloc] initWithTitle:info.optionText style:UIBarButtonItemStylePlain target:self action:@selector(optionTouched)];
            }
            else {
                //button = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
                button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
            }
            self.navigationItem.rightBarButtonItem = button;
            _exampleBounds = CGRectInset(self.view.bounds, 10, 10);
        }
    }
    else {
        if (idiom == UIUserInterfaceIdiomPad) {
            _exampleBounds = CGRectInset(self.view.bounds, 30, 30);
        }
        else {
            _exampleBounds = CGRectInset(self.view.bounds, 10, 10);
        }
    }
}

- (CGRect)exampleBounds
{
    return _exampleBounds;
}

- (void)addOption:(NSString*)text selector:(SEL)selector
{
    [_options addObject:[[OptionInfo alloc] initWithText:text selector:selector]];
}

- (void)optionSelected:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex >= 0) {
        self.selectedOption = sender.selectedSegmentIndex;
        OptionInfo *info = _options[sender.selectedSegmentIndex];
        objc_msgSend(self, info.selector);
    }
}

- (void)optionTouched
{
    OptionInfo *info = _options[0];
    objc_msgSend(self, info.selector);
}

- (void)settingsTouched
{
    SettingsViewController *settings = [[SettingsViewController alloc] initWithOptions:_options];
    settings.example = self;
    settings.selectedOption = self.selectedOption;
    [self.navigationController pushViewController:settings animated:YES];
}

@end
