//
//  AutoCompleteRemote.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class AutoCompleteLoadData: TKAutoCompleteController, TKAutoCompleteDataSource
{
    let urlStr = "http://www.telerik.com/docs/default-source/ui-for-ios/airports.json?sfvrsn=2"
    var airports = NSArray()
    
    override func viewDidLoad()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);

        autocomplete = TKAutoCompleteTextView(frame:CGRect(x: 10, y: 20, width: self.view.bounds.size.width-20, height: 44))
        self.automaticallyAdjustsScrollViewInsets = false

        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1.0)

        self.autocomplete.suggestMode = TKAutoCompleteSuggestMode.Suggest
        autocomplete.dataSource = self
        let btnImage = UIImage(named: "clear")
        autocomplete.closeButton.setImage(btnImage, forState: UIControlState.Normal)
        autocomplete.imageView.image = UIImage(named: "search")
         autocomplete.minimumCharactersToSearch = 1
        autocomplete.suggestionViewHeight = self.view.bounds.size.height - self.view.bounds.origin.y + 45;
       
    }
    
    func autoComplete(autocomplete: TKAutoCompleteTextView, completionsForString input: String)
    {
        let suggestions = NSMutableArray()
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            if(self.airports.count == 0) {
            let url = NSURL(string: self.urlStr)
            let req = NSURLRequest(URL: url!)
            let response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
            var dataVal :NSData = NSData()
            var jsonResult:NSDictionary = NSDictionary()
            do {
                dataVal =  try NSURLConnection.sendSynchronousRequest(req, returningResponse: response)
            }
            catch {
                print(error)
            }
            
            do {
                jsonResult = try NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            }
            catch {
                print(error)
            }
                
            self.airports = jsonResult.objectForKey("airports") as! NSArray
        }

            for airport in self.airports {
                
                let dict = airport as! NSDictionary
                let name = dict.objectForKey("FIELD2") as! NSString
                let shortName = dict.objectForKey("FIELD5") as! NSString
                let current = NSString(format: "%@, %@",name, shortName)
                
                if(current.uppercaseString.hasPrefix(input.uppercaseString)){
                    suggestions.addObject(TKAutoCompleteToken(text: current as String))
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), { () -> Void in
                autocomplete.completeSuggestionViewPopulation(suggestions as [AnyObject])
            })
        }
    }
    
    func keyboardDidShow(notification: NSNotification)
    {
      let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
      autocomplete.suggestionViewHeight = self.view.bounds.size.height -  keyboardSize!.height - 100
    }
}

