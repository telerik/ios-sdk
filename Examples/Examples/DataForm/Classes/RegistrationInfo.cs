using System;
using Foundation;

namespace Examples
{
	public class RegistrationInfo : NSObject
	{
		[Export("Name")]
		public string Name{ get; set;}

		[Export("DateOfBirth")]
		public NSDate DateOfBirth{ get; set;}

		[Export("Gender")]
		public int Gender { get; set;}

		[Export("Country")]
		public int Country { get; set;}

		[Export("Email")]
		public string Email { get; set;}

		[Export("Password")]
		public string Password { get; set;}

		[Export("RepeatPassword")]
		public string RepeatPassword { get; set;}

		[Export("RememberMe")]
		public bool RememberMe{ get; set;}


		public RegistrationInfo ()
		{
			this.Email = "";
			this.Password = "";
			this.RepeatPassword = "";
			this.RememberMe = true;
			this.Name = "";
			this.DateOfBirth = new NSDate ();
			this.Gender = 0;
			this.Country = 0;
		}
	}
}

