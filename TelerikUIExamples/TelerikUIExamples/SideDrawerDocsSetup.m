//
//  SideDrawerDocsSetup.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "SideDrawerDocsSetup.h"

/*This file has purpose only for the documentation snippets, it is not an actual example!
 It is commented because the build of the project won't pass.*/
@implementation SideDrawerDocsSetup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*This piece of code is supposed to be placed in the didFinishLaunchingWithOptions method
     in AppDelegate inorder to have a global sideDrawer for every screen in your application
    */
    
    /*
     // >> sidedrawer-appdelegate
    @implementation AppDelegate
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        // Override point for customization after application launch.
        
        //For the SideDrawer GettingStarted
        SideDrawerGettingStarted *main = [[SideDrawerGettingStarted alloc] init];
        TKSideDrawerController *sideDrawerController = [[TKSideDrawerController alloc] initWithContent:main];
        [self.window setRootViewController:sideDrawerController];
        
        return YES;
    }
    
    //..
    @end
     // << sidedrawer-appdelegate
     
     
     
     // >> sidedrawer-appdelegate-ctrl
     @implementation SideDrawerGettingStarted
     {
     }
     
     - (void)viewDidLoad {
     [super viewDidLoad];
     
        self.view.backgroundColor = [UIColor grayColor];
     
        UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Getting Started"];
        UIBarButtonItem *showSideDrawerButton = [[UIBarButtonItem alloc] initWithTitle:@"Show"  style:UIBarButtonItemStylePlain target:self action:@selector(showSideDrawer)];
        navItem.leftBarButtonItem = showSideDrawerButton;
        navBar.items = @[navItem];
        [self.view addSubview:navBar];
     
        TKSideDrawerSection *sectionPrimary = [self.sideDrawer addSectionWithTitle:@"Primary"];
        [sectionPrimary addItemWithTitle:@"Social"];
        [sectionPrimary addItemWithTitle:@"Promotions"];
     
        TKSideDrawerSection *sectionLabels = [self.sideDrawer addSectionWithTitle:@"Labels"];
        [sectionLabels addItemWithTitle:@"Important"];
        [sectionLabels addItemWithTitle:@"Starred"];
        [sectionLabels addItemWithTitle:@"Sent Mail"];
        [sectionLabels addItemWithTitle:@"Drafts"];
     }
     
     - (void)showSideDrawer
     {
        [self.sideDrawer show];
     }
     
     @end
     // << sidedrawer-appdelegate-ctrl
     */
}
@end
