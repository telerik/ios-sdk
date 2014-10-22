//
//  ColumnAndBarChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ColumnAndBarChart: ExampleViewController {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        self.addOption("Column") { self.columnSelected() }
        self.addOption("Bar") { self.barSelected() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chart.frame = self.exampleBounds;
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        self.columnSelected()
    }
    
    func columnSelected() {
        chart.removeAllData()
        
        let items = NSMutableArray()
        for i in 0..<8 {
            items.addObject(TKChartDataPoint(x:(i+1), y:Int(arc4random()%100)))
        }
        
        let series = TKChartColumnSeries(items:items)
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(series)
        
        chart.reloadData()
    }
    
    func barSelected() {
        chart.removeAllData()
        
        let items = NSMutableArray()
        for i in 0..<8 {
            items.addObject(TKChartDataPoint(x:Int(arc4random()%100), y:(i+1)))
        }
        
        let series = TKChartBarSeries(items:items)
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(series)

        chart.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}







