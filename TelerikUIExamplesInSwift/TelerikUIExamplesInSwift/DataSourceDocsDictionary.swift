//
//  DataSourceDocsDictionary.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class DataSourceDocsDictionary: UIViewController {

     override func viewDidLoad() {
        super.viewDidLoad()
        
        // >> datasource-dict-swift
        let dictionary:NSDictionary = [ "John": 50, "Abby": 33, "Smith": 42, "Peter": 28, "Paula": 25 ]
        let dataSource = TKDataSource(itemSource: dictionary)
        dataSource.sortWithKey("", ascending: true)
        dataSource.filter { (name) -> Bool in
            return (dictionary.objectForKey(name) as! Int) > 30
        }
        // << datasource-dict-swift
    }
}
