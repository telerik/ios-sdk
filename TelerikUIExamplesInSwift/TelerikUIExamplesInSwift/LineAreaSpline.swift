//
//  LineAreaSpline.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class LineAreaSpline: ExampleViewController {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Line") { self.reloadChart() }
        self.addOption("Spline") { self.reloadChart() }
        self.addOption("Area") { self.reloadChart() }
        self.addOption("Area Spline") { self.reloadChart() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        self.reloadChart()
    }
    
    func reloadChart() {
        chart.removeAllData()
        
        for i in 0..<3 {
            var items = [TKChartDataPoint]()
            for i in 0..<8 {
                items.append(TKChartDataPoint(x:(i+1), y:Int(arc4random()%100)))
            }
            var series:TKChartSeries
            switch self.selectedOption {
                case 1:
                    series = TKChartSplineSeries(items:items)
                    break
            
                case 2:
                    series = TKChartAreaSeries(items:items)
                    break
            
                case 3:
                    series = TKChartSplineAreaSeries(items:items)
                    break
                
                default:
                    series = TKChartLineSeries(items:items)
                    break;
            }
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
    
