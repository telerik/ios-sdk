//
//  StackedColumnChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedColumnChart : ExampleViewController {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        self.addOption("Stack") { self.reloadData() }
        self.addOption("Stack 100") { self.reloadData() }
        self.addOption("Clustered") { self.reloadData() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        reloadData()
    }
    
    func reloadData()
    {
        chart.removeAllData()
        
        var stackInfo:TKChartStackInfo?
        
        if(self.selectedOption<2) {
           stackInfo = TKChartStackInfo(ID: 1, withStackMode: self.selectedOption == 0 ? TKChartStackMode.Stack : TKChartStackMode.Stack100)
        }
        
        for i in 0..<4 {
            let points = NSMutableArray()
            for i in 1..<8 {
                points.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % (100))))
            }
            let series = TKChartColumnSeries(items: points)
            series.title = NSString(format: "Series %d", i)
            series.stackInfo = stackInfo
            series.selectionMode = TKChartSeriesSelectionMode.Series
            chart.addSeries(series)
        }
        
        chart.reloadData()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
