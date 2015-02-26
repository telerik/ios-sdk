//
//  SideDrawerGettingStartedModalController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.

class SideDrawerGettingStartedModalController: UIViewController, TKSideDrawerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backgroundView = UIImageView(frame: self.view.bounds)
        backgroundView.image = UIImage(named: "sdk-examples-bg")
        self.view.addSubview(backgroundView)
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        let navigationItem = UINavigationItem(title: "Getting Started")
        let doneButton = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Done, target: self, action: "dismiss")
        let showSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = showSideDrawerButton
        navigationBar.items = [navigationItem]
        self.view.addSubview(navigationBar)
        
        let sideDrawer = self.sideDrawer
        sideDrawer.delegate = self
        sideDrawer.style.headerHeight = 64
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissSideDrawer"))

        var section = sideDrawer.addSectionWithTitle("Primary")
        section.addItemWithTitle("Social")
        section.addItemWithTitle("Promotions")
        
        section = sideDrawer.addSectionWithTitle("Label")
        section.addItemWithTitle("Important")
        section.addItemWithTitle("Starred")
        section.addItemWithTitle("Sent Mail")
        section.addItemWithTitle("Drafts")
    }
    
    func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showSideDrawer() {
        self.sideDrawer.show()
    }
    
    func dismissSideDrawer() {
        self.sideDrawer.dismiss()
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForSection sectionIndex: Int) {
        let section = sideDrawer.sections()[sectionIndex] as TKSideDrawerSection
        section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0)
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForItem item: Int, inSection section: Int) {
        let currentItem = (sideDrawer.sections()[section] as TKSideDrawerSection).items()[item] as TKSideDrawerItem
        currentItem.style.contentInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        currentItem.style.separatorColor = TKSolidFill(color: UIColor.clearColor())
    }
}
