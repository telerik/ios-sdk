//
//  ViewController.swift
//  SideDrawerWithPhysics
//
//

import UIKit

class ViewController: UIViewController {

    let sideDrawerView = TKSideDrawerView()
    let navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideDrawerView.frame = self.view.bounds
        self.view.addSubview(sideDrawerView)
        self.view.backgroundColor = UIColor.yellowColor()
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(sideDrawerView.mainView.bounds), height: 44))
        navItem.leftBarButtonItem = UIBarButtonItem(title: "CLICK", style: UIBarButtonItemStyle.Plain, target: self, action: "showSideDrawer")
        navBar.items = [navItem];
        navBar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        sideDrawerView.mainView.addSubview(navBar)
        
        let sideDrawer = sideDrawerView.sideDrawer
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.width = 200;
        sideDrawer.transitionManager = PhysicsTransitionManager(sideDrawer: sideDrawer)
        sideDrawer.content.backgroundColor = UIColor.clearColor()
        
        var section = sideDrawer.addSectionWithTitle("Primary")
        section.addItemWithTitle("Social")
        section.addItemWithTitle("Promotions")
        
        section = sideDrawer.addSectionWithTitle("Label")
        section.addItemWithTitle("Important")
        section.addItemWithTitle("Starred")
        section.addItemWithTitle("Sent Mail")
        section.addItemWithTitle("Drafts")
    }

    func showSideDrawer()
    {
        sideDrawerView.sideDrawer.show()
    }


}

