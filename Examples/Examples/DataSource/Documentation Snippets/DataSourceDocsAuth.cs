using System;
using TelerikUI;
using Foundation;

namespace Examples
{
	// >> remote-auth-cs
	public class DataSourceDocsAuth : TKDataSource
	{
		public DataSourceDocsAuth ()
		{
		}
		public class MyDataSource: TKDataSource
		{
			[Export ("connection:didReceiveAuthenticationChallenge:")]
			public void ReceivedAuthenticationChallenge (NSUrlConnection connection, NSUrlAuthenticationChallenge challenge) 
			{
				if (challenge.PreviousFailureCount == 0) {
					var credential = new NSUrlCredential ("USER", "PASSWORD", NSUrlCredentialPersistence.ForSession);
					challenge.Sender.UseCredential (credential, challenge);
				}
				else {
					Console.WriteLine("previous authentication failure");
				}
			}
		}
	}
	// << remote-auth-cs
}

