using System;
using TelerikUI;
using Foundation;

namespace Examples
{
	public class PasswordValidator : TKDataFormValidator
	{
		bool shortPassword;

		public PasswordValidator ()
		{
		}

		public override string ValidationMessage {
			get {
				if (shortPassword) {
					return "Password must be at least 6 characters";
				}

				return null;
			}
		}

		public override bool ValidateProperty (TKDataFormEntityProperty property)
		{
			shortPassword = false;
			NSString password = (NSString)property.Value;
			if (password.Length < 6) {
				shortPassword = true;
			}

			return true;
		}

	}
}

