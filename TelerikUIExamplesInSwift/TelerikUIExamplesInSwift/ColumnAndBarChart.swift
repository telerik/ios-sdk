//
//  ColumnAndBarChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ColumnAndBarChart: TKExamplesExampleViewController {
    
    let chart = TKChart()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addOption("Column", action: columnSelected);
        self.addOption("Bar", action: barSelected);
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        chart.frame = frame
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        self.columnSelected()
    }
    
    func columnSelected() {
        chart.removeAllData()
        
        var items = [TKChartDataPoint]()
        for i in 0..<8 {
            items.append(TKChartDataPoint(x:(i+1), y:Int(arc4random()%100)))
        }
        
        let series = TKChartColumnSeries(items:items)
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(series)
        
        chart.reloadData()
    }
    
    func barSelected() {
        chart.removeAllData()
        
        var items = [TKChartDataPoint]()
        for i in 0..<8 {
            items.append(TKChartDataPoint(x:Int(arc4random()%100), y:(i+1)))
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







