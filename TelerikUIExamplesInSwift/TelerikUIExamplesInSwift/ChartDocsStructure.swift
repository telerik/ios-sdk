//
//  ChartDocsStructure.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsStructure: UIViewController, TKChartDelegate {

    let chart = TKChart()
    let values1 = [12, 10, 98, 64, 11, 27, 85, 72, 43, 39]
    let values2 = [87, 22, 29, 87, 65, 99, 63, 12, 82, 87]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
    }
    
    func structureSeries() {
        // >> chart-structure-series-swift
        let values1 = [12, 10, 98, 64, 11, 27, 85, 72, 43, 39]
        let values2 = [87, 22, 29, 87, 65, 99, 63, 12, 82, 87]
        var expensesData = [TKChartDataPoint]()
        var incomesData = [TKChartDataPoint]()
        for i in 0..<10 {
            expensesData.append(TKChartDataPoint(x: i, y: values2[i]))
            incomesData.append(TKChartDataPoint(x: i, y: values1[i]))
        }
        
        let stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
        let series1 = TKChartColumnSeries(items: expensesData)
        series1.title = "Expenses"
        series1.stackInfo = stackInfo
        chart.addSeries(series1)
        
        let series2 = TKChartColumnSeries(items: incomesData)
        series2.title = "Incomes"
        series2.stackInfo = stackInfo
        chart.addSeries(series2)
        // << chart-structure-series-swift
    }
    
    func structureAxes() {
        // >> chart-structure-axes-swift
        let xAxis = TKChartNumericAxis()
        xAxis.position = TKChartAxisPosition.Bottom
        chart.addAxis(xAxis)
        
        let yAxis1 = TKChartNumericAxis(minimum: 0, andMaximum: 100)
        yAxis1.majorTickInterval = 50
        yAxis1.position = TKChartAxisPosition.Left
        yAxis1.style.lineHidden = false
        chart.addAxis(yAxis1)
        
        let yAxis2 = TKChartNumericAxis(minimum: 0, andMaximum: 200)
        yAxis2.majorTickInterval = 50
        yAxis2.position = TKChartAxisPosition.Right
        yAxis2.style.lineHidden = false
        chart.addAxis(yAxis2)
        
        var incomesData = [TKChartDataPoint]()
        for i in 0..<10 {
            incomesData.append(TKChartDataPoint(x: i, y: values1[i]))
        }
        
        let series = TKChartLineSeries(items: incomesData)
        series.xAxis = xAxis
        series.yAxis = yAxis1
        chart.addSeries(series)
        // << chart-structure-axes-swift
        
    }
    
    // >> chart-structure-animation-swift
    func chart(chart: TKChart, animationForSeries series: TKChartSeries, withState state: TKChartSeriesRenderState, inRect rect: CGRect) -> CAAnimation? {
        var duration = 0.0
        var animations = [CAAnimation]()
        for i in 0..<state.points.count() {
            let pointKeyPath = state.animationKeyPathForPointAtIndex(i)!
            let keyPath = pointKeyPath + ".x"
            let point: TKChartVisualPoint = state.points[i] as! TKChartVisualPoint
            let animation = CABasicAnimation(keyPath: keyPath)
            animation.duration = Double(arc4random_uniform(100)) / 100.0
            animation.fromValue = 0
            animation.toValue = point.x
            animations.append(animation)
            duration = max(animation.duration, duration)
        }
        
        let group = CAAnimationGroup()
        group.duration = duration
        group.animations = animations
        return group
    }
    // << chart-structure-animation-swift
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
