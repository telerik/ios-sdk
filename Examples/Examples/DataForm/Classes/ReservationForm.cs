using System;
using Foundation;

namespace Examples
{
	public class ReservationForm : NSObject
	{
		[Export("Name")]
		public string Name { get; set;}

		[Export("Phone")]
		public string Phone { get; set;}

		[Export("Date")]
		public NSDate Date { get; set;}

		[Export("Time")]
		public NSDate Time { get; set;}

		[Export("Guests")]
		public int Guests { get; set;}

		[Export("Section")]
		public int Section { get; set;}

		[Export("Table")]
		public int Table { get; set;}


		[Export("Origin")]
		public int Origin { get; set;}







		public ReservationForm ()
		{
			this.Name = "";
			this.Phone = "";
			this.Date = new NSDate ();
			this.Time = new NSDate ();
			this.Guests = 1;
			this.Section = 0;
			this.Table = 0;
			this.Origin = 0;
		}
	}
}

