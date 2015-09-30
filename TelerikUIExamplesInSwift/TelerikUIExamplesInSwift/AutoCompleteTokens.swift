//
//  AutoCompleteTokens.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class AutoCompleteTokens: ExampleViewController, TKAutoCompleteDelegate {

    var autocomplete = TKAutoCompleteTextView()
    let datasource = TKDataSource(dataFromJSONResource: "namesPhotos", ofType: "json", rootItemKeyPath: "data")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil);
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: 70, width: self.exampleBounds.size.width-20, height: 30));
        
        datasource.settings.autocomplete.createToken { (dataIndex, item) -> TKAutoCompleteToken? in
            let token = TKAutoCompleteToken(text: item.valueForKey("name") as? String)
            token.image = UIImage(named: (item.valueForKey("photo") as? String)!)
            return token
        }
        
        let listView = autocomplete.suggestionView as! TKListView
        let layout = TKListViewGridLayout()
        layout.itemAlignment = TKListViewItemAlignment.Center
        layout.spanCount = 2
        layout.itemSize = CGSizeMake(120, 150)
        layout.lineSpacing = 20
        layout.itemSpacing = 20
        listView.layout = layout
        
        listView.registerClass(PersonListViewCell.self, forCellWithReuseIdentifier: "cell")
        
        autocomplete.dataSource = datasource
        autocomplete.textField.placeholder = "Enter Users"
        autocomplete.noResultsLabel.text = "No Users Found"
        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        autocomplete.imageView.image = UIImage(named: "search")
        autocomplete.suggestionViewHeight = self.exampleBounds.size.height - self.exampleBounds.origin.y + 45
        autocomplete.delegate = self
        autocomplete.backgroundColor = UIColor.whiteColor()
        autocomplete.displayMode = TKAutoCompleteDisplayMode.Tokens
        autocomplete.layoutMode = TKAutoCompleteLayoutMode.Wrap
        autocomplete.minimumCharactersToSearch = 1
        
        self.view.addSubview(autocomplete)
    }
    
    func autoComplete(autocomplete: TKAutoCompleteTextView, viewForToken token: TKAutoCompleteToken) -> TKAutoCompleteTokenView
    {
        let tokenView = TKAutoCompleteTokenView(token: token)
        tokenView.backgroundColor = UIColor.lightGrayColor()
        tokenView.layer.cornerRadius = 10
        tokenView.imageView.layer.cornerRadius = 3
        return tokenView
    }
    
    func keyboardDidShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            autocomplete.suggestionViewHeight = self.exampleBounds.size.height -  keyboardSize.height - 10
        }
    }
    
    func keyboardDidHide(notification: NSNotification)
    {
        autocomplete.suggestionViewHeight = self.exampleBounds.size.height - 100;
        
    }
}
