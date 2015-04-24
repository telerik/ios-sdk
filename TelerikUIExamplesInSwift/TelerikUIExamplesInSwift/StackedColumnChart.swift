//
//  StackedColumnChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StackedColumnChart : ExampleViewController {
    
    let chart = TKChart()

    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Stack") { self.reloadData() }
        self.addOption("Stack 100") { self.reloadData() }
        self.addOption("Clustered") { self.reloadData() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
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
            var points = [TKChartDataPoint]()
            for j in 1..<8 {
                points.append(TKChartDataPoint(x: j, y: Int(arc4random() % (100))))
            }
            let series = TKChartColumnSeries(items: points)
            series.title = "Series \(i)"
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
