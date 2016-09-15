//
//  ChartDocsPie.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsPie: UIViewController {
    var pointsWithValueAndName = [TKChartDataPoint]()
    var chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        
    }
    
    func pieSeries() {
        // >> chart-pie-swift
        pointsWithValueAndName.append(TKChartDataPoint(name: "Google", value: 20))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Apple", value: 30))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Microsoft", value: 10))
        pointsWithValueAndName.append(TKChartDataPoint(name: "IBM", value: 5))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Oracle", value: 8))
        
        let series = TKChartPieSeries(items: pointsWithValueAndName)
        chart.addSeries(series)
        chart.legend.hidden = false
        chart.legend.style.position = TKChartLegendPosition.Right
        // << chart-pie-swift
        
        // >> chart-pie-format-swift
        series.labelDisplayMode = TKChartPieSeriesLabelDisplayMode.Inside
        
        let  numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        series.style.pointLabelStyle.formatter = numberFormatter
        // << chart-pie-format-swift
        
        // >> chart-pie-format-percent-swift
        series.style.pointLabelStyle.stringFormat = "%.0f %%"
        // << chart-pie-format-percent-swift
    }
    
    func formatLabelsWithLabelFormatter() {
        let series = TKChartPieSeries(items: pointsWithValueAndName)
        chart.addSeries(series)
    }
    
    func startEndAngles() {
        let series = TKChartPieSeries(items: pointsWithValueAndName)
        chart.addSeries(series)
        
        // >> chart-pie-angle-swift
        series.startAngle = CGFloat(-M_PI_4 / 2)
        series.endAngle = CGFloat(M_PI + M_PI_4 / 2)
        series.rotationAngle = CGFloat(M_PI)
        // << chart-pie-angle-swift
    }
    
    func handleSelection() {
        let series = TKChartPieSeries(items: pointsWithValueAndName)
        chart.addSeries(series)
        
        // >> chart-pie-select-swift
        series.selection = TKChartSeriesSelection.DataPoint
        chart.select(TKChartSelectionInfo(series: series, dataPointIndex: 1))
        // << chart-pie-select-swift
    }

}
