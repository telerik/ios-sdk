//
//  SideDrawerCustomContentModalController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerCustomContentModalController: SideDrawerGettingStartedModalController, TKSideDrawerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sideDrawer = self.sideDrawer
        sideDrawer.delegate = self
        sideDrawer.content = self.setupSideDrawerContent()
        sideDrawer.style.headerHeight = 64
    }
    
    func setupSideDrawerContent() -> UIView {
        let sideDrawerContent = UIView()
        sideDrawerContent.backgroundColor = UIColor.clearColor()
        let imageView = UIImageView(image:UIImage(named: "logo"))
        imageView.frame = CGRectMake(sideDrawer!.width / 2 - imageView.frame.size.width / 2, self.view.frame.size.height / 2 - imageView.frame.size.height, imageView.frame.size.width, imageView.frame.size.height)
        sideDrawerContent.addSubview(imageView)
        
        return sideDrawerContent
    }
}
