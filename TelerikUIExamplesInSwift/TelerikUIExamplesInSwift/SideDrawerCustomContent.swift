//
//  SideDrawerCustomContent.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class SideDrawerCustomContent: ExampleViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = SideDrawerCustomContentModalController()
        let sideDrawerController = TKSideDrawerController(content: contentController)
        self.navigationController?.presentViewController(sideDrawerController, animated: true, completion: {() -> Void in
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(false)
            }
        })
    }
}
