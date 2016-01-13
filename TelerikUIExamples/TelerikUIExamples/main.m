//
//  main.m
//  TelerikUIExamples
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import <TelerikUI/TelerikUI.h>

int main(int argc, char * argv[])
{
    @autoreleasepool {
        
        [TelerikUI loadClasses];
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
