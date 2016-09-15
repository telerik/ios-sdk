//
//  ChartDocsSelection.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//


class ChartDocsSelection: UIViewController, TKChartDelegate {

    var chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        
        var pointsWithValueAndName = [TKChartDataPoint]()
        pointsWithValueAndName.append(TKChartDataPoint(name: "Google", value: 20))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Apple", value: 30))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Microsoft", value: 10))
        pointsWithValueAndName.append(TKChartDataPoint(name: "IBM", value: 5))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Oracle", value: 8))
        
        let series = TKChartPieSeries(items: pointsWithValueAndName)
        series.selection = TKChartSeriesSelection.DataPoint
        series.expandRadius = 1.1
        chart.addSeries(series)
        
        // >> chart-get-selected-series-swift
        for series in chart.selectedSeries {
            print("selected series at index: \(series.index)")
        }
        
        for info in chart.selectedPoints {
            print("selected point at index \(info.dataPointIndex) from series \(info.series!.index)")
        }
        // << chart-get-selected-series-swift
    }
    
    // >> chart-progrm-selection-swift
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        chart.select(TKChartSelectionInfo(series: chart.series[0], dataPointIndex: 0))
    }
    // << chart-progrm-selection-swift
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- TKChartDelegate
    
    // >> chart-selection-delegate-swift
    func chart(chart: TKChart, didSelectSeries series: TKChartSeries) {
        // Here you can perform the desired action when the selection is changed.
    }
    
    func chart(chart: TKChart, didSelectPoint point: TKChartData, inSeries series: TKChartSeries, atIndex index: Int) {
        // Here you can perform the desired action when the selection is changed.
    }
    
    func chart(chart: TKChart, didDeselectSeries series: TKChartSeries) {
        // Here you can perform the desired action when the selection is changed.
    }
    
    func chart(chart: TKChart, didDeselectPoint point: TKChartData, inSeries series: TKChartSeries, atIndex index: Int) {
        // Here you can perform the desired action when the selection is changed.
    }
    // << chart-selection-delegate-swift
}
