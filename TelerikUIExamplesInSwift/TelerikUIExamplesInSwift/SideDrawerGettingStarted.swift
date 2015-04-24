//
//  SideDrawerGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerGettingStarted: ExampleViewController, TKSideDrawerDelegate {

    let sideDrawerView = TKSideDrawerView()
    let navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.interactivePopGestureRecognizer.enabled = false

        self.sideDrawerView.frame = self.exampleBounds
        self.view.addSubview(sideDrawerView)
        
        let mainView = sideDrawerView.mainView
        
        let backgroundView = UIImageView(frame: mainView.bounds)
        backgroundView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        backgroundView.image = UIImage(named: "sdk-examples-bg")
        mainView.addSubview(backgroundView)
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, mainView.bounds.size.width, 44))
        navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        let showSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
        navItem.leftBarButtonItem = showSideDrawerButton
        navigationBar.items = [navItem]
        mainView.addSubview(navigationBar)
        
        let sideDrawer = sideDrawerView.sideDrawer
        sideDrawer.delegate = self
        sideDrawer.style.headerHeight = 44
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sideDrawerView.frame = self.exampleBounds
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.navigationController!.respondsToSelector("interactivePopGestureRecognizer")) {
            self.navigationController!.interactivePopGestureRecognizer.enabled = true
        }
    }
    
    
    func showSideDrawer() {
        sideDrawerView.sideDrawer.show()
    }
    
    func dismissSideDrawer() {
        sideDrawerView.sideDrawer.dismiss()
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForSection sectionIndex: Int) {
        let section = sideDrawer.sections()[sectionIndex] as! TKSideDrawerSection
        section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0)
    }
    
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForItem item: Int, inSection section: Int) {
        let currentItem = (sideDrawer.sections()[section] as! TKSideDrawerSection).items()[item] as! TKSideDrawerItem
        currentItem.style.contentInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        currentItem.style.separatorColor = TKSolidFill(color: UIColor.clearColor())
    }
}
