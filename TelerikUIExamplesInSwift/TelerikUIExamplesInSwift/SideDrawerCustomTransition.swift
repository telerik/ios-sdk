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
        sideDrawer.transitionManager = MyTransition(sideDrawer: sideDrawer)
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
    }
}
