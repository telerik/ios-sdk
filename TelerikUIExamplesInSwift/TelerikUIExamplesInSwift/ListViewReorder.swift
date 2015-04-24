//
//  ListViewReorder.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewReorder: ExampleViewController{

    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Enable reorder mode") { self.enableReorderSelected() }
        self.addOption("Disable reorder mode") { self.disableReorderSelected() }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.allowItemsReorder = true
        self.dataSource.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")
        
        self.listView.frame = self.view.bounds
        self.listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.listView.dataSource = self.dataSource
        self.listView.delegate = self.dataSource
        self.listView.layout.minimumLineSpacing = 0

        self.listView.allowsCellReorder = true
        self.view.addSubview(self.listView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableReorderSelected() {
        listView.allowsCellReorder = true
    }
    
    func disableReorderSelected() {
        listView.allowsCellReorder = false
    }
    
    
}
