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
    TKDataFormEntityDataSource *_dataSource;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addOption:@"Show Alert" selector:@selector(show)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _settings = [AlertSettings new];
    
    _dataForm = [TKDataForm new];
    _dataSource = [[TKDataFormEntityDataSource alloc] initWithObject:_settings];
    _dataForm.dataSource = _dataSource;
    
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
    
    _dataSource[@"actionsLayout"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"actionsLayout"].valuesProvider = @[@"Horizontal", @"Vertical"];
    
    _dataSource[@"backgroundStyle"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"backgroundStyle"].valuesProvider = @[@"Blur", @"Dim"];
    
    _dataSource[@"dismissMode"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"dismissMode"].valuesProvider = @[@"None", @"Tap", @"Swipe"];
    
    _dataSource[@"dismissDirection"].editorClass = [TKDataFormSegmentedEditor class];
    _dataSource[@"dismissDirection"].valuesProvider = @[@"Horizontal", @"Vertical"];
    
    _dataForm.commitMode = TKDataFormCommitModeManual;
    
    [_dataForm reloadData];
}

- (void)show
{
    [_dataForm commit];
    TKAlert *alert = [TKAlert new];

    alert.title = _settings.title;
    alert.message = _settings.message;
    alert.allowParallaxEffect = _settings.allowParallax;
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

@end
