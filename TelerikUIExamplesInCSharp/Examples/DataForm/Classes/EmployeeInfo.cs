using System;
using Foundation;

namespace Examples
{
	public class EmployeeInfo : NSObject
	{
		[Export ("GivenNames")]
		public string GivenNames { get; set; }

		[Export ("Surname")]
		public string Surname { get; set; }

		[Export ("Gender")]
		public int Gender { get; set; }

		[Export ("IdNumber")]
		public NSNumber IdNumber { get; set; }

		[Export ("EmployeeId")]
		public NSNumber EmployeeId { get; set; }

		[Export ("DateOfBirth")]
		public NSDate DateOfBirth { get; set; }

		[Export ("PhoneNumber")]
		public string PhoneNumber { get; set; }

		public EmployeeInfo ()
		{
			this.GivenNames = "";
			this.Surname = "";
			this.Gender = 0;
			this.IdNumber = new NSNumber (123456);
			this.EmployeeId = new NSNumber(123456);
			this.DateOfBirth = new NSDate ();
			this.PhoneNumber = "";
		}
	}
}

