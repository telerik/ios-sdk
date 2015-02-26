//
//  SideDrawerCustomTransitionModalController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerCustomTransitionModalController: SideDrawerGettingStartedModalController, TKSideDrawerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        let sideDrawer = self.sideDrawer
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.transitionManager = ScaleContentTransition(sideDrawer: sideDrawer)
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
    }
    
}
