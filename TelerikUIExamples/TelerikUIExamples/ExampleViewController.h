//
//  ExampleViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OptionInfo;

@interface ExampleViewController : UIViewController

@property (nonatomic, assign) NSInteger selectedOption;

@property (nonatomic, strong) NSMutableSet *selectedOptions;

@property (nonatomic) CGRect exampleBounds;

@property (nonatomic, strong) UIPopoverController *popover;

@property (nonatomic, strong) UIBarButtonItem *settingsButton;

- (void)addOption:(NSString*)text selector:(SEL)selector;

- (void)addOption:(OptionInfo *)option;

- (NSArray *)options;

@end
