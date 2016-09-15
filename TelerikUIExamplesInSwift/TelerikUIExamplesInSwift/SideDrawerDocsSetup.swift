//
//  SideDrawerDocsSetup.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

/*This file has purpose only for the documentation snippets, it is not an actual example!
 It is commented because the build of the project won't pass.*/

class SideDrawerDocsSetup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*This piece of code is supposed to be placed in the didFinishLaunchingWithOptions method in AppDelegate inorder to have a global sideDrawer for every screen in your application */
        
        /*
         
         // >> sidedrawer-appdelegate-swift
         class AppDelegate: UIResponder, UIApplicationDelegate {
         
            var window: UIWindow?
         
            func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
            // Override point for customization after application launch.
         
                let sideDrawerGettingStarted = SideDrawerGettingStartedViewController()
                let sideDrawerController = TKSideDrawerController(content: sideDrawerGettingStarted)
                self.window?.rootViewController = sideDrawerController
         
                return true
            }
         
         //..
         }
         // << sidedrawer-appdelegate-swift
         
         
         // >> sidedrawer-appdelegate-ctrl-swift
         class SideDrawerGettingStartedViewController: UIViewController {
         
            override func viewDidLoad() {
                super.viewDidLoad()
         
                self.view.backgroundColor = UIColor.grayColor()
         
                let navBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
                let navItem = UINavigationItem(title: "Getting Started")
                let showSideDrawerButton = UIBarButtonItem(title: "Show", style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
                navItem.leftBarButtonItem = showSideDrawerButton
                navBar.items = [navItem]
                self.view.addSubview(navBar)
         
                let sectionPrimary = self.sideDrawer.addSectionWithTitle("Primary")
                sectionPrimary.addItemWithTitle("Social")
                sectionPrimary.addItemWithTitle("Promotions")
         
                let sectionLabels = self.sideDrawer.addSectionWithTitle("Primary")
                sectionLabels.addItemWithTitle("Social")
                sectionLabels.addItemWithTitle("Promotions")
                sectionLabels.addItemWithTitle("Sent Mail")
                sectionLabels.addItemWithTitle("Drafts")
            }
         
            func showSideDrawer() {
                self.sideDrawer.show()
            }

         }
         // << sidedrawer-appdelegate-ctrl-swift
        */
    }
}
