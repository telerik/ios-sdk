//
//  SideDrawerPositionsModalController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerPositionsModalController: SideDrawerGettingStartedModalController, TKSideDrawerDelegate {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createButton("Left", target: self, selector: "leftSideDrawer", origin: CGPointMake(15, 80))
        self.createButton("Right", target: self, selector: "rightSideDrawer", origin: CGPointMake(15, 130))
        self.createButton("Top", target: self, selector: "topSideDrawer", origin: CGPointMake(15, 180))
        self.createButton("Bottom", target: self, selector: "bottomSideDrawer", origin: CGPointMake(15, 230))
        
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.Reveal
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        
    }
    
    func createButton(title: String, target: AnyObject, selector: Selector, origin: CGPoint) {
        let titleString: NSString = title as NSString
        let titleSize = titleString.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(18.0)])
        let button = UIButton(frame: CGRectMake(origin.x, origin.y, titleSize.width * 1.5, 44))
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.cornerRadius = 3.0
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(button)
    }
    
    func leftSideDrawer() {
        let sideDrawer = self.sideDrawer
        sideDrawer.position = TKSideDrawerPosition.Left
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func rightSideDrawer() {
        let sideDrawer = self.sideDrawer
        sideDrawer.position = TKSideDrawerPosition.Right
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissSideDrawer"))
        self.showSideDrawer()
    }
    
    func topSideDrawer() {
        let sideDrawer = self.sideDrawer
        sideDrawer.position = TKSideDrawerPosition.Top
        (sideDrawer.content as TKSideDrawerTableView).tableView .setContentOffset(CGPointZero, animated: false)
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        sideDrawer.allowScroll = true
        self.showSideDrawer()
    }
    
    func bottomSideDrawer() {
        let sideDrawer = self.sideDrawer
        sideDrawer.position = TKSideDrawerPosition.Bottom
        (sideDrawer.content as TKSideDrawerTableView).tableView .setContentOffset(CGPointZero, animated: false)
        sideDrawer.allowScroll = true
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissSideDrawer"))
        self.showSideDrawer()
    }
}
