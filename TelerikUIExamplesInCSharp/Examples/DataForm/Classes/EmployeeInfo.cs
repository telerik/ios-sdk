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
		public string IdNumber { get; set; }

		[Export ("EmployeeId")]
		public string EmployeeId { get; set; }

		[Export ("DateOfBirth")]
		public NSDate DateOfBirth { get; set; }

		[Export ("PhoneNumber")]
		public string PhoneNumber { get; set; }

		public EmployeeInfo ()
		{
			this.GivenNames = "";
			this.Surname = "";
			this.Gender = 0;
			this.IdNumber = "";
			this.EmployeeId = "";
			this.DateOfBirth = new NSDate ();
			this.PhoneNumber = "";
		}
	}
}

