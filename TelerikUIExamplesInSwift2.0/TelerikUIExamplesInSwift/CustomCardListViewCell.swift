//
//  CustomCardListViewCell.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class CustomCardListViewCell: TKListViewCell {
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        let width = self.frame.size.height-20
        self.imageView.frame = CGRectMake(0, 10, width, width)
        
        var desiredSize = self.textLabel.sizeThatFits(self.bounds.size)
        let x = self.imageView.frame.origin.x + self.imageView.bounds.size.width + 10
        self.textLabel.frame = CGRectMake(x, 10, desiredSize.width, desiredSize.height)
        
        let height = self.contentView.bounds.size.height - self.textLabel.frame.size.height - 30
        desiredSize = self.detailTextLabel.sizeThatFits(CGSizeMake(self.contentView.bounds.size.width - x - 10, height))
        self.detailTextLabel.frame = CGRectMake(x, 10 + self.textLabel.frame.origin.y + self.textLabel.frame.size.height,
        self.contentView.bounds.size.width - x - 10, min(desiredSize.height, height));
    }
}
