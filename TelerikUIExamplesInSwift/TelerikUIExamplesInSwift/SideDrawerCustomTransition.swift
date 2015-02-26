//
//  SideDrawerCustomTransition.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerCustomTransition: ExampleViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = SideDrawerCustomTransitionModalController()
        let sideDrawerController = TKSideDrawerController(content: contentController)
        sideDrawerController.view.backgroundColor = UIColor.grayColor()
        self.navigationController?.presentViewController(sideDrawerController, animated: true, completion: {() -> Void in
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(false)
            }
        })
    }
}
