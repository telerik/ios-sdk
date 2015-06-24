//
//  AlertViewSettings.m
//  TelerikUIExamples
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

#import <TelerikUI/TelerikUI.h>
#import "UIButton_Circle.h"
#import "AlertViewSettings.h"
#import "AlertSettings.h"

@interface AlertViewSettings () <TKDataFormDelegate>
@end

@implementation AlertViewSettings
{
    TKDataForm* _dataForm;
    AlertSettings* _settings;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Show Alert" selector:@selector(show:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _settings = [AlertSettings new];
    
    _dataForm = [TKDataForm new];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        _dataForm.frame = self.exampleBounds;
        self.view.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    }
    else {
        _dataForm.frame = self.view.bounds;
    }
    _dataForm.delegate = self;
    _dataForm.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_dataForm];
    
    TKDataFormEntityDataSource* dataSource = ((TKDataFormEntityDataSource*)_dataForm.dataSource);
    dataSource.selectedObject = _settings;

    [_dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[dataSource.entityModel propertyWithName:@"actionsLayout"]];
    [_dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[dataSource.entityModel propertyWithName:@"backgroundStyle"]];
    [_dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[dataSource.entityModel propertyWithName:@"dismissMode"]];
    [_dataForm registerEditor:[TKDataFormSegmentedEditor class] forProperty:[dataSource.entityModel propertyWithName:@"dismissDirection"]];
    _dataForm.commitMode = TKDataFormCommitModeDelayed;
}

- (void)show:(id)sender
{
    [_dataForm commit];
    TKAlert *alert = [TKAlert new];

    alert.title = _settings.title;
    alert.message = _settings.message;
    alert.allowParallaxEffect = _settings.allowParallaxEffect;
    alert.style.backgroundStyle = _settings.backgroundStyle;
    alert.actionsLayout = _settings.actionsLayout;
    alert.dismissMode = _settings.dismissMode;
    alert.swipeDismissDirection = _settings.dismissDirection;
    alert.animationDuration = _settings.animationDuration;
    alert.style.backgroundDimAlpha = _settings.backgroundDim;
    
    [alert addActionWithTitle:@"Shake" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        [alert shake];
        return NO;
    }];

    [alert addActionWithTitle:@"Touch" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        return NO;
    }];
    
    [alert addActionWithTitle:@"Close" handler:^BOOL(TKAlert *alert, TKAlertAction *action) {
        NSLog(@"closed");
        return YES;
    }];
    
    [alert show:YES];
}

#pragma mark - TKDataFormDelegate

- (void)dataForm:(TKDataForm *)dataForm updateEditor:(TKDataFormEditor *)editor forProperty:(TKDataFormEntityProperty *)property
{
    if ([property.name isEqualToString:@"actionsLayout"]) {
       TKDataFormSegmentedEditor* segmentedEditor = (TKDataFormSegmentedEditor*)editor;
       segmentedEditor.segments = @[@"Horizontal", @"Vertical"];
    }
    
    if ([property.name isEqualToString:@"backgroundStyle"]) {
        TKDataFormSegmentedEditor* segmentedEditor = (TKDataFormSegmentedEditor*)editor;
        segmentedEditor.segments = @[@"Blur", @"Dim"];
    }
    
    if ([property.name isEqualToString:@"dismissMode"]) {
        TKDataFormSegmentedEditor* segmentedEditor = (TKDataFormSegmentedEditor*)editor;
        segmentedEditor.segments = @[@"None", @"Tap", @"Swipe"];
    }
    
    if ([property.name isEqualToString:@"dismissDirection"]) {
        TKDataFormSegmentedEditor* segmentedEditor = (TKDataFormSegmentedEditor*)editor;
        segmentedEditor.segments = @[@"Horizontal", @"Vertical"];
    }
}

@end
