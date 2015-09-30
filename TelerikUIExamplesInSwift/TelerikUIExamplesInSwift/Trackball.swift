//
//  Trackball.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class Trackball: ExampleViewController, TKChartDelegate {
    
    let chart = TKChart()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("pin at top") { self.top() }
        self.addOption("pin at left") { self.left() }
        self.addOption("pin at right") { self.right() }
        self.addOption("pin at bottom") { self.bottom() }
        self.addOption("floating") { self.floating() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
    
        var array1 = [TKChartDataPoint]()
        var array2 = [TKChartDataPoint]()
        for i in 0..<26 {
            array1.append(TKChartDataPoint(x: (i+1), y: Int(arc4random() % (100))))
            array2.append(TKChartDataPoint(x: (i+1), y: Int(arc4random() % (60))))
        }
    
        let xAxis = TKChartNumericAxis(minimum: 1, andMaximum: 26, position: TKChartAxisPosition.Bottom)
        xAxis.majorTickInterval = 5
        chart.addAxis(xAxis)
    
        var series = TKChartAreaSeries(items: array1)
        series.xAxis = xAxis
        chart.addSeries(series)
    
        series = TKChartAreaSeries(items: array2)
        series.xAxis = xAxis
        chart.addSeries(series)
    
        chart.allowTrackball = true
        chart.trackball.snapMode = TKChartTrackballSnapMode.AllClosestPoints
        chart.delegate = self
        chart.trackball.tooltip.style.textAlignment = NSTextAlignment.Left
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TKChartDelegate
    
    func chart(chart: TKChart, trackballDidTrackSelection selection: [AnyObject]) {
        let str = NSMutableString()
        var i = 0
        let count = selection.count
        for info in selection as! [TKChartSelectionInfo] {
            let data = info.dataPoint as TKChartData!
            str.appendFormat("Day %2.f series %d - %2.f", data.dataXValue as! Float, info.series!.index, data.dataYValue as! Float)
            if (i<count-1) {
                str.appendString("\n");
            }
            i++
        }
        chart.trackball.tooltip.text = str as String
    }
    
    //MARK: Events
    
    func left()
    {
        chart.trackball.hide()
        chart.trackball.orientation = TKChartTrackballOrientation.Horizontal
        chart.trackball.tooltip.pinPosition = TKChartTrackballPinPosition.Left
        chart.trackball.line.hidden = false
        chart.trackball.snapMode = TKChartTrackballSnapMode.AllClosestPoints
    }
    
    func right()
    {
        chart.trackball.hide()
        chart.trackball.orientation = TKChartTrackballOrientation.Horizontal
        chart.trackball.tooltip.pinPosition = TKChartTrackballPinPosition.Right
        chart.trackball.line.hidden = false
        chart.trackball.snapMode = TKChartTrackballSnapMode.AllClosestPoints
    }
    
    func top()
    {
        chart.trackball.hide()
        chart.trackball.orientation = TKChartTrackballOrientation.Vertical
        chart.trackball.tooltip.pinPosition = TKChartTrackballPinPosition.Top
        chart.trackball.line.hidden = false
        chart.trackball.snapMode = TKChartTrackballSnapMode.AllClosestPoints
    }
    
    func bottom()
    {
        chart.trackball.hide()
        chart.trackball.orientation = TKChartTrackballOrientation.Vertical
        chart.trackball.tooltip.pinPosition = TKChartTrackballPinPosition.Bottom
        chart.trackball.line.hidden = false
        chart.trackball.snapMode = TKChartTrackballSnapMode.AllClosestPoints
    }
    
    func floating()
    {
        chart.trackball.hide()
        chart.trackball.orientation = TKChartTrackballOrientation.Vertical
        chart.trackball.tooltip.pinPosition = TKChartTrackballPinPosition.None
        chart.trackball.line.hidden = true
        chart.trackball.snapMode = TKChartTrackballSnapMode.ClosestPoint
    }
}

