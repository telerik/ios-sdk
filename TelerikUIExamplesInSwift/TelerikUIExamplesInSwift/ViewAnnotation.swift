//
//  ViewAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ViewAnnotation:ExampleViewController {
    
    let chart = TKChart()
    
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
        
        let image = UIImage(named: "logo")!
        let imageView = UIImageView(image: image)
        imageView.bounds = CGRectMake(0, 0, image.size.width, image.size.height)
        imageView.alpha = 0.7
        chart.addAnnotation(TKChartViewAnnotation(view: imageView, x: 550, y: 90, forSeries: chart.series()[0] as TKChartSeries))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

