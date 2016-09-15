using System;

using Foundation;

namespace Examples
{
	public class DataSourceItem: NSObject
	{
		public DataSourceItem(string name, float value, string group) 
		{
			this.Name = name;
			this.Value = value;
			this.Group = group;
		}

		[Export("Name")]
		public String Name { get; set; }

		[Export("Content")]
		public String Content { get; set; }

		[Export("Value")]
		public nfloat Value { get; set; }

		[Export("Group")]
		public String Group { get; set; }

		[Export("StartDate")]
		public NSDate StartDate { get; set; }

		[Export("EndDate")]
		public NSDate EndDate { get; set; }
	}
}

