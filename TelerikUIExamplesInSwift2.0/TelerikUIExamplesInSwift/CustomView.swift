//
//  CustomView.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 6/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class CustomView: ExampleViewController {

    var _alert: TKAlert?
    var _calendar: TKCalendar?
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.whiteColor()
        _alert = TKAlert()
        _alert!.customFrame = CGRectMake((self.view.frame.size.width - 300)/2, 100, 300, 380)
        _alert!.title = "Calendar"
        _calendar = TKCalendar(frame: CGRectMake(0, 0, 300, 292))
        _alert!.contentView.addSubview(_calendar!)
//        _alert!.addAction(TKAlertAction(title: "Close", color: UIColor.whiteColor(), handler:{}, close: false))
        
        let button: UIButton = UIButton(type:UIButtonType.System)
        button.addTarget(self, action: "show:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("Show Alert", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 0.7)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "GillSans", size: 18)
        button.frame = CGRectMake((self.view.frame.size.width - 160)/2, 450.0, 160.0, 80.0)
        button.layer.cornerRadius = 80
        button.clipsToBounds = true
        self.view.addSubview(button)
    }
    
    func show(sender: AnyObject) {
        self._alert!.show(true)
    }
}

//@implementation CustomView
//{
//    TKAlert *_alert;
//    TKCalendar *_calendar;
//    }
//    
//    - (void)viewDidLoad {
//        [super viewDidLoad];
//        
//        _alert = [[TKAlert alloc] init];
//        _alert.delegate = self;
//        _alert.customFrame = CGRectMake((self.view.frame.size.width - 300)/2, 100, 300, 380);
//        _alert.title = @"Calendar";
//        _calendar = [[TKCalendar alloc] initWithFrame:CGRectMake(0, 0, 300, 292)];
//        [_alert.contentView addSubview:_calendar];
//        [_alert addAction:[[TKAlertAction alloc] initWithTitle:@"Close" color:[UIColor whiteColor] handler:^{
//        NSLog(@"Calendar closed");
//        }]];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button addTarget:self
//        action:@selector(show:)
//        forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:@"Show Alert" forState:UIControlStateNormal];
//        [button setBackgroundColor:[UIColor colorWithRed:0.5 green:0.7 blue:0.2 alpha:0.7]];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont fontWithName:@"GillSans" size:18];
//        button.frame = CGRectMake((self.view.frame.size.width - 160)/2, 450.0, 160.0, 80.0);
//        button.layer.cornerRadius = 80;
//        button.clipsToBounds = YES;
//        [self.view addSubview:button];
//        
//}
//
//-(void)show:(id)sender
//{
//    [_alert show];
//    }
//    
//    - (void)didReceiveMemoryWarning {
//        [super didReceiveMemoryWarning];
//}
