//
//  ViewController.swift
//  SeismographSwift
//
//  Created by Nikolay Diyanov on 12/19/14.
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics
import CoreMotion

enum AxisType : Int {
    case X = 0
    case Y = 1
    case Z = 2
}

let coefficient : Double = 1000

class ViewController: UIViewController {
    
    @IBOutlet var chart: TKChart!
    @IBOutlet var axesButtons: UISegmentedControl!
    @IBOutlet var controlButtons: UISegmentedControl!
    var dataPoints = [TKChartDataPoint]()
    var aType = AxisType.X
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.startOperations()
    }
    
    func startOperations() {
        motionManager.accelerometerUpdateInterval = 0.2
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { accelerometerData, error in
                
                let acceleration = accelerometerData.acceleration
                
                switch self.aType {
                case .X:
                    self.buildChartWithPoint(coefficient * acceleration.x)
                case .Y:
                    self.buildChartWithPoint(coefficient * acceleration.y)
                case .Z:
                    self.buildChartWithPoint(coefficient * acceleration.z)
                default:
                    break
                }
            })
        }
    }
    
    func buildChartWithPoint(point: Double) {
        self.chart.removeAllData()
        self.chart.removeAllAnnotations()
        
        let lastPoint = TKChartDataPoint(x: NSDate(), y: point)
        dataPoints.append(lastPoint)
        
        if dataPoints.count > 25 {
            dataPoints.removeAtIndex(0)
        }
        
        let yAxis = TKChartNumericAxis(minimum: -coefficient, andMaximum: coefficient)
        yAxis.position = TKChartAxisPosition.Left
        yAxis.majorTickInterval = 200
        yAxis.minorTickInterval = 1
        yAxis.offset = 0
        yAxis.baseline = 0
        yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitMode.Rotate
        yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment.Left
        self.chart.yAxis = yAxis
        
        let lineSeries = TKChartLineSeries(items: dataPoints)
        lineSeries.style.palette = TKChartPalette()
        let strokeRed = TKStroke(color: UIColor.redColor(), width: 1.5)
        lineSeries.style.palette.addPaletteItem(TKChartPaletteItem(stroke: strokeRed))
        chart.addSeries(lineSeries)
        
        let axisColor = TKStroke(color: UIColor.blackColor(), width: 1)
        chart.xAxis.style.lineStroke = axisColor
        chart.xAxis.style.majorTickStyle.ticksHidden = true
        chart.xAxis.style.labelStyle.textHidden = true
        
        let dashStroke = TKStroke(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), width: 0.5)
        dashStroke.dashPattern = [6, 1]
        
        let annotationBandRed = TKChartBandAnnotation(range: TKRange(minimum: -1000, andMaximum: 1000), forAxis: chart.yAxis)
        annotationBandRed.style.fill = TKSolidFill(color: UIColor(red: 255/255, green: 149/255, blue: 149/255, alpha: 0.7))
        chart.addAnnotation(annotationBandRed)
        
        let annotationBandYellow = TKChartBandAnnotation(range: TKRange(minimum: -500, andMaximum: 500), forAxis: chart.yAxis)
        annotationBandYellow.style.fill = TKSolidFill(color: UIColor(red: 255/255, green: 255/255, blue: 138/255, alpha: 0.7))
        chart.addAnnotation(annotationBandYellow)
        
        let annotationBandGreen = TKChartBandAnnotation(range: TKRange(minimum: -300, andMaximum: 300), forAxis: chart.yAxis)
        annotationBandGreen.style.fill = TKSolidFill(color: UIColor(red: 152/255, green: 255/255, blue: 149/255, alpha: 1))
        chart.addAnnotation(annotationBandGreen)
        
        let positiveDashAnnotation = TKChartGridLineAnnotation(value: 150, forAxis: chart.yAxis)
        positiveDashAnnotation.style.stroke = dashStroke
        chart.addAnnotation(positiveDashAnnotation)
        
        let negativeDashAnnotation = TKChartGridLineAnnotation(value: -150, forAxis: chart.yAxis)
        negativeDashAnnotation.style.stroke = dashStroke
        chart.addAnnotation(negativeDashAnnotation)
        
        if dataPoints.count > 1 {
            let needle = NeedleAnnotation(point:lastPoint, forSeries: lineSeries)
            needle.zPosition = TKChartAnnotationZPosition.AboveSeries
            chart.addAnnotation(needle)
        }
    }
    
    @IBAction func controlButtonsValueChanged(sender: AnyObject) {
        let category = controlButtons.titleForSegmentAtIndex(controlButtons.selectedSegmentIndex)
        if category == "Start" {
            self.startOperations()
        }
        else if category == "Stop" {
            motionManager.stopAccelerometerUpdates()
            NSOperationQueue.currentQueue()!.cancelAllOperations()
        }
        else if category == "Reset" {
            dataPoints.removeAll(keepCapacity: true)
            chart.removeAllData()
        }
    }
    
    @IBAction func axesButtonsValueChanged(sender: AnyObject) {
        dataPoints.removeAll(keepCapacity: true)
        chart.removeAllData()
        aType = AxisType(rawValue:axesButtons.selectedSegmentIndex)!
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

