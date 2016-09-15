//
//  BalloonAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class BalloonAnnotation:TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let values = [95, 40, 55, 30, 76, 34]
        var array = [TKChartDataPoint]()
        for i in 0..<months.count {
            array.append(TKChartDataPoint(x: months[i], y: values[i]))
        }
        let series = TKChartLineSeries(items: array)
        
        // >> chart-point-shape-swift
        series.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(10, 10))
        // << chart-point-shape-swift
        
        // >> chart-point-pallete-swift
        let paletteItem = TKChartPaletteItem()
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        let palette = TKChartPalette()
        palette.addPaletteItem(paletteItem)
        series.style.shapePalette = palette
        // << chart-point-pallete-swift
        
        chart.addSeries(series)
        
        // >> chart-balloon-annotation-swift
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributedText = NSMutableAttributedString(string: "Important milestone:\n $55000",
            attributes: [NSForegroundColorAttributeName:UIColor.whiteColor(), NSParagraphStyleAttributeName:paragraphStyle])
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.yellowColor(), range: NSMakeRange(22, 6))
        
        var balloon = TKChartBalloonAnnotation(x: "Mar", y: 55, forSeries: series)
        balloon.attributedText = attributedText
        balloon.style.distanceFromPoint = 20
        balloon.style.arrowSize = CGSizeMake(10, 10)
        chart.addAnnotation(balloon)
        // << chart-balloon-annotation-swift
        
        balloon = TKChartBalloonAnnotation(text: "The lowest value:\n $30000", x: "Apr", y: 30, forSeries: series)
        balloon.style.verticalAlign = TKChartBalloonVerticalAlignment.Bottom
        chart.addAnnotation(balloon)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
