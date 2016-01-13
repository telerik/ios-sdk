//
//  AutoCompleteCustomization.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class AutoCompleteCustomization: TKAutoCompleteController, TKAutoCompleteDelegate {

    
    let datasource = TKDataSource(dataFromJSONResource: "namesPhotos", ofType: "json", rootItemKeyPath: "data")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil);
        
        autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.view.bounds.origin.y + 20, width: self.view.bounds.size.width - 20, height: 44));
        
        self.automaticallyAdjustsScrollViewInsets = false;
        let view = TKView(frame: self.view.bounds)
        view.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        view.fill = TKLinearGradientFill(colors: [UIColor(red: 0.35, green: 0.68, blue: 0.89, alpha: 0.89),
            UIColor(red: 0.35, green: 0.68, blue: 1.00, alpha: 1.00),
            UIColor(red: 0.85, green: 0.80, blue: 0.20, alpha: 0.80)])
        self.view.addSubview(view)
        
        datasource.settings.autocomplete.createToken { (dataIndex, item) -> TKAutoCompleteToken? in
            let token = TKAutoCompleteToken(text: item.valueForKey("name") as? String)
            token.image = UIImage(named: (item.valueForKey("photo") as? String)!)
            return token
        }
        
          autocomplete.suggestionViewOutOfFrame = true
        let listView = autocomplete.suggestionView as! TKListView
        let layout = TKListViewGridLayout()
        layout.itemAlignment = TKListViewItemAlignment.Center
        layout.spanCount = 2
        layout.itemSize = CGSizeMake(150, 200)
        layout.lineSpacing = 60
        layout.itemSpacing = 10
        listView.backgroundColor = UIColor.clearColor()
        listView.layout = layout
        listView.frame = CGRect(x: 10, y: self.view.bounds.origin.y + 70, width: self.view.bounds.size.width - 20, height:self.view.bounds.size.height - (20 + autocomplete.bounds.size.height + self.view.bounds.origin.y))
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.removeFromSuperview()
        self.view.addSubview(listView)
        
        listView.registerClass(ImageWithTextListViewCell.self, forCellWithReuseIdentifier: "cell")
        
        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        autocomplete.dataSource = datasource
        autocomplete.textField.placeholder = "Enter User"
        autocomplete.noResultsLabel.text = "No Users Found";
        let btnImage = UIImage(named: "clear")
        autocomplete.closeButton.setImage(btnImage, forState: UIControlState.Normal)
        autocomplete.imageView.image = UIImage(named: "search")
        autocomplete.showAllItemsInitially = true
        autocomplete.delegate = self
        autocomplete.backgroundColor = UIColor.whiteColor()
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.SuggestAppend
    }
    
    func autoComplete(autocomplete: TKAutoCompleteTextView, viewForToken token: TKAutoCompleteToken) -> TKAutoCompleteTokenView
    {
        let tokenView = TKAutoCompleteTokenView(token: token)
        tokenView.backgroundColor = UIColor.lightGrayColor()
        tokenView.layer.cornerRadius = 10
        tokenView.imageView.layer.cornerRadius = 3
        return tokenView
    }
    
    func autoComplete(autocomplete: TKAutoCompleteTextView, didAddToken token: TKAutoCompleteToken) {
        (autocomplete.suggestionView as! TKListView).scrollToItemAtIndexPath((autocomplete.suggestionView as! TKSuggestionListView).selectedIndexPath!, atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
    }
    
    func keyboardDidShow(notification: NSNotification)
    {
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        autocomplete.suggestionViewHeight = self.view.bounds.size.height -  keyboardSize!.height - 75
        
    }
    
    func keyboardDidHide(notification: NSNotification)
    {
        autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;
        
    }
}