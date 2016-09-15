//
//  SideDrawerCustomTransition.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//


class SideDrawerCustomTransition: SideDrawerGettingStarted {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        
        // >> drawer-transition-manager-swift
        sideDrawer.transitionManager = MyTransition(sideDrawer: sideDrawer)
        // << drawer-transition-manager-swift
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
    }
}
