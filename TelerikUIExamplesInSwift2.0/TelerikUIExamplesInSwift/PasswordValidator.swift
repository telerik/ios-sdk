//
//  PasswordValidator.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//



class PasswordValidator: NSObject, TKDataFormValidator {

    var shortPassword: Bool?

    func validateProperty(property: TKDataFormEntityProperty!) -> Bool {
                shortPassword = false
                let password = property.value() as! NSString
                if(password.length < 6){
                    shortPassword = true
                    return false
                }
                
                return true
    }
    
    func validationMessage() -> String! {
                if(shortPassword == true){
                    return "Password must be at least 6 characters"
                }
        
                return nil
            }
    }

