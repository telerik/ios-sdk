//
//  SideDrawerGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

// >> drawer-attached-swift
class SideDrawerGettingStarted: TKExamplesExampleViewController, TKSideDrawerDelegate {

    let sideDrawerView = TKSideDrawerView()
    let navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sideDrawerView.frame = self.view.bounds
        self.view.addSubview(sideDrawerView)
        
        let mainView = sideDrawerView.mainView
        
        let backgroundView = UIImageView(frame: mainView.bounds)
        backgroundView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        backgroundView.image = UIImage(named: "sdk-examples-bg")
        mainView.addSubview(backgroundView)
        
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, mainView.bounds.size.width, 44))
        navigationBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        let showSideDrawerButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SideDrawerGettingStarted.showSideDrawer))
        navItem.leftBarButtonItem = showSideDrawerButton
        navigationBar.items = [navItem]
        mainView.addSubview(navigationBar)
        
        let sideDrawer = sideDrawerView.sideDrawers[0]
        sideDrawer.delegate = self
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: #selector(SideDrawerGettingStarted.dismissSideDrawer))
        
        // >> drawer-style-swift
        sideDrawer.style.headerHeight = 44
        sideDrawer.style.shadowMode = TKSideDrawerShadowMode.Hostview
        sideDrawer.style.shadowOffset = CGSizeMake(-2, -0.5)
        sideDrawer.style.shadowRadius = 5
        // << drawer-style-swift
        
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
        self.sideDrawerView.frame = self.view.bounds
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let navController = self.navigationController {
            if navController.respondsToSelector(Selector("interactivePopGestureRecognizer")) {
                self.navigationController!.interactivePopGestureRecognizer!.enabled = true
            }
        }
    }
    
    
    func showSideDrawer() {
        sideDrawerView.sideDrawers[0].show()
    }
    
    func dismissSideDrawer() {
        sideDrawerView.sideDrawers[0].dismiss()
    }
    // << drawer-attached-swift
    
    // >> drawer-update-section-swift
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForSection sectionIndex: Int) {
        let section = sideDrawer.sections[sectionIndex] as! TKSideDrawerSection
        section.style.contentInsets = UIEdgeInsetsMake(0, -15, 0, 0)
    }
    // << drawer-update-section-swift
    
    // >> drawer-update-swift
    func sideDrawer(sideDrawer: TKSideDrawer!, updateVisualsForItemAtIndexPath indexPath: NSIndexPath!) {
        let currentItem = (sideDrawer.sections[indexPath.section] as! TKSideDrawerSection).items[indexPath.item] as! TKSideDrawerItem
        currentItem.style.contentInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        currentItem.style.separatorColor = TKSolidFill(color: UIColor.clearColor())
    }
    // << drawer-update-swift
    
    // >> drawer-did-select-swift
    func sideDrawer(sideDrawer: TKSideDrawer!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        NSLog("Selected item in section: %ld at index: %ld ", indexPath.section, indexPath.row)
    }
    // << drawer-did-select-swift
}
