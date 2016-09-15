//
//  GapsLineSplineAreaChart.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import Foundation

class GapsLineSplineAreaChart: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Line", action: reloadChart)
        self.addOption("Spline", action: reloadChart)
        self.addOption("Area", action: reloadChart)
        self.addOption("Area Spline", action: reloadChart)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        self.reloadChart()
    }
    
    func reloadChart() {
        chart.removeAllData()
        
        var array = [TKChartDataPoint]()
        let categories = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
        let values = [ 65, 56, 65, 38, 56, 78, 62, 89, 78, 65 ]
        
        for i in 0..<categories.count {
            if(i==4 || i==5) {
                array.append(TKChartDataPoint(x:categories[i], y:nil))
            }
            else {
                array.append(TKChartDataPoint(x:categories[i], y:values[i]))
            }
        }
        
        var series:TKChartLineSeries
        
        switch self.selectedOption {
        case 1:
            series = TKChartSplineSeries(items:array)
            break
            
        case 2:
            series = TKChartAreaSeries(items:array)
            break
            
        case 3:
            series = TKChartSplineAreaSeries(items:array)
            break
            
        default:
            series = TKChartLineSeries(items:array)
            break;
        }
        
        series.selection = TKChartSeriesSelection.Series
        series.displayNilValuesAsGaps = true
        chart.addSeries(series)
    }
}

