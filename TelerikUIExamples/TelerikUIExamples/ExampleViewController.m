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
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _options = [[NSMutableArray alloc] init];
        _selectedOptions = [[NSMutableSet alloc] init];
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
            [self loadIPadLayout];
        }
        else {
            [self loadIPhoneLayout];
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

- (void)loadIPhoneLayout
{
    if (_options.count == 1) {
        OptionInfo *info = _options[0];
        _settingsButton = [[UIBarButtonItem alloc] initWithTitle:info.optionText style:UIBarButtonItemStylePlain target:self action:@selector(optionTouched)];
    }
    else {
        //button = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
        _settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
    }
    self.navigationItem.rightBarButtonItem = _settingsButton;
    _exampleBounds = CGRectInset(self.view.bounds, 10, 10);
}

- (void)loadIPadLayout
{
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
    else if (_options.count >= 3) {
        _settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsTouched)];
        self.navigationItem.rightBarButtonItem = _settingsButton;
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

- (CGRect)exampleBounds
{
    return _exampleBounds;
}

- (void)addOption:(NSString*)text selector:(SEL)selector
{
    [_options addObject:[[OptionInfo alloc] initWithText:text selector:selector]];
}

- (void) addOption:(OptionInfo *)option
{
    [_options addObject:option];
}

- (NSArray *)options
{
    return _options;
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
    
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (idiom == UIUserInterfaceIdiomPad) {
        if (_popover && [_popover isPopoverVisible]) {
            [_popover dismissPopoverAnimated:YES];

            return;
        }
        
        _popover = [[UIPopoverController alloc] initWithContentViewController:settings];
        CGRect settingsRect = settings.view.bounds;
        [settings.table sizeToFit];
        CGSize size = CGSizeMake(MIN(settingsRect.size.width, settingsRect.size.height) / 2., settings.table.contentSize.height);
        _popover.popoverContentSize = size;
        [_popover presentPopoverFromBarButtonItem:_settingsButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
    else {
        [self.navigationController pushViewController:settings animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (_popover && [_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:NO];
    }
}

@end
