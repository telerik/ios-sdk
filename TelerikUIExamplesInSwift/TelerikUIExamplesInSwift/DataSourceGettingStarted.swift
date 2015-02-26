//
//  DataSourceGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataSourceGettingStarted: ExampleViewController {

    var dataSource: TKDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Getting started"
        
        let dataSource = TKDataSource(array: [ 10, 5, 12, 7, 44 ])
        
        // filter all values less or equal to 5
        dataSource.filter { $0 as Int > 5 }
        
        // sort ascending
        dataSource.sort {
            let a = $0 as Int
            let b = $1 as Int
            if a<b { return NSComparisonResult.OrderedDescending }
            else if a>b { return NSComparisonResult.OrderedAscending }
            return NSComparisonResult.OrderedSame
        }
        
        // group odd/even values
        dataSource.group { ($0 as Int) % 2 }
        
        // multiply every value * 10
        dataSource.map { ($0 as Int) * 10 }
        
        // find the max value
        let maxValue = dataSource.reduce(0) {
            if $0 as Int > $1 as Int {
                return $0
            }
            return $1
        } as Int
        
        println("the max value is: \(maxValue)")
        
        // output everything to the console
        dataSource.enumerate {
            if $0.isKindOfClass(TKDataSourceGroup) {
                let group = $0 as TKDataSourceGroup
                println("group: \(group.key)")
            }
            else {
                println("\($0)")
            }
        }
        
        // bind with a table view
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = dataSource
        self.view.addSubview(tableView)
        
        self.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
