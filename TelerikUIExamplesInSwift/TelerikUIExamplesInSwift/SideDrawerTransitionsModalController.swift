//
//  SideDrawerTransitionsModalController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerTransitionsModalController: SideDrawerGettingStartedModalController, TKSideDrawerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createButton("Push", target: self, selector: "pushTransition", origin: CGPointMake(15, 80))
        self.createButton("Reveal", target: self, selector: "revealTransition", origin: CGPointMake(15, 130))
        self.createButton("Reverse Slide Out", target: self, selector: "reverseSlideOutTransition", origin: CGPointMake(15, 180))
        self.createButton("Slide Along", target: self, selector: "slideAlongTransition", origin: CGPointMake(15, 230))
        self.createButton("Slide In On Top", target: self, selector: "slideInOnTopTransition", origin: CGPointMake(15, 280))
        self.createButton("Scale Up", target: self, selector: "scaleUpTransition", origin: CGPointMake(15, 330))
        self.createButton("Fade In", target: self, selector: "fadeInTransition", origin: CGPointMake(15, 380))
    }
    
    func createButton(title: String, target: AnyObject, selector: Selector, origin: CGPoint) {
        let titleString: NSString = title as NSString
        let titleSize = titleString.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(18.0)])
        let button = UIButton(frame: CGRectMake(origin.x, origin.y, titleSize.width, 44))
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.cornerRadius = 3.0
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func pushTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.Push
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func revealTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.Reveal
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func reverseSlideOutTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.ReverseSlideOut
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func slideAlongTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.SlideAlong
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func slideInOnTopTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.SlideInOnTop
        sideDrawer.fill = TKSolidFill(color: UIColor.clearColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissSideDrawer"))
        self.showSideDrawer()
    }
    
    func scaleUpTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.ScaleUp
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func fadeInTransition() {
        let sideDrawer = self.sideDrawer
        sideDrawer.transition = TKSideDrawerTransitionType.FadeIn
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: Selector("dismissSideDrawer"))
        self.showSideDrawer()
    }
}
