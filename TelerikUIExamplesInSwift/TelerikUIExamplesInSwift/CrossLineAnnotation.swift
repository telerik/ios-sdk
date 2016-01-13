//
//  CrossLineAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CrossLineAnnotation: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("cross lines", action: crossLine)
        self.addOption("horizontal line", action: horizontalLine)
        self.addOption("vertical line", action: verticalLine)
        self.addOption("disable lines", action: disableLines)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        for _ in 0..<2 {
            var points = [TKChartDataPoint]()
            for _ in 0..<20 {
                points.append(TKChartDataPoint(x: Int(arc4random() % (1450)), y: Int(arc4random() % (150))))
            }
            chart.addSeries(TKChartScatterSeries(items: points))
        }
        
        // Add a cross line annotation
        chart.addAnnotation(TKChartCrossLineAnnotation(x: 900, y: 60, forSeries: chart.series[0]))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Events
    
    func crossLine()
    {
        let a = chart.annotations[0] as! TKChartCrossLineAnnotation
        a.style.verticalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.horizontalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func horizontalLine()
    {
        let a = chart.annotations[0] as! TKChartCrossLineAnnotation
        a.style.verticalLineStroke = nil
        a.style.horizontalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func verticalLine()
    {
        let a = chart.annotations[0] as! TKChartCrossLineAnnotation
        a.style.verticalLineStroke = TKStroke(color: UIColor.blackColor())
        a.style.horizontalLineStroke = nil
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(4, 4))
        chart.updateAnnotations()
    }
    
    func disableLines()
    {
        let a = chart.annotations[0] as! TKChartCrossLineAnnotation
        a.style.verticalLineStroke = nil
        a.style.horizontalLineStroke = nil
        a.style.pointShape = TKPredefinedShape(type: TKShapeType.TriangleUp, andSize: CGSizeMake(20, 20))
        chart.updateAnnotations()
    }
}