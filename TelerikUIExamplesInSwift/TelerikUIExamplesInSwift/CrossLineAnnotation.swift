//
//  CrossLineAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CrossLineAnnotation: ExampleViewController {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        self.addOption("cross lines") { self.crossLine() }
        self.addOption("horizontal line") { self.horizontalLine() }
        self.addOption("vertical line") { self.verticalLine() }
        self.addOption("disable lines") { self.disableLines() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        for i in 0..<2 {
            let points = NSMutableArray()
            for i in 0..<20 {
                points.addObject(TKChartDataPoint(x: Int(arc4random() % (1450)), y: Int(arc4random() % (150))))
            }
            chart.addSeries(TKChartScatterSeries(items: points))
        }
        
        // Add a cross line annotation
        chart.addAnnotation(TKChartCrossLineAnnotation(x: 900, y: 60, forSeries: chart.series()[0] as TKChartSeries))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Events
    
    func crossLine()
    {
        let a = chart.annotations()[0] as TKChartCrossLineAnnotation
        a.style.verticalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.horizontalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func horizontalLine()
    {
        let a = chart.annotations()[0] as TKChartCrossLineAnnotation
        a.style.verticalLineStroke = nil
        a.style.horizontalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func verticalLine()
    {
        let a = chart.annotations()[0] as TKChartCrossLineAnnotation
        a.style.verticalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.horizontalLineStroke = nil
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func disableLines()
    {
        let a = chart.annotations()[0] as TKChartCrossLineAnnotation
        a.style.verticalLineStroke = nil
        a.style.horizontalLineStroke = nil
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.TriangleUp, andSize: CGSizeMake(20, 20))
        chart.updateAnnotations()
    }
}