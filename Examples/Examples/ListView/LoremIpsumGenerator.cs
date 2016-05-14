using System;
using System.Collections.Generic;
using System.Text;

using Foundation;

namespace Examples
{
	[Register("LoremIpsumGenerator")]
	public class LoremIpsumGenerator
	{
		string[] words = new string[] {"lorem", "ipsum", "dolor", "sit", "amet", "consectetuer", "adipiscing", "elit", "integer", "in", "mi", "a", "mauris"};
		Dictionary<NSIndexPath, string> rows = new Dictionary<NSIndexPath, string> ();

		public string GenerateString(int wordCount)
		{
			StringBuilder str = new StringBuilder ();
			Random r = new Random ();
			for (int i = 0; i < wordCount; i++) {
				str.Append (words [r.Next(0, words.Length)]);
				str.Append (" ");
			}

			return str.ToString ();
		}

		public string RandomString(int wordCount, NSIndexPath indexPath)
		{
			string text = null;
			if (rows.ContainsKey (indexPath)) {
				text = rows [indexPath];
			} else {
				text = this.GenerateString (wordCount);
				rows [indexPath] = text;
			}

			return text;
		}
	}
}

