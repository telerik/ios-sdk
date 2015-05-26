//
//  CustomListCell.swift
//  TelerikUIExamplesInSwift
//
//  Created by Tsvetan Raikov on 5/20/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CustomListCell: TKListViewCell {

    let gradient = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        
        self.textLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.textLabel.font = UIFont(name:"HelveticaNeue-Italic", size:13)
        
        self.detailTextLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        self.detailTextLabel.font = UIFont(name:"HelveticaNeue-Medium", size:11)
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.gradient.colors = [UIColor.clearColor().CGColor, UIColor(red: 1, green: 1, blue: 1, alpha: 0.8).CGColor]
        self.gradient.locations = [0.0, 0.7]
        self.imageView.layer.insertSublayer(self.gradient, atIndex:0)
        
        (self.backgroundView as! TKView).stroke.width = 0
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.textLabel.frame = CGRectMake(14, CGRectGetHeight(self.frame) - 10 - 35, CGRectGetWidth(self.frame) - 28, 20)
        self.detailTextLabel.frame = CGRectMake(14, CGRectGetHeight(self.frame) - 15 - 10, CGRectGetWidth(self.frame) - 28, 15)
        
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.gradient.frame = CGRectMake(-2, CGRectGetHeight(self.frame)/2,
            CGRectGetWidth(self.frame) + 2,
            CGRectGetHeight(self.frame) - CGRectGetHeight(self.frame)/2)
        CATransaction.commit()
        
        self.imageView.frame = self.bounds
    }
}
