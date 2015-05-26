//
//  AnimationListCell.swift
//  TelerikUIExamplesInSwift
//
//  Created by Tsvetan Raikov on 5/25/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class AnimationListCell: TKListViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        let view = self.backgroundView as! TKView
        view.stroke = TKStroke(color:UIColor(white:0.9, alpha:0.9), width:0.5)
        
        self.contentView.layer.masksToBounds = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = CGRectInset(self.contentView.frame, 1, 1)
    }
}