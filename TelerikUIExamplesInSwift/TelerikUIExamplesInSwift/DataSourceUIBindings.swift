//
//  DataSourceUIBindings.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataSourceUIBindings: ExampleViewController {

    let dataSource = TKDataSource()
    
    override init() {
        super.init();
        
        self.addOption("TKChart") { self.useChart() }
        self.addOption("TKCalendar") { self.useCalendar() }
        self.addOption("UITableView") { self.useTableView() }
        self.addOption("UICollectionView") { self.useCollectionView() }
        self.addOption("TKListView") { self.useListView() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Bind with UI controls"
        
        let imageNames = [ "CENTCM.jpg", "FAMIAF.jpg", "CHOPSF.jpg", "DUMONF.jpg", "ERNSHM.jpg", "FOLIGF.jpg" ];
        let names = [ "John", "Abby", "Phill", "Saly", "Robert", "Donna" ]
        var items = [DSItem]()
        for i in 0..<names.count {
            var item = DSItem()
            item.name = names[i]
            item.value = Float(arc4random()%100)
            item.group = (arc4random()%100)>50 ? "two" : "one"
            item.image = UIImage(named: imageNames[i])
            let calendar = NSCalendar.currentCalendar()
            let components = NSDateComponents()
            components.day = Int(arc4random()%10)
            item.date = calendar.dateByAddingComponents(components, toDate:NSDate(), options:NSCalendarOptions(0))
            items.append(item)
        }
        
        self.dataSource.displayKey = "name"
        self.dataSource.valueKey = "value"
        self.dataSource.itemSource = items
        
        self.useChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func useChart() {
        if self.view.subviews.count>0 {
            self.view.subviews[0].removeFromSuperview()
        }
        
        self.dataSource.settings.chart.createSeries { (TKDataSourceGroup group) -> TKChartSeries! in
            let series = TKChartColumnSeries()
            series.selectionMode = TKChartSeriesSelectionMode.DataPoint
            series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
            return series
        }
        
        let chart = TKChart(frame:self.view.bounds)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.dataSource = self.dataSource
        self.view.addSubview(chart)
    }
    
    func useCalendar() {
        if self.view.subviews.count>0 {
            self.view.subviews[0].removeFromSuperview()
        }
        
        self.dataSource.settings.calendar.startDateKey = "date"
        self.dataSource.settings.calendar.endDateKey = "date"
        self.dataSource.settings.calendar.defaultEventColor = UIColor.redColor()
        
        let calendar = TKCalendar(frame:self.view.bounds)
        calendar.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        calendar.dataSource = self.dataSource
        self.view.addSubview(calendar)
        
        let presenter = calendar.presenter() as TKCalendarMonthPresenter
        presenter.inlineEventsViewMode = TKCalendarInlineEventsViewMode.Inline
    }
    
    func useTableView() {
        if self.view.subviews.count>0 {
            self.view.subviews[0].removeFromSuperview()
        }
        
        // optional
        self.dataSource.settings.tableView.createCell { (UITableView tableView, NSIndexPath indexPath, AnyObject item) -> UITableViewCell in
            var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
            if cell == nil {
                cell = UITableViewCell(style:UITableViewCellStyle.Value1, reuseIdentifier:"cell")
            }
            return cell!
        }
        
        // optional
        self.dataSource.settings.tableView.initCell { (UITableView tableView, NSIndexPath indexPath, UITableViewCell cell, AnyObject item) in
            let dsitem = item as DSItem
            cell.textLabel!.text = dsitem.name
            cell.detailTextLabel!.text = "\(dsitem.value)"
        }
        
        let tableView = UITableView(frame:self.view.bounds)
        tableView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        tableView.dataSource = self.dataSource
        self.view.addSubview(tableView)
    }
    
    func useCollectionView() {
        if self.view.subviews.count>0 {
            self.view.subviews[0].removeFromSuperview()
        }

        self.dataSource.settings.collectionView.createCell { (UICollectionView collectionView, NSIndexPath indexPath, AnyObject item) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath:indexPath) as UICollectionViewCell
            return cell
        }
        
        self.dataSource.settings.collectionView.initCell { (UICollectionView collectionView, NSIndexPath indexPath, UICollectionViewCell cell, AnyObject item) in
            let dscell = cell as DSCollectionViewCell
            let dsitem = item as DSItem
            dscell.label.text = self.dataSource.textFromItem(item, inGroup: nil)
            dscell.imageView.image = dsitem.image
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(140, 140)
        
        let collectionView = UICollectionView(frame:CGRectInset(self.view.bounds, 10, 10), collectionViewLayout:layout)
        collectionView.registerClass(DSCollectionViewCell.self, forCellWithReuseIdentifier:"cell")
        collectionView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        collectionView.dataSource = self.dataSource
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
    }
    
    func useListView() {
        if self.view.subviews.count>0 {
            self.view.subviews[0].removeFromSuperview();
        }
        
        let listView = TKListView(frame: self.view.bounds)
        listView.dataSource = self.dataSource
        self.view.addSubview(listView)
    }
}
