//
//  DataFormJSONController.m
//  TelerikUIExamples
//
//  Copyright © 2015 Telerik. All rights reserved.
//

#import "DataFormJSONController.h"
#import <TelerikUI/TelerikUI.h>

@interface DataFormJSONController () <TKDataFormDelegate>

@end

@implementation DataFormJSONController
{
    TKDataFormEntityDataSource *_dataSource;
    TKDataForm *_dataForm;
    TKAlert *_alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataForm = [[TKDataForm alloc] initWithFrame:self.view.bounds];
    _dataForm.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _dataForm.allowScroll = NO;
    _dataForm.delegate = self;
    [self.view addSubview:_dataForm];
    
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithDataFromJSONResource:@"user" ofType:@"json" rootItemKeyPath:nil];
    
    _dataSource[@"name"].index = 0;
    _dataSource[@"age"].index = 1;
    
    _dataSource[@"gender"].valuesProvider = @[@"Male", @"Female"];
    _dataSource[@"gender"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"gender"].index = 2;
    
    _dataSource[@"email"].index = 3;
    _dataSource[@"email"].editorClass = [TKDataFormEmailEditor class];
    
    _dataForm.dataSource = _dataSource;
    _dataForm.commitMode = TKDataFormCommitModeManual;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(commitDataForm)];
    self.navigationItem.rightBarButtonItem = save;
}

- (void)commitDataForm
{
    [_dataForm commit];
    _alert = [[TKAlert alloc] initWithTitle:@"Saved" message:[_dataSource writeJSONToString] delegate:nil cancelActionTitle:@"OK" otherActionTitles:nil];
    [_alert show:YES];
}

#pragma mark TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKEntityProperty *)property
{
    if ([property.name isEqualToString:@"age"]) {
        TKGridLayoutCellDefinition *labelDef = [editor.gridLayout definitionForView:((TKDataFormStepperEditor *)editor).valueLabel];
        labelDef.contentOffset = UIOffsetMake(-25, 0);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
