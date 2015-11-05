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
#import "OptionSection.h"

@implementation ExampleViewController
{
    NSMutableArray *_options;
    NSMutableArray *_sections;
    CGFloat _headerHeight;
    CGFloat _offset;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _options = [[NSMutableArray alloc] init];
        _selectedOptions = [[NSMutableSet alloc] init];
        _headerHeight = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self updateHeaderHeight];
    
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (_options.count > 0 || _sections) {
        if (idiom == UIUserInterfaceIdiomPad) {
            [self loadIPadLayout];
        }
        else {
            [self loadIPhoneLayout];
        }
    }
    
    [self updateLayoutConstraints];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    [super willMoveToParentViewController:parent];
    if (parent == nil) {
        self.navigationController.navigationBar.translucent = YES;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateLayoutConstraints];
}

- (void)updateHeaderHeight
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    if (navigationBar.translucent) {
        UIApplication *app = [UIApplication sharedApplication];
        BOOL isLandscape = UIInterfaceOrientationIsLandscape(app.statusBarOrientation);
        UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
        CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
        if (idiom == UIUserInterfaceIdiomPad && version >= 8.0) {
            _headerHeight = navigationBar.intrinsicContentSize.height + app.statusBarFrame.size.height;
        }
        else {
            _headerHeight = navigationBar.intrinsicContentSize.height + (isLandscape ? app.statusBarFrame.size.width : app.statusBarFrame.size.height);
        }
    }
}

- (void)updateLayoutConstraints
{
    _exampleBounds = self.view.bounds;
    
    [self updateHeaderHeight];
    
    _exampleBounds.origin.y += _headerHeight;
    _exampleBounds.size.height -= _headerHeight;

    if (_offset > 0) {
        _exampleBounds.origin.y += _offset;
        _exampleBounds.size.height -= _offset;
    }
    
    UIUserInterfaceIdiom idiom = [[UIDevice currentDevice] userInterfaceIdiom];
    if (idiom == UIUserInterfaceIdiomPad) {
        _exampleBoundsWithInset = CGRectInset(_exampleBounds, 30, 30);
    }
    else {
        _exampleBoundsWithInset = CGRectInset(_exampleBounds, 10, 10);
    }
}

- (void)loadIPhoneLayout
{
    if (_sections == nil && _options.count == 1) {
        OptionInfo *info = _options[0];
        _settingsButton = [[UIBarButtonItem alloc] initWithTitle:info.optionText
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(optionTouched)];
    }
    else {
        _settingsButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(settingsTouched)];
    }
    self.navigationItem.rightBarButtonItem = _settingsButton;
}

- (void)loadIPadLayout
{
    CGSize desiredSize = CGSizeZero;
    _offset = 0;
    if (_sections == nil && _options.count == 1) {
        OptionInfo *info = _options[0];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(optionTouched) forControlEvents:UIControlEventTouchDown];
        [button setTitle:info.optionText forState:UIControlStateNormal];
        desiredSize = [button sizeThatFits:self.view.bounds.size];
        button.frame = CGRectMake(30, 10 + _headerHeight, desiredSize.width, desiredSize.height);
        [self.view addSubview:button];
        _offset = 10 + desiredSize.height + 10;
    }
    else if (_options.count >= 3 || _sections) {
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
        segmented.frame = CGRectMake(10, 10 + _headerHeight, desiredSize.width, desiredSize.height);
        segmented.selectedSegmentIndex = self.selectedOption;
        [segmented addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmented];
        _offset = 10 + desiredSize.height + 10;
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

- (void) addOption:(OptionInfo *)option
{
    [_options addObject:option];
}

- (void)addOption:(NSString*)text selector:(SEL)selector inSection:(NSString*)sectionName
{
    [self addOption:[[OptionInfo alloc] initWithText:text selector:selector] inSection:sectionName];
}

- (void)addOption:(OptionInfo *)option inSection:(NSString*)sectionName
{
    if (!_sections) {
        _sections = [NSMutableArray new];
    }
    for (OptionSection *section in _sections) {
        if ([section.title isEqualToString:sectionName]) {
            [section.items addObject:option];
            return;
        }
    }
    OptionSection *section = [[OptionSection alloc] initWithTitle:sectionName];
    [section.items addObject:option];
    [_sections addObject:section];
}

- (NSArray *)options
{
    return _options;
}

- (NSArray *)sections
{
    return _sections;
}

- (void)setSelectedOption:(NSInteger)selectedOption inSection:(NSInteger)section
{
    OptionSection *sec = _sections[section];
    sec.selectedOption = selectedOption;
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
    settings.sections = _sections;
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
    [super viewWillDisappear:animated];
    
    if (_popover && [_popover isPopoverVisible]) {
        [_popover dismissPopoverAnimated:NO];
    }
}

@end
