//
//  ViewController.swift
//  BlogExamplesInswift
//
//  Created by Yoanna Mareva on 27.10.15.
//  Copyright © 2015 г. Yoanna Mareva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TKGaugeDelegate {

    let temperature: TKRadialGauge = TKRadialGauge()
    let humidity: TKRadialGauge = TKRadialGauge()
    let wind: TKRadialGauge = TKRadialGauge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let iv :UIImageView = UIImageView(frame: self.view.frame)
        iv.image = UIImage(named: "time1.jpg")
        self.view.addSubview(iv)
        self.temperatureGauge()
        self.humidityGauge()
        self.windGauge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func temperatureGauge()
    {
        temperature.delegate = self
        self.view.addSubview(temperature)
        
        let radialScale = TKGaugeRadialScale(minimum: -30, maximum: 40)
        radialScale.ticks.hidden = true
        radialScale.labels.hidden = true
        temperature.addScale(radialScale)
        let mainTemperatureSegment = TKGaugeSegment(minimum:-30, maximum:40)
        mainTemperatureSegment.cap = TKGaugeSegmentCap.Round
        mainTemperatureSegment.location = 0.87
        mainTemperatureSegment.fill = TKSolidFill(color: UIColor.whiteColor().colorWithAlphaComponent(0.5))
        mainTemperatureSegment.width = 0.08
        radialScale.addSegment(mainTemperatureSegment)
        
        let measureTemperatureSegment = TKGaugeSegment()
        measureTemperatureSegment.allowTouch = true
        measureTemperatureSegment.cap = TKGaugeSegmentCap.Round
        measureTemperatureSegment.location = 0.9
        measureTemperatureSegment.width = 0.14
        measureTemperatureSegment.fill = TKLinearGradientFill(colors: [UIColor(red:0.27, green:0.64, blue:0.99, alpha:1.0), UIColor(red:1.00, green:0.74, blue:0.00, alpha:1.0)])
        measureTemperatureSegment.shadowOpacity = 0.5
        measureTemperatureSegment.shadowOffset = CGSizeMake(0, 0)
        measureTemperatureSegment.setRangeAnimated(TKRange(minimum: -30, andMaximum:19),  withDuration:1.0,  mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut)
      
        radialScale.addSegment(measureTemperatureSegment)
        
        temperature.labelTitle.text = "19C"
        temperature.labelTitle.font = UIFont(name: "HelveticaNeue-Light", size:35)
        temperature.labelTitle.textColor = UIColor.whiteColor()
        
//        let needle : TKGaugeNeedle = TKGaugeNeedle()
//        radialScale.addIndicator(needle)
//        needle.setValueAnimated(50, withDuration: 1, mediaTimingFunction: kCAMediaTimingFunctionEaseInEaseOut)
//        

//        let freezing : TKGaugeSegment = TKGaugeSegment(minimum: -10, maximum: 0)
//        radialScale.addSegment(freezing)
//        
//        let liquid : TKGaugeSegment = TKGaugeSegment(minimum: 1, maximum: 99)
//        liquid.fill = TKLinearGradientFill(colors: [UIColor(red: 0.24, green: 0.52, blue: 0.78, alpha: 1.0), UIColor(red: 1.00, green: 0.85, blue: 0.40, alpha: 1.0)], locations: [0, 1], startPoint: CGPointMake(0, 0.5), endPoint: CGPointMake(1, 0.5))
//        radialScale.addSegment(liquid)
//        
//        let boiling = TKGaugeSegment(minimum: 100, maximum: 110)
//        boiling.fill = TKSolidFill(color: UIColor(red: 0.90, green: 0.57, blue: 0.22, alpha: 1.0))
//        radialScale.addSegment(boiling)
        
        
    }
    
    func humidityGauge()
    {
        humidity.delegate = self
        self.view.addSubview(humidity)
        
        let radialScale = TKGaugeRadialScale(minimum: 0, maximum: 100)
        radialScale.ticks.hidden = true
        radialScale.labels.hidden = true
        humidity.addScale(radialScale)

        let mainTemperatureSegment = TKGaugeSegment(minimum:0, maximum:100)
        mainTemperatureSegment.cap = TKGaugeSegmentCap.Round
        mainTemperatureSegment.location = 0.87
        mainTemperatureSegment.fill = TKSolidFill(color: UIColor.whiteColor().colorWithAlphaComponent(0.5))
        mainTemperatureSegment.width = 0.08
        radialScale.addSegment(mainTemperatureSegment)
        
        let measureTemperatureSegment = TKGaugeSegment()
        measureTemperatureSegment.allowTouch = true
        measureTemperatureSegment.cap = TKGaugeSegmentCap.Round
        measureTemperatureSegment.location = 0.9
        measureTemperatureSegment.width = 0.14
        measureTemperatureSegment.fill = TKLinearGradientFill(colors: [UIColor(red:0.47, green:0.53, blue:0.63, alpha:1.0), UIColor(red:0.27, green:0.64, blue:0.99, alpha:1.0)])
        measureTemperatureSegment.shadowOpacity = 0.5
        measureTemperatureSegment.shadowOffset = CGSizeMake(0, 0)
        measureTemperatureSegment.setRangeAnimated(TKRange(minimum: 0, andMaximum:58),  withDuration:1.0,  mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut)
        
        radialScale.addSegment(measureTemperatureSegment)
        
        humidity.labelTitle.text = "58%"
        humidity.labelTitle.font = UIFont(name: "HelveticaNeue-Light", size:20)
        humidity.labelTitle.textColor = UIColor.whiteColor()
    }
    
    func windGauge()
    {
        wind.delegate = self
        self.view.addSubview(wind)
        
        let radialScale = TKGaugeRadialScale(minimum: 0, maximum: 32)
        wind.addScale(radialScale)
        radialScale.ticks.hidden = true
        radialScale.labels.hidden = true
        
        let mainTemperatureSegment = TKGaugeSegment(minimum:0, maximum:32)
        mainTemperatureSegment.cap = TKGaugeSegmentCap.Round
        mainTemperatureSegment.location = 0.87
        mainTemperatureSegment.fill = TKSolidFill(color: UIColor.whiteColor().colorWithAlphaComponent(0.5))
        mainTemperatureSegment.width = 0.08
        radialScale.addSegment(mainTemperatureSegment)
        
        let measureTemperatureSegment = TKGaugeSegment()
        measureTemperatureSegment.allowTouch = true
        measureTemperatureSegment.cap = TKGaugeSegmentCap.Round
        measureTemperatureSegment.location = 0.9
        measureTemperatureSegment.width = 0.14
        measureTemperatureSegment.fill = TKLinearGradientFill(colors: [UIColor(red:0.33, green:0.31, blue:0.35, alpha:1.0), UIColor(red:0.72, green:0.00, blue:1.00, alpha:1.0)])
        measureTemperatureSegment.shadowOpacity = 0.5
        measureTemperatureSegment.shadowOffset = CGSizeMake(0, 0)
        measureTemperatureSegment.setRangeAnimated(TKRange(minimum: 0, andMaximum:5.7),  withDuration:1.0,  mediaTimingFunction:kCAMediaTimingFunctionEaseInEaseOut)
        radialScale.addSegment(measureTemperatureSegment)
        
        wind.labelTitle.text = "5.7 m/s"
        wind.labelTitle.font = UIFont(name: "HelveticaNeue-Light", size:20)
        wind.labelTitle.textColor = UIColor.whiteColor()

    }
    
    func gauge(gauge: TKGauge, valueChanged value: CGFloat, forScale scale: TKGaugeScale) {
        if (gauge == temperature) {
            temperature.labelTitle.text = "\(Int(value))˚C"
        }
        else if (gauge == humidity) {
            humidity.labelTitle.text = "\(Int(value)) %"
        } else if (gauge == wind) {
            wind.labelTitle.text = "\(Int(value)) m/s"
        }
    }
    
    //MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        temperature.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2 - 75, 20, 150, 150)
        humidity.frame = CGRectMake(10, 60, 100, 100)
        wind.frame = CGRectMake(263, 60, 100, 100)
    }

}

