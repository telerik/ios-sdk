//
//  ListViewGettingStarted.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewGettingStarted: ExampleViewController, TKListViewDataSource {
    
    let names = TKDataSource()
    let photos = TKDataSource()
    
    override func viewDidLoad() {
        
        self.names.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")
        self.photos.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "photos")
        
        let listView = TKListView(frame: self.view.bounds)
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.dataSource = self
        self.view.addSubview(listView)
        listView.registerClass(ImageWithTextListViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        let layout = TKListViewGridLayout()
        layout.itemAlignment = TKListViewItemAlignment.Center
        layout.spanCount = 2
        layout.itemSize = CGSizeMake(150, 200)
        layout.lineSpacing = 60
        layout.itemSpacing = 10
        listView.layout = layout
        
        let view = TKView()
        view.fill = TKLinearGradientFill(colors: [UIColor(red: 0.35, green: 0.68, blue: 0.89, alpha: 0.89),
                                                      UIColor(red: 0.35, green: 0.68, blue: 1.00, alpha: 1.00),
                                                      UIColor(red: 0.85, green: 0.80, blue: 0.20, alpha: 0.80)])
        listView.backgroundView = view
    }
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return names.items.count
    }
    
    func listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        cell.imageView.image =  UIImage(named: photos.items[indexPath.row] as! String)
        cell.textLabel.text = names.items[indexPath.row] as? String
        return cell
    
    }
}
