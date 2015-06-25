//
//  StackedAreaChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedAreaChart: ExampleViewController {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Stacked") { self.reloadData() }
        self.addOption("Stack 100") { self.reloadData() }
        self.addOption("No Stacking") { self.reloadData() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
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
        
        for _ in 0..<3 {
            var array = [TKChartDataPoint]()
            for i in 0..<8 {
                array.append(TKChartDataPoint(x: i+1, y: Int(arc4random() % (100))))
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
