//
//  PersonListViewCell.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class PersonListViewCell: TKAutoCompleteSuggestionCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00)
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.textLabel.font = UIFont(name:"HelveticaNeue-Italic", size:16)
        self.textLabel.layer.cornerRadius = 10
        self.textLabel.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.frame = CGRectMake(0 , 10, 120, 100);
        self.textLabel.frame = CGRectMake(0, self.imageView.frame.size.height, self.frame.size.width, 60);
    }
}
