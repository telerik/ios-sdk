//
//  AutoCompleteGettingStartedViewController.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

class AutoCompleteGettingStartedViewController: ExampleViewController{

    var autocomplete = TKAutoCompleteTextView()
    let datasource = TKDataSource(dataFromJSONResource: "countries", ofType: "json", rootItemKeyPath: "data")
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Contains") { self.containsSelected() }
        self.addOption("StartsWith") { self.prefixSelected() }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil);
        
        self.automaticallyAdjustsScrollViewInsets = false
        var title :UILabel
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad ) {
            autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.exampleBounds.origin.y + 25, width: self.exampleBounds.size.width - 20, height: 30))
             title = UILabel(frame: CGRect(x: 10, y: self.exampleBounds.origin.y, width: self.exampleBounds.size.width-20, height: 30))
        }
        else {
           autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.view.bounds.origin.y + 25, width: self.exampleBounds.size.width - 20, height: 30))
             title = UILabel(frame: CGRect(x: 10, y: self.view.bounds.origin.y, width: self.exampleBounds.size.width-20, height: 30))
           
            self.navigationController!.navigationBar.translucent = false
        }

        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
         self.automaticallyAdjustsScrollViewInsets = false
        title.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        title.text = "Shipping Country:"
        self.view.addSubview(title)
        
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
        autocomplete.suggestionViewHeight = self.exampleBounds.size.height - self.exampleBounds.origin.y + 45
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
    }
    
    func containsSelected()
    {
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.Contains;
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
