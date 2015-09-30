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
#import "OptionSection.h"

@implementation SettingsViewController

- (instancetype)initWithOptions:(NSArray*)options
{
    self = [self init];
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

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.sections) {
        return self.sections.count;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sections) {
        OptionSection *sectionInfo = self.sections[section];
        return sectionInfo.items.count;
    }
    return _options.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingscell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    
    OptionInfo *info = nil;
    if (self.sections) {
        OptionSection *sectionInfo = self.sections[indexPath.section];
        info = sectionInfo.items[indexPath.row];
        if (indexPath.row == sectionInfo.selectedOption) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    else {
        info = _options[indexPath.row];
        if (indexPath.row == self.example.selectedOption) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    cell.textLabel.text = info.optionText;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _sections ? 44 : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    OptionSection *sectionInfo = _sections[section];
    return sectionInfo.title;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OptionInfo *info = nil;
    if (self.sections) {
        OptionSection *sectionInfo = self.sections[indexPath.section];
        info = sectionInfo.items[indexPath.row];
        sectionInfo.selectedOption = indexPath.row;
    }
    else {
        info = _options[indexPath.row];
        self.example.selectedOption = indexPath.row;
    }

    objc_msgSend(self.example, info.selector);
    
    if (self.example.popover && [self.example.popover isPopoverVisible]) {
        [self.example.popover dismissPopoverAnimated:NO];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
