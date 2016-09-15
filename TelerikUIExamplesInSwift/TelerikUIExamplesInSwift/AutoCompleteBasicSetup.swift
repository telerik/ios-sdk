//
//  AutoCompleteBasicSetup.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class AutoCompleteBasicSetup: UIViewController {

    var autocomplete = TKAutoCompleteTextView()
    // >> autocmp-feed-swift
    let sampleArrayOfStrings = ["Kristina Wolfe","Freda Curtis","Jeffery Francis","Eva Lawson","Emmett Santos", "Theresa Bryan", "Jenny Fuller", "Terrell Norris", "Eric Wheeler", "Julius Clayton", "Alfredo Thornton", "Roberto Romero","Orlando Mathis","Eduardo Thomas","Harry Douglas"]
    // << autocmp-feed-swift
    
    // >> autocmp-src-swift
    let datasource = TKDataSource()
    // << autocmp-src-swift
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // >> autocmp-src-swift
        datasource.itemSource = sampleArrayOfStrings
        // << autocmp-src-swift
        
        // >> autocmp-init-swift
        self.automaticallyAdjustsScrollViewInsets = false
        autocomplete = TKAutoCompleteTextView(frame: CGRect(x: 10, y: self.view.bounds.origin.y + 25, width: self.view.bounds.size.width - 20, height: 44))
        autocomplete.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1.0)
        self.view.addSubview(autocomplete)
        // << autocmp-init-swift
        
        // >> autocmp-src-swift
        datasource.settings.autocomplete.createToken { (dataIndex, item) -> TKAutoCompleteToken? in
            let token = TKAutoCompleteToken(text: item as? String)
            return token
        }
        // << autocmp-src-swift
        
        // >> autocmp-completion-swift
        datasource.settings.autocomplete.completionMode = TKAutoCompleteCompletionMode.StartsWith
        // << autocmp-completion-swift
        
        // >> autocmp-suggestmode-swift
        autocomplete.suggestMode = TKAutoCompleteSuggestMode.SuggestAppend
        // << autocmp-suggestmode-swift
        
        autocomplete.dataSource = datasource
        autocomplete.textField.placeholder = "Type a name"
        
        // >> autocmp-char-swift
        autocomplete.minimumCharactersToSearch = 1
        autocomplete.suggestionViewHeight = self.view.bounds.size.height/4
        // << autocmp-char-swift
       
    }
}
