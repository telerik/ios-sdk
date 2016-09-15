using System;
using Foundation;

namespace Examples
{
	// >> dataform-info-cs
	public class PersonalInfo : NSObject
	{
		[Export("Server")]
		public string Server { get; set;}

		[Export("Details")]
		public string Details { get; set;}

		[Export("Account")]
		public string Account { get; set;}

		[Export("Secure")]
		public bool Secure { get; set;}

		[Export("Password")]
		public string Password { get; set;}

		[Export("EncryptionLevel")]
		public int EncryptionLevel { get; set;}

		[Export("SendAllTraffic")]
		public bool SendAllTraffic { get; set;}

		[Export("InfoProtocol")]
		public int InfoProtocol{ get; set;}

		public PersonalInfo ()
		{
			this.InfoProtocol = 0;
			this.Details = "";
			this.Server = "";
			this.Secure = false;
			this.Password = "";
			this.EncryptionLevel = 0;
			this.Account = "";
			this.SendAllTraffic = true;
		}
	}
	// << dataform-info-cs
}

