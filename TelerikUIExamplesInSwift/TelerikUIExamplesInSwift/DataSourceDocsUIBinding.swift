//
//  DataSourceDocsUIBinding.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//


class DataSourceDocsUIBinding: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView() {
        // >> datasource-tableview-ui-swift
        let dataSource = TKDataSource(array: [ 10, 5, 12, 13, 7, 44 ])
        
        let tableView = UITableView(frame: CGRectInset(self.view.bounds, 0, 30))
        tableView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        tableView.dataSource = dataSource
        self.view.addSubview(tableView)
        // << datasource-tableview-ui-swift
        
        // >> datasource-cell-init-swift
        dataSource.settings.tableView .initCell({ (tableView, indexPath, cell, item) -> Void in
            cell.textLabel?.text = "Item:"
            cell.detailTextLabel?.text = dataSource.textFromItem(item, inGroup: nil)
        });
        // << datasource-cell-init-swift
        
        // >> datasource-cell-create-swift
        dataSource.settings.tableView.createCell { (tableView, indexPath, item) -> UITableViewCell in
            var cell = tableView.dequeueReusableCellWithIdentifier("cell")
            if cell == nil {
                cell = UITableViewCell(style:UITableViewCellStyle.Value1, reuseIdentifier:"cell")
            }
            return cell!
        }
        // << datasource-cell-create-swift
        
        // >> datasource-cell-group-swift
        dataSource.group({ (item) -> AnyObject in
            return item.intValue % 2 == 0;
        })
        // << datasource-cell-group-swift
    }
    
    func setupCollectionView(){
        
        let dataSource = TKDataSource(array: [ 10, 5, 12, 13, 7, 44 ])
        // >> datasource-collectionview-ui-swift
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(140, 140)
        
        let collectionView = UICollectionView(frame:CGRectInset(self.view.bounds, 0, 30), collectionViewLayout:layout)
        collectionView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        // << datasource-collectionview-ui-swift
        
        // >> datasource-collectionview-cell-init-swift
        dataSource.settings.collectionView.initCell({ (collectionView, indexPath,
            cell, item) -> Void in
            let tkCell = cell as! TKCollectionViewCell
            tkCell.label.text = dataSource.textFromItem(item, inGroup: nil)
        });
        // << datasource-collectionview-cell-init-swift
    }
    
    func setupListView() {
        let dataSource = TKDataSource()
        
        // >> datasource-listview-ui-swift
        let listView = TKListView(frame:CGRectInset(self.view.bounds, 0, 30))
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.dataSource = dataSource
        self.view.addSubview(listView)
        // << datasource-listview-ui-swift
        
        // >> datasource-listview-cell-create-swift
        dataSource.settings.listView.createCell({ (listView, indexPath, item) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("myCustomCell", forIndexPath:indexPath) as! TKListViewCell
        })
        
        dataSource.settings.listView.initCell({ (listView, indexPath, cell, item) -> Void in
            cell.textLabel.text = dataSource.textFromItem(item, inGroup:nil)
            (cell.backgroundView as! TKView).fill = TKSolidFill(color: UIColor(white: 0.1, alpha: 0.1))
        })
        // << datasource-listview-cell-create-swift
    }
    
    func setupChart() {
        let dataSource = TKDataSource()
        
        // >> datasource-chart-ui-swift
        var items:Array<DataSourceItem> = []
        items.append(DataSourceItem(name: "John", value: 50, group:"A"))
        items.append(DataSourceItem(name: "Abby", value: 33, group:"A"))
        items.append(DataSourceItem(name: "Paula", value: 33, group:"A"))
        
        items.append(DataSourceItem(name: "John", value: 42, group:"B"))
        items.append(DataSourceItem(name: "Abby", value: 28, group:"B"))
        items.append(DataSourceItem(name: "Paula", value: 25, group:"B"))
        
        dataSource.displayKey = "name"
        dataSource.valueKey = "value"
        dataSource.itemSource = items
        
        let chart = TKChart(frame:self.view.bounds)
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.dataSource = dataSource
        self.view.addSubview(chart)
        // << datasource-chart-ui-swift
        
        // >> datasource-chart-series-swift
        dataSource.groupWithKey("group")
        
        dataSource.settings.chart.createSeries({ (group) -> TKChartSeries! in
            let series = TKChartColumnSeries()
            return series
        })
        // << datasource-chart-series-swift
    }
    
    func setupCalendar() {
        let dataSource = TKDataSource()
        let items = []
        
        // >> datasource-calendar-ui-swift
        dataSource.displayKey = "name"
        dataSource.settings.calendar.startDateKey = "startDate"
        dataSource.settings.calendar.endDateKey = "endDate"
        dataSource.settings.calendar.defaultEventColor = UIColor.redColor()
        dataSource.itemSource = items
        
        let calendar = TKCalendar(frame:CGRectInset(self.view.bounds, 0, 30))
        calendar.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        calendar.dataSource = dataSource
        self.view.addSubview(calendar)
        // << datasource-calendar-ui-swift
    }
}
