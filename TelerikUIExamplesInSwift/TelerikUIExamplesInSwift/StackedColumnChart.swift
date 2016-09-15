//
//  StackedColumnChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedColumnChart : TKExamplesExampleViewController {
    
    let chart = TKChart()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Stack", action: reloadData)
        self.addOption("Stack 100", action: reloadData)
        self.addOption("Clustered", action: reloadData)
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
    
    func reloadData()
    {
        chart.removeAllData()
        
        var stackInfo:TKChartStackInfo?
        
        if(self.selectedOption<2) {
           stackInfo = TKChartStackInfo(ID: 1, withStackMode: self.selectedOption == 0 ? TKChartStackMode.Stack : TKChartStackMode.Stack100)
        }
        
        // >> chart-column-cls-swift
        for i in 0..<4 {
            var points = [TKChartDataPoint]()
            for j in 1..<8 {
                points.append(TKChartDataPoint(x: j, y: Int(arc4random() % (100))))
            }
            let series = TKChartColumnSeries(items: points)
            series.title = "Series \(i)"
            series.stackInfo = stackInfo
            series.selection = TKChartSeriesSelection.Series
            chart.addSeries(series)
        }
        // << chart-column-cls-swift
        chart.reloadData()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
