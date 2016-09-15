//
//  ListViewDocsSetupDataSource.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> listview-populating-swift
class ListViewDocsSetupDataSource: TKExamplesExampleViewController, TKListViewDataSource {
    
    let sampleArrayOfStrings = ["Kristina Wolfe","Freda Curtis","Jeffery Francis","Eva Lawson","Emmett Santos", "Theresa Bryan", "Jenny Fuller", "Terrell Norris", "Eric Wheeler", "Julius Clayton", "Alfredo Thornton", "Roberto Romero","Orlando Mathis","Eduardo Thomas","Harry Douglas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listView = TKListView(frame:  self.view.bounds)
        listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        listView.dataSource = self
        listView.selectionBehavior = TKListViewSelectionBehavior.None
        self.view.addSubview(listView)
    }
    
    func  listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)  as! TKListViewCell
        
        cell.textLabel.text = self.sampleArrayOfStrings[indexPath.row]
        
        return cell
    }
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return self.sampleArrayOfStrings.count
    }
    
    func numberOfSectionsInListView(listView: TKListView) -> Int {
        return 1
    }
}
// << listview-populating-swift
