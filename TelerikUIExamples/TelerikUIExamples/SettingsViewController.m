//
//  SettingsViewController.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <objc/message.h>
#import "SettingsViewController.h"
#import "ExampleViewController.h"
#import "OptionInfo.h"

@implementation SettingsViewController

- (id)initWithOptions:(NSArray*)options
{
    self = [super init];
    if (self) {
        _options = options;
        _selectedOption = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Settings";
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.dataSource = self;
    _table.delegate = self;
    [self.view addSubview:_table];
    [self initialSelection];
}

- (void)initialSelection
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedOption inSection:0];
    [_table selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _table.frame = self.view.bounds;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _options.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingscell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    OptionInfo *info = _options[indexPath.row];
    cell.textLabel.text = info.optionText;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == self.example.selectedOption) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.example.selectedOption = indexPath.row;
    OptionInfo *info = _options[indexPath.row];
    objc_msgSend(self.example, info.selector);
    
    if (self.example.popover && [self.example.popover isPopoverVisible]) {
        [self.example.popover dismissPopoverAnimated:NO];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
