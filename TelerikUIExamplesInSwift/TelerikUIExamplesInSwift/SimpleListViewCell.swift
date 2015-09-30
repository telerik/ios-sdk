//
//  SampleListViewCell.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class SimpleListViewCell: TKListViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.textLabel.font = UIFont.systemFontOfSize(12)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        let desiredSize = self.textLabel.sizeThatFits(self.bounds.size)
        self.textLabel.frame = CGRectMake(1, self.bounds.size.height - desiredSize.height - 6, self.bounds.size.width - 2, desiredSize.height - 2)
        self.imageView.frame = CGRectMake((self.bounds.size.width - 100)/2.0, 5, 100, self.bounds.size.height - (self.textLabel.bounds.size.height + 17));
    }
}
