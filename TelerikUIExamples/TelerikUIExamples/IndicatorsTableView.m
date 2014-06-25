//
//  IndicatorsTableViewViewController.m
//  TelerikUIExamples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "IndicatorsTableView.h"
#import "IndicatorsViewController.h"
#import "OptionInfo.h"

NSString *const kCellIdentifier = @"indicatorCell";
@implementation IndicatorsTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _table.dataSource = self;
    _table.delegate = self;
    _table.allowsMultipleSelection = YES;
    _table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_table];
    
    NSIndexPath *trendlinePath = [NSIndexPath indexPathForRow:_example.selectedTrendline inSection:0];
    NSIndexPath *indicatorPath = [NSIndexPath indexPathForRow:_example.selectedIndicator inSection:1];
    [_table selectRowAtIndexPath:trendlinePath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [_table selectRowAtIndexPath:indicatorPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _example.trendlines.count;
    } else {
        return _example.indicators.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Trendlines";
    } else {
        return @"Indicators";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    OptionInfo *info;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (section == 0) {
        info = _example.trendlines[indexPath.row];
        if (indexPath.row == _example.selectedTrendline) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else {
        info = _example.indicators[indexPath.row];
        if (indexPath.row == _example.selectedIndicator) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    cell.textLabel.text = info.optionText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger selectedRow = indexPath.row;
    OptionInfo *info;
    if (section == 0) {
        NSIndexPath *currentPath = [NSIndexPath indexPathForRow:_example.selectedTrendline inSection:section];
        [tableView deselectRowAtIndexPath:currentPath animated:NO];
        _example.selectedTrendline = selectedRow;
        info = _example.trendlines[selectedRow];
    } else {
        NSIndexPath *currentPath = [NSIndexPath indexPathForRow:_example.selectedIndicator inSection:section];
        [tableView deselectRowAtIndexPath:currentPath animated:NO];
        _example.selectedIndicator = selectedRow;
        info = _example.indicators[selectedRow];
    }
    
    IMP indicatorImp = [_example methodForSelector:info.selector];
    void (*indicatorFunc)(id, SEL, OptionInfo *) = (void *)indicatorImp;
    indicatorFunc(_example, info.selector, info);
    
    [tableView reloadData];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
