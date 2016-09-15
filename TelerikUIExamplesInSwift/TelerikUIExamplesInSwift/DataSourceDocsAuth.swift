//
//  DataSourceDocsAuth.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> remote-auth-swift
class DataSourceDocsAuth: TKDataSource {

    class MyDataSource: TKDataSource {
        
        override func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
            if challenge.previousFailureCount == 0 {
                let credential = NSURLCredential(user: "USER", password: "PASSWORD", persistence: NSURLCredentialPersistence.ForSession)
                challenge.sender?.useCredential(credential, forAuthenticationChallenge: challenge)
            }
            else {
                print("previous authentication failure")
            }
        }
    }
}
// << remote-auth-swift
