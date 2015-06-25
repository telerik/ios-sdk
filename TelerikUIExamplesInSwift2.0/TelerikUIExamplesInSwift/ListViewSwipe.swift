//
//  ListViewSwipe.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewSwipe: ExampleViewController, TKListViewDelegate {

    let listView = TKListView()
    let dataSource = TKDataSource()
    var buttonAnimationEnabled = true
    let loremIpsum = LoremIpsumGenerator()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("YES", inSection:"Animate buttons") { self.enableButtonAnimation() }
        self.addOption("NO", inSection:"Animate buttons") { self.disableButtonAnimation() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mails : [String: String] = [
        "Joyce Dean": "Sales report for January",
        "Joel Robertson": "Planned network mainternance",
        "Sherman Martin": "IT help desk",
        "Lela Richardson": "Summaries of my interviews with customers",
        "Jackie Maldonado": "REMAINDER: corporate meeting",
        "Kathryn Byrd": "Stock options",
        "Ervin Powers": "Thank you!",
        "Leland Warner": "Meeting with Jack",
        "Nicholas Bowers": "Please share these articles",
        "Alex Soto": "Additional information for Jack",
        "Naomi Carson": "Miss you!",
        "Rufus Edwards": "Training",
        "Ian Ellis": "Do you like this blog article?",
        "Pat Vasquez": "The latest UI design",
        "Chelsea Burton": "Need this article!",
        "Karl Bates": "Training update",
        "Evan Rivera": "Safety instructions",
        "Tony Lawson": "Missed our converstation",
        "Wallace Little": "Swift is awessome",
        "Carrie Tran": "Missed conference call with Jack",
        "Tyler Washington": "HR question",
        "Dominick Holloway": "Wellcome!",
        "Clark Sharp": "Important question!"]

        dataSource.itemSource = mails
        dataSource.settings.listView.createCell { (listView: TKListView!, indexPath: NSIndexPath!, item: AnyObject!) -> TKListViewCell! in
            let cell = listView.dequeueReusableCellWithReuseIdentifier("defaultCell", forIndexPath: indexPath) as! TKListViewCell
            
            if(cell.swipeBackgroundView.subviews.count == 0){
                let size = cell.frame.size
                let font = UIFont.systemFontOfSize(14)
                
                let bMore = UIButton()
                bMore.frame = CGRectMake(size.width - 180, 0, 60, size.height)
                bMore.setTitle("More", forState: UIControlState.Normal)
                bMore.backgroundColor = UIColor.lightGrayColor()
                bMore.titleLabel?.font = font
                bMore.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
                cell.swipeBackgroundView.addSubview(bMore)
                
                let bFlag = UIButton()
                bFlag.frame = CGRectMake(size.width - 120, 0, 60, size.height)
                bFlag.setTitle("Flag", forState: UIControlState.Normal)
                bFlag.backgroundColor = UIColor.orangeColor()
                bFlag.titleLabel?.font = font
                bFlag.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
                cell.swipeBackgroundView.addSubview(bFlag)
                
                let bTrash = UIButton()
                bTrash.frame = CGRectMake(size.width - 60, 0, 60, size.height)
                bTrash.setTitle("Trash", forState: UIControlState.Normal)
                bTrash.backgroundColor = UIColor.redColor()
                bTrash.titleLabel?.font = font
                bTrash.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
                cell.swipeBackgroundView.addSubview(bTrash)

                let bUnread = UIButton()
                bUnread.frame = CGRectMake(0, 0, 60, size.height)
                bUnread.setTitle("Mark as unread", forState: UIControlState.Normal)
                bUnread.backgroundColor = UIColor.blueColor()
                bUnread.titleLabel?.font = font
                bUnread.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
                bUnread.titleLabel?.textAlignment = NSTextAlignment.Center
                bUnread.addTarget(self, action: "buttonTouched", forControlEvents: UIControlEvents.TouchUpInside)
                cell.swipeBackgroundView.addSubview(bUnread)
                
            }
            return cell
        }
        
        dataSource.settings.listView.initCell { (listView: TKListView!, indexPath: NSIndexPath!, cell: TKListViewCell!, item: AnyObject!) -> Void in
            cell.textLabel.text = item as? String
            let dict = self.dataSource.itemSource as! NSDictionary
            let attributedString : NSAttributedString = self.attributedMailText(dict[item as! String!] as! NSString) as NSAttributedString
            cell.detailTextLabel.attributedText = attributedString
            cell.contentInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        }
        
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.delegate = self
        listView.dataSource = self.dataSource
        listView.allowsCellSwipe = true
        listView.cellSwipeLimits = UIEdgeInsetsMake(0, 60, 0, 180)//how far the cell may swipe
        listView.cellSwipeTreshold = 30 // the treshold after which the cell will autoswipe to the end and will not jump back to the center.
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemSize = CGSizeMake(100, 80)
        self.view.addSubview(listView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func attributedMailText(text: NSString) -> NSAttributedString {
        let randomStr = loremIpsum.generateString(10 + Int(arc4random()%15))
        let str = "\(text)\n\(randomStr)"
        let attrStr = NSMutableAttributedString(string: str, attributes: [String : AnyObject]())
        let range : NSRange = (str as NSString).rangeOfString("\n")
        attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(range.location, (str as NSString).length - range.location))
        return attrStr
    }
    
    func buttonTouched() {
        listView.endSwipe(true)
    }
    
    func enableButtonAnimation() {
        self.buttonAnimationEnabled = true
        listView.reloadData()
    }
    
    func disableButtonAnimation() {
        self.buttonAnimationEnabled = false
        listView.reloadData()
    }
    
    func animateButtonsInCell(cell: TKListViewCell, offset: CGPoint) {
        if(offset.x > 0){
         return
        }
        
        let bMore = cell.swipeBackgroundView.subviews[0] as! UIButton
        let bFlag = cell.swipeBackgroundView.subviews[1] as! UIButton
        let bTrash = cell.swipeBackgroundView.subviews[2] as! UIButton
        
        let size = cell.frame.size
        
        if(buttonAnimationEnabled){
            let x = CGFloat(Float(size.width) - fabsf(Float(offset.x)))
            let delta = CGFloat(fabsf(Float(offset.x)) / Float(self.listView.cellSwipeLimits.right))
            bTrash.frame = CGRectMake(x + 20 + 100*delta, 0, 60, size.height)
            bFlag.frame = CGRectMake(x + 10 + 50*delta, 0, 60, size.height)
            bMore.frame = CGRectMake(x, 0, 60, size.height);
        }
        else {
            bMore.frame = CGRectMake(size.width - 180, 0, 60, size.height)
            bFlag.frame = CGRectMake(size.width - 120, 0, 60, size.height)
            bTrash.frame = CGRectMake(size.width - 60, 0, 60, size.height)
        }
    }

// MARK: - TKListViewDelegate
    
    func listView(listView: TKListView!, didSwipeCell cell: TKListViewCell!, atIndexPath indexPath: NSIndexPath!, withOffset offset: CGPoint) {
        animateButtonsInCell(cell, offset: offset)
    }
    
    func listView(listView: TKListView!, didFinishSwipeCell cell: TKListViewCell!, atIndexPath indexPath: NSIndexPath!, withOffset offset: CGPoint) {
        print("Swiped cell at indexPath: %d", indexPath.row)
    }
}
