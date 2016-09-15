//
//  DataSourceDocsAuth.m
//  TelerikUIExamples
//
//  Copyright © 2016 Telerik. All rights reserved.
//

#import "DataSourceDocsAuth.h"

// >> remote-auth
@implementation DataSourceDocsAuth


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"USER" password:@"PASSWORD" persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    }
    else {
        NSLog(@"previous authentication failure");
    }
}

@end
// << remote-auth
