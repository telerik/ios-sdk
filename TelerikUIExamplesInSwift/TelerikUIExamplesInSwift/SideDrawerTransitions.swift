//
//  SideDrawerTransitions.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerTransitions: SideDrawerGettingStarted {
    
    var scrollView:UIScrollView = UIScrollView()
    var buttonY:CGFloat = 0
    var v = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: CGRectZero)
        scrollView.scrollEnabled = true
        
        self.addButtonWithTitle("Push", target: self, selector: #selector(SideDrawerTransitions.pushTransition))
        self.addButtonWithTitle("Reveal", target: self, selector: #selector(SideDrawerTransitions.revealTransition))
        self.addButtonWithTitle("Reverse Slide Out", target: self, selector: #selector(SideDrawerTransitions.reverseSlideOutTransition))
        self.addButtonWithTitle("Slide Along", target: self, selector: #selector(SideDrawerTransitions.slideAlongTransition))
        self.addButtonWithTitle("Slide In On Top", target: self, selector: #selector(SideDrawerTransitions.slideInOnTopTransition))
        self.addButtonWithTitle("Scale Up", target: self, selector: #selector(SideDrawerTransitions.scaleUpTransition))
        self.addButtonWithTitle("Fade In", target: self, selector: #selector(SideDrawerTransitions.fadeInTransition))
        self.addButtonWithTitle("Scale Down Pusher", target: self, selector: #selector(SideDrawerTransitions.scaleDownPusherTransition))
        
        self.sideDrawerView.mainView.addSubview(scrollView)
        self.sideDrawerView.backgroundColor = UIColor.grayColor()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRectMake(0, 44, CGRectGetWidth(self.sideDrawerView.bounds), CGRectGetHeight(self.sideDrawerView.bounds) - 44)
    }
    
    func addButtonWithTitle(title: String, target: AnyObject, selector: Selector) {
        let titleString: NSString = title as NSString
        let titleSize = titleString.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(18.0)])
        let button = UIButton(frame: CGRectMake(15, 15 + self.buttonY, titleSize.width, 44))
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.cornerRadius = 3.0
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        scrollView.addSubview(button)
        self.buttonY += 50
        self.scrollView.contentSize = CGSizeMake(fmax(CGRectGetWidth(button.frame), self.scrollView.contentSize.width), self.buttonY + 15)
    }
    
    func pushTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.Push
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func revealTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.Reveal
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func reverseSlideOutTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.ReverseSlideOut
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func slideAlongTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.SlideAlong
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func slideInOnTopTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.SlideInOnTop
        sideDrawer.fill = TKSolidFill(color: UIColor.clearColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: #selector(SideDrawerTransitions.dismissSideDrawer))
        self.showSideDrawer()
    }
    
    func scaleUpTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.ScaleUp
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: nil, selector: nil)
        self.showSideDrawer()
    }
    
    func fadeInTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.FadeIn
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: true, target: self, selector: #selector(SideDrawerTransitions.dismissSideDrawer))
        self.showSideDrawer()
    }
    
    func scaleDownPusherTransition() {
        let sideDrawer = self.sideDrawerView.sideDrawers[0]
        sideDrawer.transition = TKSideDrawerTransitionType.ScaleDownPusher
        sideDrawer.fill = TKSolidFill(color: UIColor.grayColor())
        sideDrawer.headerView = SideDrawerHeaderView(addButton: false, target: self, selector: #selector(SideDrawerTransitions.dismissSideDrawer))
        self.showSideDrawer()
    }
}
