//
//  ChartDocsPopulatingWithData.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ModelObject: NSObject {
    var objectID = 0
    var value1 = 0
    var value2 = 0
    var value3 = 0
    
    init(objectID: Int, value1: Int, value2: Int, value3: Int) {
        self.objectID = objectID
        self.value1 = value1
        self.value2 = value2
        self.value3 = value3
    }
}

class ChartDocsPopulatingWithData: UIViewController, TKChartDataSource {

    // >> chart-populating-delegate-swift
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        self.view.addSubview(chart)
        chart.dataSource = self
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
    }
    
    func seriesForChart(chart: TKChart, atIndex index: UInt) -> TKChartSeries {
        var series = chart.dequeueReusableSeriesWithIdentifier("series1") as? TKChartSeries
        if series == nil {
            series = TKChartLineSeries(items: nil, reuseIdentifier: "series1")
            series!.title = "Series title"
        }
        return series!
    }
    
    func numberOfSeriesForChart(chart: TKChart) -> UInt {
        return 1
    }
    
    func chart(chart: TKChart, numberOfDataPointsForSeriesAtIndex seriesIndex: UInt) -> UInt {
        return 10
    }
    
    func chart(chart: TKChart, dataPointAtIndex dataIndex: UInt, forSeriesAtIndex seriesIndex: UInt) -> TKChartData {
        let point = TKChartDataPoint(x: dataIndex, y: Int(arc4random_uniform(100)))
        return point
    }
    // << chart-populating-delegate-swift
    
    func populateWithDataPoints(){
        // >> chart-populating-datapoints-swift
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        self.view.addSubview(chart)
        
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ];
        let values = [70, 75, 58, 59, 88]
        var dataPoints = [TKChartDataPoint]()
        for i in 0 ..< categories.count {
            dataPoints.append(TKChartDataPoint(x: categories[i], y: values[i]))
        }
        
        let series = TKChartColumnSeries(items: dataPoints)
        chart.addSeries(series)
        // << chart-populating-datapoints-swift
    }
    
    func bindToDataModel() {
        // >> chart-binding-props-swift
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        self.view.addSubview(chart)
        
        var dataPoints = [ModelObject]()
        for i in 0...5 {
            let object = ModelObject(objectID: i, value1: Int(arc4random_uniform(100)), value2: Int(arc4random_uniform(100)), value3: Int(arc4random_uniform(100)))
            dataPoints.append(object)
        }
        
        chart.beginUpdates()
        chart.addSeries(TKChartLineSeries(items: dataPoints, forKeys: ["dataXValue": "objectID", "dataYValue": "value1"]))
        chart.addSeries(TKChartAreaSeries(items: dataPoints, forKeys: ["dataXValue": "objectID", "dataYValue": "value2"]))
        chart.addSeries(TKChartScatterSeries(items: dataPoints, forKeys: ["dataXValue": "objectID", "dataYValue": "value3"]))
        chart.endUpdates()
        // << chart-binding-props-swift
    }
}
