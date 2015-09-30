//
//  ToastExample.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 6/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class ToastExample: ExampleViewController, TKListViewDataSource, TKListViewDelegate  {

    var _listView: TKListView?
    var _types = ["Error", "Warning", "Positive", "Info"]
    var _titles = ["Oh no!", "Warning!", "Well done!", "Info."]
    var _messages = ["Change this and try again!", "Be careful next time", "You successfully read this message", "This is TKAlert dialog"]
    var _colors = [UIColor(red:1, green:0, blue:0.282, alpha:1),
                   UIColor(red:1, green:0.733, blue:0, alpha:1),
                   UIColor(red:0.478, green:0.988, blue:0.157, alpha:1),
                   UIColor(red:0.231, green:0.678, blue:1, alpha:1)]
    var _alert: TKAlert?
    var _tap: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        
        _listView = TKListView(frame: self.view.frame)
        _listView?.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        _listView?.dataSource = self
        _listView?.delegate = self
        self.view.addSubview(_listView!)
        _listView?.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        
        _tap = UITapGestureRecognizer(target: self, action: "tapped:")
        
        _alert = TKAlert()
        _alert?.style.separatorWidth = 0
        _alert?.style.titleColor = UIColor.whiteColor()
        _alert?.style.messageColor = UIColor.whiteColor()
        _alert?.customFrame = CGRectMake(0, 100, self.view.frame.size.width, 160)
        _alert?.style.cornerRadius = 5
        _alert?.style.appearAnimation = TKAlertAnimation.SlideFromTop
        _alert?.style.hideAnimation = TKAlertAnimation.SlideFromTop
        _alert?.contentView.addGestureRecognizer(_tap!)
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell! {
        
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        cell.textLabel!.text = _types[indexPath.row]
        return cell
    }
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int {
         return _types.count;
    }
    
    func listView(listView: TKListView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: _titles[indexPath.row])
        attributedText.setAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(18)], range: NSMakeRange(0, (_titles[indexPath.row] as NSString).length))
        _alert?.attributedTitle = attributedText
        _alert?.message = _messages[indexPath.row]
        _alert?.contentView.fill = TKSolidFill(color: _colors[indexPath.row])
        _alert?.headerView.fill = TKSolidFill(color: _colors[indexPath.row].colorWithAlphaComponent(0.9))
        _alert?.show(true)
    }

    func tapped(sender: UITapGestureRecognizer){
        _alert?.dismiss(true)
    }
}

//@implementation ToastExample

//-(TKListViewCell *)listView:(TKListView *)listView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    TKListViewCell* cell = [listView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = _types[indexPath.row];
//    return cell;
//}
//
//-(NSInteger)listView:(TKListView *)listView numberOfItemsInSection:(NSInteger)section
//{
//    return _types.count;
//}
//
//-(void)listView:(TKListView *)listView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_titles[indexPath.row]];
//    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} range: NSMakeRange(0, ((NSString*)_titles[indexPath.row]).length)];
//    _alert.attributedTitle = attributedText;
//    _alert.message = _messages[indexPath.row];
//    _alert.contentView.fill = [TKSolidFill solidFillWithColor:_colors[indexPath.row]];
//    _alert.headerView.fill = [TKSolidFill solidFillWithColor:[_colors[indexPath.row] colorWithAlphaComponent:0.9]];
//    [_alert show];
//    }
//    
//    - (void)didReceiveMemoryWarning {
//        [super didReceiveMemoryWarning];
//        // Dispose of any resources that can be recreated.
//}
//
//-(void)tapped:(UITapGestureRecognizer*)sender
//{
//    [_alert dismiss];
//}
