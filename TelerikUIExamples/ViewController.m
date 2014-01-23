//
//  ViewController.m
//  Examples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "ViewController.h"
#import "ExampleInfo.h"

@implementation ViewController
{
    ExampleInfo *_example;
    UITableView *_table;
    NSInteger _selectedRow;
}

- (id)initWithExample:(ExampleInfo *)example
{
    self = [self init];
    if (self) {
        _example = example;
        _selectedRow = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _example.title;
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds];
    _table.delegate = self;
    _table.dataSource = self;
    _table.autoresizingMask = ~UIViewAutoresizingNone;
    [self.view addSubview:_table];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _example.examples.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"examplescell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ExampleInfo *info = _example.examples[indexPath.row];
    cell.textLabel.text = info.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExampleInfo *example = (ExampleInfo*)_example.examples[indexPath.row];
    UIViewController *controller = [example createController];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
