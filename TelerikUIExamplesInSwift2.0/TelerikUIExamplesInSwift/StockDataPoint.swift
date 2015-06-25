//
//  StockDataPoint.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StockDataPoint: TKChartFinancialDataPoint/*, NSCoding*/ {
    
    class func stockPoints() -> NSArray {
        let dataPoints = NSMutableArray()
        let filePath = NSBundle.mainBundle().pathForResource("AppleStockPrices", ofType: "json")
        let json = NSData(contentsOfFile: filePath!)!
        do {
            let data = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            for jsonPoint in data {
                let datapoint = StockDataPoint()
                datapoint.dataXValue = formatter.dateFromString(jsonPoint["date"] as! String)
                datapoint.setOpen(jsonPoint["open"] as! NSNumber)
                datapoint.setHigh(jsonPoint["high"] as! NSNumber)
                datapoint.setLow(jsonPoint["low"] as! NSNumber)
                datapoint.setClose(jsonPoint["close"] as! NSNumber)
                datapoint.setVolume(jsonPoint["volume"] as! NSNumber)
                dataPoints.addObject(datapoint)
            }
        }
        catch {
            
        }
        
        return dataPoints
    }
}
