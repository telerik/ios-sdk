//
//  StackedAreaChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedAreaChart: ExampleViewController {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        self.addOption("Stacked") { self.reloadData() }
        self.addOption("Stack 100") { self.reloadData() }
        self.addOption("No Stacking") { self.reloadData() }
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
    
    func reloadData() {
        chart.removeAllData()
        
        var stackInfo: TKChartStackInfo?
        if(self.selectedOption == 0) {
            stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
        }
        else if (self.selectedOption == 1)
        {
            stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack100)
        }
        
        for i in 0..<3 {
            let array = NSMutableArray()
            for i in 0..<8 {
                array.addObject(TKChartDataPoint(x: i+1, y: Int(arc4random() % (100))))
            }
            let series = TKChartAreaSeries(items: array)
            series.selectionMode = TKChartSeriesSelectionMode.Series
            series.stackInfo = stackInfo
            chart.addSeries(series)
        }

        chart.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
