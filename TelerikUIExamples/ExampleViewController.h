//
//  ExampleViewController.h
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleViewController : UIViewController

- (void)addOption:(NSString*)text selector:(SEL)selector;
- (CGRect)exampleBounds;

@property (nonatomic, assign) NSInteger selectedOption;

@end
