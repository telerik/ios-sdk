//
//  MultipleSideDrawers.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import Foundation

class MultipleSideDrawers:TKExamplesExampleViewController, TKSideDrawerDelegate {
    
    let sideDrawerView = TKSideDrawerView()
    let navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sideDrawerView.frame = self.view.bounds
        self.view.addSubview(sideDrawerView)
        
        let mainView = sideDrawerView.mainView
        
        let backgroundView = UIImageView(frame: mainView.bounds)
        backgroundView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        backgroundView.image = UIImage(named: "sdk-examples-bg")
        mainView.addSubview(backgroundView)
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, mainView.bounds.size.width, 44))
        navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        let leftSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showLeftSideDrawer")
        
        let rightSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "showRightSideDrawer")
        
        navItem.leftBarButtonItem = leftSideDrawerButton
        navItem.rightBarButtonItem = rightSideDrawerButton
        navigationBar.items = [navItem]
        mainView.addSubview(navigationBar)
        
        let sideDrawerRight = sideDrawerView.addSideDrawerAtPosition(TKSideDrawerPosition.Right)
        sideDrawerRight.delegate = self
        sideDrawerRight.style.headerHeight = 44
        sideDrawerRight.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissRightSideDrawer"))
        
        var sectionRight = sideDrawerRight.addSectionWithTitle("Primary")
        sectionRight.addItemWithTitle("Social")
        sectionRight.addItemWithTitle("Promotions")
        
        sectionRight = sideDrawerRight.addSectionWithTitle("Label")
        sectionRight.addItemWithTitle("Important")
        sectionRight.addItemWithTitle("Starred")
        sectionRight.addItemWithTitle("Sent Mail")
        sectionRight.addItemWithTitle("Drafts")
        
        let sideDrawerLeft = sideDrawerView.sideDrawers[0]
        sideDrawerLeft.delegate = self
        sideDrawerLeft.style.headerHeight = 44
        sideDrawerLeft.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissRightSideDrawer"))
        
        var sectionLeft = sideDrawerLeft.addSectionWithTitle("Inbox")
        sectionLeft.addItemWithTitle("Sent Items")
        sectionLeft.addItemWithTitle("Deleted Items")
        sectionLeft.addItemWithTitle("Outbox")
        
        sectionLeft = sideDrawerLeft.addSectionWithTitle("Mobile")
        sectionLeft.addItemWithTitle("iOS")
        sectionLeft.addItemWithTitle("Android")
        sectionLeft.addItemWithTitle("Windows Phone")
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sideDrawerView.frame = self.view.bounds
    }
    
    
    func showLeftSideDrawer() {
        sideDrawerView.sideDrawers[0].show()
    }
    
    func showRightSideDrawer() {
        sideDrawerView.sideDrawers[1].show()
    }
    
    func dismissLeftSideDrawer() {
        sideDrawerView.sideDrawers[0].dismiss()
    }
    
    func dismissRightSideDrawer() {
        sideDrawerView.sideDrawers[1].dismiss()
    }
    
}
