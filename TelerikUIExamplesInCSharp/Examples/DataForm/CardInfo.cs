using System;
using Foundation;

namespace Examples
{
	public class CardInfo : NSObject
	{
		[Export("FirstName")]
		public string FirstName { get; set;}

		[Export("LastName")]
		public string LastName{ get; set;}

		[Export("CardNumber")]
		public string CardNumber{ get; set;}

		[Export("ZipCode")]
		public string ZipCode { get; set;}

		[Export("ExpirationDate")]
		public NSDate ExpirationDate { get; set;}

		[Export("Edit")]
		public bool Edit { get; set;}

		public CardInfo ()
		{
			this.Edit = false;
			this.FirstName = "";
			this.LastName = "";
			this.CardNumber = "";
			this.ZipCode = "";
			this.ExpirationDate = new NSDate ();
		}
	}
}

