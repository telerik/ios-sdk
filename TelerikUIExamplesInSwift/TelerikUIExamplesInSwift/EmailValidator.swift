//
//  EmailValidator.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//


class EmailValidator: NSObject, TKDataFormValidator {

    var emptyField: Bool?
    var incorrectFormat: Bool?
    
     func validateProperty(property: TKDataFormEntityProperty!) -> Bool {
        emptyField = false
        incorrectFormat = false
        var email: NSString! = property.value() as! NSString
        if(email == nil || email.length == 0){
            emptyField = true
            return false
        }
        
        var emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        var emailPredicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        incorrectFormat = !emailPredicate.evaluateWithObject(email)
        if((incorrectFormat) == true){
            return false
        }
        
        return true
    }
    
     func validationMessage() -> String! {
        if(emptyField == true){
            return "Email is required!"
        }
        
        if(incorrectFormat == true){
            return "Incorrect email!"
        }
        
        return nil
    }
}
