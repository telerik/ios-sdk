//
//  ListViewDynamicSizeCell.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewDynamicSizeCell: TKListViewCell {

    var label: UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel(frame: CGRect.zero)
        label!.translatesAutoresizingMaskIntoConstraints = false
        label!.numberOfLines = 0
        self.addSubview(label!)
        
        let views = [ "v": label! ]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[v]-10-|", options:NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v]-10-|", options:NSLayoutFormatOptions(rawValue:0), metrics: nil, views: views))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.label!.preferredMaxLayoutWidth = self.bounds.size.width-20
        super.layoutSubviews()
    }
}