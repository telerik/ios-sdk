//
//  MultipleAxes.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class MultipleAxes:ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
    
        let gdpInPoundsYAxis = TKChartNumericAxis(minimum: 1050, andMaximum: 1400)
        gdpInPoundsYAxis.majorTickInterval = 50
        gdpInPoundsYAxis.position = TKChartAxisPosition.Left
        gdpInPoundsYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Left
        gdpInPoundsYAxis.style.majorTickStyle.ticksHidden = false
        gdpInPoundsYAxis.style.lineHidden = false
        chart.addAxis(gdpInPoundsYAxis)
        chart.yAxis = gdpInPoundsYAxis
        
        let periodXAxis = TKChartDateTimeAxis()
        periodXAxis.majorTickIntervalUnit = TKChartDateTimeAxisIntervalUnit.Years
        periodXAxis.majorTickInterval = 1
        periodXAxis.position = TKChartAxisPosition.Bottom
        periodXAxis.setPlotMode(TKChartAxisPlotMode.BetweenTicks)
        chart.addAxis(periodXAxis)
        
        let gdpInvestmentYAxis = TKChartNumericAxis(minimum: 0, andMaximum: 20)
        gdpInvestmentYAxis.majorTickInterval = 5
        gdpInvestmentYAxis.position = TKChartAxisPosition.Right
        gdpInvestmentYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Left
        gdpInvestmentYAxis.style.majorTickStyle.ticksHidden = false
        gdpInvestmentYAxis.style.lineHidden = false
        chart.addAxis(gdpInvestmentYAxis)
        
        let gdpGrowthUpAnnualChangeYAxis = TKChartNumericAxis(minimum:-6, andMaximum:4)
        gdpGrowthUpAnnualChangeYAxis.majorTickInterval = 1
        gdpGrowthUpAnnualChangeYAxis.position = TKChartAxisPosition.Right
        gdpGrowthUpAnnualChangeYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Left
        gdpGrowthUpAnnualChangeYAxis.style.majorTickStyle.ticksHidden = false
        gdpGrowthUpAnnualChangeYAxis.style.lineHidden = false
        chart.addAxis(gdpGrowthUpAnnualChangeYAxis)
        
        let grossNationalSavingsAnnualGrowthUpYAxis = TKChartNumericAxis(minimum:0, andMaximum:16)
        grossNationalSavingsAnnualGrowthUpYAxis.majorTickInterval = 2
        grossNationalSavingsAnnualGrowthUpYAxis.position = TKChartAxisPosition.Right
        grossNationalSavingsAnnualGrowthUpYAxis.style.labelStyle.textAlignment = TKChartAxisLabelAlignment.Left
        grossNationalSavingsAnnualGrowthUpYAxis.style.majorTickStyle.ticksHidden = false
        grossNationalSavingsAnnualGrowthUpYAxis.style.lineHidden = false
        chart.addAxis(grossNationalSavingsAnnualGrowthUpYAxis)
        
        let date2001:NSDate = MultipleAxes.dateWithYear(2001, month: 12, day: 31)
        let date2002:NSDate = MultipleAxes.dateWithYear(2002, month: 12, day: 31)
        let date2003:NSDate = MultipleAxes.dateWithYear(2003, month: 12, day: 31)
        let date2004:NSDate = MultipleAxes.dateWithYear(2004, month: 12, day: 31)
        let date2005:NSDate = MultipleAxes.dateWithYear(2005, month: 12, day: 31)
        
        let gdpInPounds = [TKChartDataPoint(x:date2001, y:1200),
            TKChartDataPoint(x:date2002, y:1200),
            TKChartDataPoint(x:date2003, y:1225),
            TKChartDataPoint(x:date2004, y:1300),
            TKChartDataPoint(x:date2005, y:1350)]
        
        let gdpInPoundsSeries = TKChartColumnSeries(items: gdpInPounds)
        gdpInPoundsSeries.xAxis = periodXAxis
        gdpInPoundsSeries.yAxis = gdpInPoundsYAxis
        gdpInPoundsSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(gdpInPoundsSeries)
        
        let gdpGrowthUpAnnual = [TKChartDataPoint(x:date2001, y:4),
            TKChartDataPoint(x:date2002, y:3),
            TKChartDataPoint(x:date2003, y:2),
            TKChartDataPoint(x:date2004, y:-5),
            TKChartDataPoint(x:date2005, y:1)]
        
        let shapeSize = CGFloat(UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 7.0 : 17.0);
        let gdpGrowthUpSeries = TKChartLineSeries(items:gdpGrowthUpAnnual)
        gdpGrowthUpSeries.style.pointShape = TKPredefinedShape(type:TKShapeType.Circle, andSize: CGSizeMake(shapeSize, shapeSize))
        gdpGrowthUpSeries.xAxis = periodXAxis
        gdpGrowthUpSeries.yAxis = gdpGrowthUpAnnualChangeYAxis
        gdpGrowthUpSeries.selectionMode = TKChartSeriesSelectionMode.Series
        gdpGrowthUpSeries.style.shapeMode = TKChartSeriesStyleShapeMode.AlwaysShow
        chart.addSeries(gdpGrowthUpSeries)
        
        let grossAnualSavings = [TKChartDataPoint(x:date2001, y:14),
            TKChartDataPoint(x:date2002, y:8),
            TKChartDataPoint(x:date2003, y:12),
            TKChartDataPoint(x:date2004, y:11),
            TKChartDataPoint(x:date2005, y:16)]
        
        let grossAnualSavingsSeries = TKChartLineSeries(items: grossAnualSavings)
        grossAnualSavingsSeries.style.pointShape = TKPredefinedShape(type:TKShapeType.Circle, andSize:CGSizeMake(shapeSize, shapeSize))
        grossAnualSavingsSeries.xAxis = periodXAxis
        grossAnualSavingsSeries.yAxis = grossNationalSavingsAnnualGrowthUpYAxis
        grossAnualSavingsSeries.selectionMode = TKChartSeriesSelectionMode.Series
        grossAnualSavingsSeries.style.shapeMode = TKChartSeriesStyleShapeMode.AlwaysShow
        chart.addSeries(grossAnualSavingsSeries)
        
        let gdpInvestment = [TKChartDataPoint(x:date2001, y:15),
                            TKChartDataPoint(x:date2002, y:13),
                            TKChartDataPoint(x:date2003, y:16),
                            TKChartDataPoint(x:date2004, y:19),
                            TKChartDataPoint(x:date2005, y:15)]
        
        let gdpInvestmentSeries = TKChartLineSeries(items:gdpInvestment)
        gdpInvestmentSeries.style.pointShape = TKPredefinedShape(type:TKShapeType.Circle, andSize:CGSizeMake(shapeSize, shapeSize))
        gdpInvestmentSeries.xAxis = periodXAxis
        gdpInvestmentSeries.yAxis = gdpInPoundsYAxis
        gdpInvestmentSeries.selectionMode = TKChartSeriesSelectionMode.Series
        gdpInvestmentSeries.style.shapeMode = TKChartSeriesStyleShapeMode.AlwaysShow
        chart.addSeries(gdpInvestmentSeries)
        
        MultipleAxes.setStyle(gdpInPoundsSeries)
        MultipleAxes.setStyle(grossAnualSavingsSeries)
        MultipleAxes.setStyle(gdpGrowthUpSeries)
        MultipleAxes.setStyle(gdpInvestmentSeries)
        
        chart.reloadData()
    }
    
    class func dateWithYear(year: Int, month: Int, day: Int) -> NSDate {
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar.dateFromComponents(components)!
    }
    
    class func setStyle(series:TKChartSeries) {
        let item = series.style.palette.paletteItemAtIndex(series.index)
        
        if series.isKindOfClass(TKChartColumnSeries) && item.drawables.count > 1 {
            let drawable = item.drawables[2] as! TKDrawing
            
            if drawable.isKindOfClass(TKStroke){
                var stroke = drawable as! TKStroke
                series.yAxis.style.lineStroke = TKStroke(fill: stroke.fill)
            }
            else {
                series.yAxis.style.lineStroke = TKStroke(fill: item.stroke.fill)
            }
        }
        else {
            series.yAxis.style.lineStroke = TKStroke(fill: item.stroke.fill)
        }
        
        series.yAxis.style.majorTickStyle.ticksFill = series.yAxis.style.lineStroke.fill
        series.yAxis.style.majorTickStyle.maxTickClippingMode = TKChartAxisClippingMode.Visible
        series.yAxis.style.majorTickStyle.minTickClippingMode = TKChartAxisClippingMode.Visible
        
        if series.yAxis.style.majorTickStyle.ticksFill.isKindOfClass(TKSolidFill) {
            let solidFill = series.yAxis.style.majorTickStyle.ticksFill as! TKSolidFill
            series.yAxis.style.labelStyle.textColor = solidFill.color
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
