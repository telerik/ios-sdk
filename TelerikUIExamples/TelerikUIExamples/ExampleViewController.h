//
//  ExampleViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OptionInfo;

@interface ExampleViewController : UIViewController

@property (nonatomic, assign) BOOL useSections;

@property (nonatomic, assign) NSInteger selectedOption;

@property (nonatomic, strong) NSMutableSet *selectedOptions;

@property (nonatomic) CGRect exampleBounds;

@property (nonatomic) CGRect exampleBoundsWithInset;

@property (nonatomic, strong) UIPopoverController *popover;

@property (nonatomic, strong) UIBarButtonItem *settingsButton;

- (void)addOption:(NSString*)text selector:(SEL)selector;

- (void)addOption:(OptionInfo *)option;

- (void)addOption:(OptionInfo *)option inSection:(NSString*)sectionName;

- (void)addOption:(NSString*)text selector:(SEL)selector inSection:(NSString*)sectionName;

- (void)setSelectedOption:(NSInteger)selectedOption inSection:(NSInteger)section;

- (NSArray *)options;

- (NSArray *)sections;

@end
