//
//  AutoCompleteGetting.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class AutoCompleteGettingStarted: TKExamplesExampleViewController{

    var autocomplete = TKAutoCompleteTextView()
    let datasource = TKDataSource(dataFromJSONResource: "countries", ofType: "json", rootItemKeyPath: "data")
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Contains",inSection: "Completion Modes", withAction: containsSelected)
        self.addOption("StartsWith",inSection: "Completion Modes", withAction: prefixSelected)
        self.addOption("Append", inSection: "Suggest Modes", withAction: appendSelected)
        self.addOption("Suggest-Append", inSection: "Suggest Modes", withAction: suggestAppendSelected)
        self.addOption("Suggest", inSection: "Suggest Modes", withAction: suggestSelected)
        
        self.setSelectedOption(2, inSection: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil);
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad ) {
            autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.view.bounds.origin.y + 25, width: self.view.bounds.size.width - 20, height: 44))
        }
        else {
           autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.view.bounds.origin.y + 25, width: self.view.bounds.size.width - 20, height: 44))
        }

        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1.0)
         self.automaticallyAdjustsScrollViewInsets = false
        
        datasource.settings.autocomplete.createToken { (dataIndex, item) -> TKAutoCompleteToken? in
            let token = TKAutoCompleteToken(text: item.valueForKey("country") as? String)
            token.image = UIImage(named: (item.valueForKey("flag") as? String)!)
            return token
        }
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.Contains
        autocomplete.dataSource = datasource
        autocomplete.textField.placeholder = "Choose country"
        let btnImage = UIImage(named: "clear")
        autocomplete.closeButton.setImage(btnImage, forState: UIControlState.Normal)
        autocomplete.imageView.image = UIImage(named: "search")
        autocomplete.minimumCharactersToSearch = 1
        autocomplete.suggestionViewHeight = self.view.bounds.size.height - self.view.bounds.origin.y + 45
        self.view.addSubview(autocomplete)
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        if (parent == nil) {
             self.navigationController!.navigationBar.translucent = true
        }
        
        parent?.willMoveToParentViewController(parent)
    }
    
    func prefixSelected()
    {
         datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.StartsWith;
        autocomplete.resetAutocomplete()
    }
    
    func containsSelected()
    {
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.Contains;
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.Suggest
        self.setSelectedOption(2, inSection: 1)
        autocomplete.resetAutocomplete()
    }
    
    func suggestSelected()
    {
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.Suggest
        autocomplete.resetAutocomplete()
    }
    
    func appendSelected()
    {
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.Append
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.StartsWith;
        self.setSelectedOption(1, inSection: 0)
        autocomplete.resetAutocomplete()
    }
    
    func suggestAppendSelected()
    {
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.SuggestAppend
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.StartsWith;
        self.setSelectedOption(1, inSection: 0)
        autocomplete.resetAutocomplete()
    }
    
    func keyboardDidShow(notification: NSNotification)
    {        
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()
        autocomplete.suggestionViewHeight = self.view.bounds.size.height -  keyboardSize!.height - 80
        
    }
    
    func keyboardDidHide(notification: NSNotification)
    {
        autocomplete.suggestionViewHeight = self.view.bounds.size.height - 100;

    }
}
