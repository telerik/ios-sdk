using System;
using TelerikUI;
using Foundation;

namespace Examples
{
	public class EmailValidator : TKDataFormValidator
	{
		bool emptyField;
		bool incorrectFormat;

		public EmailValidator ()
		{
		}

		public override string ValidationMessage {
			get {
				if (emptyField) {
					return "Email is required!";
				}

				if (incorrectFormat) {
					return "Incorrect email!";
				}

				return null;
			}
		}

		public override bool ValidateProperty (TKDataFormEntityProperty property)
		{
			emptyField = false;
			incorrectFormat = false;
			NSString email = (NSString)property.Value;
			if (email == null || email.Length == 0) {
				emptyField = true;
				return false;
			}

			string emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
			NSPredicate predicate = NSPredicate.FromFormat ("SELF MATCHES %@", (NSString)emailRegex);
			incorrectFormat = !predicate.EvaluateWithObject (email);
			if (incorrectFormat) {
				return false;
			}

			return true;
		}
	}
}

