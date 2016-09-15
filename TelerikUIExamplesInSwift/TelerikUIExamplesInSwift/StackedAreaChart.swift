//
//  StackedAreaChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedAreaChart: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Stacked", action: reloadData)
        self.addOption("Stack 100", action: reloadData)
        self.addOption("No Stacking", action: reloadData)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        reloadData()
    }
    
    func reloadData() {
        chart.removeAllData()
        
        var stackInfo: TKChartStackInfo?
        if(self.selectedOption == 0) {
            // >> chart-stack-area-swift
            stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
            // << chart-stack-area-swift
        }
        else if (self.selectedOption == 1)
        {
            // >> chart-stack-area-100-swift
            stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack100)
            // << chart-stack-area-100-swift
        }
        
        // >> chart-stack-area-swift
        for _ in 0..<3 {
            var array = [TKChartDataPoint]()
            for i in 0..<8 {
                array.append(TKChartDataPoint(x: i+1, y: Int(arc4random() % (100))))
            }
            let series = TKChartAreaSeries(items: array)
            series.selection = TKChartSeriesSelection.Series
            series.stackInfo = stackInfo
            chart.addSeries(series)
        }
        // << chart-stack-area-swift

        chart.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
