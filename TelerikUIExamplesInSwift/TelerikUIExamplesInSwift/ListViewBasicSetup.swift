//
//  ListViewBasicSetup.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> listview-populating-ds-swift
class ListViewBasicSetup: UIViewController {
    // >> listview-feed-swift
       let sampleArrayOfStrings = ["Kristina Wolfe","Freda Curtis","Jeffery Francis","Eva Lawson","Emmett Santos", "Theresa Bryan", "Jenny Fuller", "Terrell Norris", "Eric Wheeler", "Julius Clayton", "Alfredo Thornton", "Roberto Romero","Orlando Mathis","Eduardo Thomas","Harry Douglas"]
    // << listview-feed-swift
    
    // >> listview-feed-ds-swift
        let dataSource = TKDataSource()
    // << listview-feed-ds-swift
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // >> listview-feed-ds-swift
        dataSource.itemSource = sampleArrayOfStrings
        // << listview-feed-ds-swift
        
        // >> listview-init-swift
        let listView = TKListView(frame: CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height-20))
        listView.dataSource = dataSource
        self.view.addSubview(listView)
        // << listview-init-swift
        
        // >> listview-init-selec-swift
        listView.allowsMultipleSelection = true
        // << listview-init-selec-swift
        
        // >> listview-init-reorder-swift
        listView.allowsCellReorder = true
        // << listview-init-reorder-swift
    }
}
// << listview-populating-ds-swift
