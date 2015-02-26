//
//  DSCollectionViewCell.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DSCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {

        super.init(frame: frame)

        let width = frame.size.width - 60
        let height = frame.size.height - 30
        let size = width < height ? width : height
        imageView.frame = CGRectMake((frame.size.width - size)/2.0, 0, size, size)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = size/2.0
        self.addSubview(imageView)
        
        label.frame = CGRectMake(0, frame.size.height - 30, frame.size.width, 30)
        label.font = UIFont.systemFontOfSize(20)
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
